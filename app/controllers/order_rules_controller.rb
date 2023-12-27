class OrderRulesController < ApplicationController
    def index
    end

    def new
        @customer = Customer.find(params[:customer_id])
        @rule = @customer.order_rules.build
    end

    def create
        @customer = Customer.find(params[:customer_id])
        @rule = @customer.order_rules.create(rule_params)

        if @rule.save
            redirect_to customer_path(@customer)
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @customer = Customer.find(params[:customer_id])
        @rule = @customer.order_rules.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:customer_id])
        @rule = @customer.order_rules.find(params[:id])

        if @rule.update(rule_params)
            redirect_to customer_path(@customer)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @customer = Customer.find(params[:customer_id])
        @rule = @customer.order_rules.find(params[:id])
        @rule.destroy

        redirect_to customer_path(@customer)
    end

    private
    def rule_params
        params.require(:order_rule).permit(:car_type_id, :commodity, :manutention_time, :max_cars, :is_loaded)
    end
end
