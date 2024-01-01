class TrainsController < ApplicationController
    def index
        @trains = Train.all
    end

    def show
        @train = Train.find(params[:id])
    end

    def new
        @train = Train.new
        @yard = Yard.new
    end

    def create
        if params[:commit] == nil
            @train = Train.new(train_params.except(:yard_id))
            @yard = Yard.find(params[:train][:yard_id])

            render :new, status: :unprocessable_entity # Not really unprocessable, but it's needed for turbo to rerender
        else
            @train = Train.new(train_params.except(:yard_id))
            if @train.save
                redirect_to trains_path
            else
                render :new, status: :unprocessable_entity
            end
        end
    end

    def destroy
        @train = Train.find(params[:id])
        @train.destroy

        redirect_to trains_path
    end

    def spawn_train
        # - Get a random blueprint
        # - Using the blueprint, trying to create a train with a ratio of customer's orders on it.
        # - Translate the train to a Run8 compatible XML file, to serve to the user.
        # - Add a train in the database
        min_id = 1
        max_id = SupplyTrainBlueprint.maximum(:id)
        rnd_id = rand(min_id..max_id)
        unless SupplyTrainBlueprint.exists?(rnd_id)
            rnd_id = min_id
        end

        blueprint = SupplyTrainBlueprint.find(rnd_id)
        deviation = 0.5
        min_cars = (blueprint.avg_cars*(1-deviation)).to_int
        max_cars = (blueprint.avg_cars*(1+deviation)).to_int
        train_cars = rand(min_cars..max_cars)

        min_ratio = 1.0/3.0
        max_ratio = 2.0/3.0
        max_orders_ratio = rand(min_ratio..max_ratio)
        max_orders = (train_cars*max_orders_ratio).to_int

        num_orders = 0
        distance_travelled = 0.0
        previous_car_coupler_offset = 0.0
        @cars = []
        i = 0
        while i <= train_cars do
            p = rand(0.0..1.0)
            if p >= 1-max_orders_ratio and num_orders <= max_orders
                # This should be a customer's order
                pending_orders = Order.pending
                min_order_index = 0
                max_order_index = pending_orders.count - 1
                order_index = rand(min_order_index..max_order_index)
                order = pending_orders[order_index]
                rule = order.order_rule
                models = rule.car_type.car_models

                for j in 1..order.ordered_count do
                    min_model_index = 0
                    max_model_index = models.count - 1
                    model_index = rand(min_model_index..max_model_index)
                    model = models[model_index]
                    coupler_offset = model.coupler_offset
                    bolster_length = model.bolster_length
                    avg_coupler_offset = (coupler_offset + previous_car_coupler_offset) / 2.0
                    distance_travelled_x = distance_travelled + avg_coupler_offset
                    distance_travelled = distance_travelled_x + bolster_length
                    previous_car_coupler_offset = coupler_offset
                    not_reversed = rand(0.0..1.0) >= 0.5
                    tons = 0.0

                    if rule.is_loaded
                        min_tons = model.max_weight * 0.7
                        tons = rand(min_tons..model.max_weight)
                    end

                    if not_reversed
                        @cars << {
                          tag: order.routing_tag,
                          distance_x: distance_travelled_x,
                          distance_y: distance_travelled,
                          reversed: not_reversed,
                          tons: tons,
                          model_xml: model.FQDN
                        }
                    else
                        @cars << {
                          tag: order.routing_tag,
                          distance_x: distance_travelled,
                          distance_y: distance_travelled_x,
                          reversed: not_reversed,
                          tons: tons,
                          model_xml: model.FQDN
                        }
                    end
                end

                num_orders += order.ordered_count
                i += order.ordered_count
            else
                # Generate a random pass through
                destinations = blueprint.destination.split(',')
                min_destination_index = 0
                max_destination_index = destinations.count - 1
                destination_index = rand(min_destination_index..max_destination_index)

                min_ordered_cars = 1
                max_ordered_cars = 3
                ordered_cars = rand(min_ordered_cars..max_ordered_cars)
                car_types = CarType.all
                min_type_index = 0
                max_type_index = car_types.count - 1
                car_type_index = rand(min_type_index..max_type_index)
                models = car_types[car_type_index].car_models

                for j in 1..ordered_cars do
                    min_model_index = 0
                    max_model_index = models.count - 1
                    model_index = rand(min_model_index..max_model_index)
                    model = models[model_index]
                    coupler_offset = model.coupler_offset
                    bolster_length = model.bolster_length
                    avg_coupler_offset = (coupler_offset + previous_car_coupler_offset) / 2.0
                    distance_travelled_x = distance_travelled + avg_coupler_offset
                    distance_travelled = distance_travelled_x + bolster_length
                    previous_car_coupler_offset = coupler_offset
                    not_reversed = rand(0.0..1.0) >= 0.5
                    tons = 0.0

                    if rand(0.0..1.0) >= 0.5
                        tons = rand(0.0..model.max_weight)
                    end

                    if not_reversed
                        @cars << {
                          tag: destinations[destination_index],
                          distance_x: distance_travelled_x,
                          distance_y: distance_travelled,
                          reversed: not_reversed,
                          tons: tons,
                          model_xml: model.FQDN
                        }
                    else
                        @cars << {
                          tag: destinations[destination_index],
                          distance_x: distance_travelled,
                          distance_y: distance_travelled_x,
                          reversed: not_reversed,
                          tons: tons,
                          model_xml: model.FQDN
                        }
                    end
                end
                i += ordered_cars
            end
        end

        send_data build_run8_xml.to_xml, type: :xml, filename: "train.xml", disposition: "attachment"
    end

    private
    def train_params
        params.require(:train).permit(:routing_tag, :length, :weigth, :yard_id, :track_id)
    end

    #noinspection RubyResolve
    def build_run8_xml
        Nokogiri::XML::Builder.new do |xml|
            xml.ScnLoader('xmlns:xsd' => "http://www.w3.org/2001/XMLSchema", 'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance" ) {
                xml.trainList {
                    xml.TrainLoader {
                        xml.unitLoaderList {
                          @cars.each do |car|
                              xml.RailVehicleStateClass {
                                  xml.rvXMLfilename "#{car[:model_xml]}.xml"
                                  xml.unitType "US_Freightcar"
                                  xml.currentRoutePrefix {
                                      xml.int "110"
                                      xml.int "110"
                                  }
                                  xml.currentTrackSectionIndex {
                                      xml.int "2817"
                                      xml.int "2817"
                                  }
                                  xml.startNodeIndex {
                                      xml.int "0"
                                      xml.int "0"
                                  }
                                  xml.distanceTravelledInMeters {
                                      xml.float car[:distance_x]
                                      xml.float car[:distance_y]
                                  }
                                  xml.reverseDirection {
                                      xml.boolean car[:reversed]
                                      xml.boolean car[:reversed]
                                  }
                                  xml.loadWeightUSTons car[:tons]
                                  xml.destinationTag car[:tag]
                              }
                          end
                        }
                    }
                }
            }
        end
    end
end
