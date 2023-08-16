class OrderRulesController < ApplicationController
    def new
        @customer = Customer.find(params[:customer_id])
    end

    def create
        @customer = Customer.find(params[:customer_id])
        @rule = @customer.order_rules.create(rule_params)

        redirect_to customer_path(@customer)
    end

    private
    def rule_params
        params.require(:order_rule).permit(:commodity, :dropoff_state, :pickup_state, :max_cars, :car_type_id)
    end
end
