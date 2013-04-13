class OrderNotifier < ActionMailer::Base
  default from: 'Ruslan Khaertdinov <ruslanimos@gmail.com>'

  def received(order)
    @order = order
    mail to: order.email, subject: 'Order Confirmation'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Order Shipped'
  end
end
