class OrdersGenerationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts 'Generating orders...'
    # Gather all customers
    customers = Customer.all
    customers.each do |c|
      # Check this customer OrderRules
      c.order_rules.each do |r|
        total_cars = r.orders.sum("ordered_count")
        puts "Customer '#{c.name}' : #{total_cars} / #{r.max_cars} of #{r.commodity}."
        if total_cars >= r.max_cars
          next
        end

        # We have room for a new order.
        number_of_cars = rand(1..r.max_cars - total_cars)
        puts ">>> Ordering #{number_of_cars} cars of #{r.commodity}."
        order = Order.new
        order.ordered_count = number_of_cars
        order.order_rule_id = r.id
        order.status = :pending
        order.routing_tag = "#{c.yard.yard.routing_tag} #{c.yard.routing_tag} #{c.routing_tag}"
        order.save
      end
    end
  end
end
