class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @order = Order.find(params[:order_id])
    # Load the associated course or section based on the order type
    @item = @order.course || @order.section
  end

  def create
    if params[:course_id].present? # Course order
      course = Course.find(params[:course_id])
      order = Order.create!(
        course:,
        course_sku: course.sku,
        amount: course.price,
        state: 'pending',
        user: current_user
      )
    elsif params[:section_id].present? # Section order
      section = Section.find(params[:section_id])
      order = Order.create!(
        section:,
        section_sku: section.sku,
        amount: section.price,
        state: 'pending',
        user: current_user
      )
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: order.course.title || order.section.title
          },
          unit_amount: order.amount_cents
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
