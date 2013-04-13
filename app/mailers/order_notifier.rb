class OrderNotifier < ActionMailer::Base
  default from: 'Store Admin <admin@store.com>'

  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(to: user.email, subject: "Welcome to My Awesome Site")
  end

  def received(order)
    @order = order
    mail to: order.email, subject: 'Order Confirmation'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Order Shipped'
  end
end
