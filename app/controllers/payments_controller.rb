class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @order = Order.find(params[:order_id])
    # Load the associated course or section based on the order type
    @item = @order.purchasable
  end

  def create
    @order = Order.find(params[:order_id])
    @order.amount_cents = @order.purchasable.price_cents

    if @order.purchasable_type == 'Course'
      product_name = @order.purchasable.title
      @order.order_sku = @order.purchasable.sku
      puts "Course: unit_amount = #{@order.amount_cents}"
    elsif @order.purchasable_type == 'Section'
      product_name = @order.purchasable.title
      @order.order_sku = @order.purchasable.sku
      puts "Section: unit_amount = #{@order.amount_cents}"
    else
      raise "Unknown purchasable type: #{@order.purchasable_type}"
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
