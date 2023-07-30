class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def create
    if params[:course_id].present?
      course = Course.find(params[:course_id])
      @order = Order.create!(
        purchasable: course,
        course_sku: course.sku,
        amount: course.price,
        state: 'pending',
        user: current_user
      )
      @order.amount = params[:order][:amount]
    elsif params[:section_id].present?
      section = Section.find(params[:section_id])
      @order = Order.create!(
        purchasable: section,
        section_sku: section.sku,
        amount: section.price,
        state: 'pending',
        user: current_user
      )
      @order.amount = params[:order][:amount]
    end
    @order.save

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: @order.purchasable.title
          },
          unit_amount: @order.purchasable.price_cents
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
