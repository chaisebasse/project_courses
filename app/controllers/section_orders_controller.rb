class SectionOrdersController < ApplicationController
  def show
    @order = current_user.section_orders.find(params[:id])
  end

  def create
    section = Course.find(params[:section_id])
    section_order = Order.create!(
      section:,
      section_sku: section.sku,
      amount: section.price,
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
            name: section.title
          },
          unit_amount: section.price_cents
        },
        quantity: 1
      }],
      mode: 'payment', # You can use 'payment' or 'subscription' depending on your use case
      success_url: order_url(section_order),
      cancel_url: order_url(section_order)
    )

    section_order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(section_order)
  end
end
