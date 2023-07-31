class CompleteOrderJob
  include Sidekiq::Job

  def perform(order_id)
    order = Order.find(order_id)

    OrderCreator.new.complete_order(order)
  rescue BaseServiceWrapper::HTTPError => ex
    raise IgnorableExceptionsSinceSidekiqWillRetry.new(ex)
  end
end
