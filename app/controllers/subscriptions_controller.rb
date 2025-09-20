class SubscriptionsController < ApplicationController
  # before_action :authenticate_user! # if using Devise

  def create
    price_id = params[:price_id]

    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      mode: 'subscription',
      customer_email: current_user.email,
      line_items: [{
        price: price_id,
        quantity: 1,
      }],
      success_url: root_url + "?success=true",
      cancel_url: root_url + "?cancelled=true"
    })

    redirect_to session.url, allow_other_host: true
  end
end
