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
        order_sku: course.sku,
        amount: course.price,
        state: 'pending',
        user: current_user
      )
    elsif params[:section_id].present?
      section = Section.find(params[:section_id])
      @order = Order.create!(
        purchasable: section,
        order_sku: section.sku,
        amount: section.price,
        state: 'pending',
        user: current_user
      )
    end
    @order.amount = params[:order][:amount]
  end

  private

  def authorize_user!
    authorize Order, :admin?
  end
end
