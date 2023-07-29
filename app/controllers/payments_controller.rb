class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @order = Order.find(params[:order_id])
    # Load the associated course or section based on the order type
    @item = @order.course || @order.section
  end

  def create
    @order = Order.find(params[:order_id])

    if @order.course.present?
      product_name = @order.course.title
    elsif @order.section.present?
      product_name = @order.section.title
    else
      # Handle the case where neither course nor section is present
      # You can raise an error, redirect, or handle it as appropriate for your application.
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: product_name
          },
          unit_amount: @order.amount_cents
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: order_url(@order),
      cancel_url: order_url(@order)
    )

    @order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(@order)
  end

  private

  def authorize_user!
    authorize Order, :admin?
  end
end
