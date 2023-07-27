class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @order = current_user.orders.where(state: 'pending').find(params[:order_id])
  end

  private

  def authorize_user!
    authorize Order, :admin?
  end
end
