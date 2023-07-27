class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def show
    @order = current_user.orders.find(params[:id])
  end
  
  def create
    course = Course.find(params[:course_id])
    order  = Order.create!(
      course:,
      course_sku: course.sku,
      amount: course.price,
      state: 'pending',
      user: current_user
    )

    # course.sections.each do |section|
    #   Order.create!(
    #     course:,
    #     course_sku: section.sku,
    #     amount: section.price,
    #     state: 'pending',
    #     user:
    #   )
    # end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: course.title,
          },
          unit_amount: course.price_cents
        },
        quantity: 1
      }],
      mode: 'payment', # You can use 'payment' or 'subscription' depending on your use case
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  private

  def authorize_user!
    authorize Order, :admin?
  end
end
