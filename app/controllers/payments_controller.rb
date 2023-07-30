class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @order = Order.find(params[:order_id])
  end

  def create
    @order = Order.find(params[:order_id])

    if @order.purchasable_type == 'Course'
      product_name = @order.purchasable.title
      unit_amount = @order.amount_cents
      puts "Course: unit_amount = #{unit_amount}"
    elsif @order.purchasable_type == 'Section'
      product_name = @order.purchasable.title
      unit_amount = @order.purchasable.price_cents
      puts "Section: unit_amount = #{unit_amount}"
    else
      raise "Unknown purchasable type: #{@order.purchasable_type}"
    end

    if unit_amount.zero?
      raise "Unit amount cannot be zero for payment"
    end

    # The rest of the code remains the same
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: product_name
          },
          unit_amount:
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
