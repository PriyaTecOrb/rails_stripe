class Stripe::Token < ApplicationService 
  require "stripe"
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']

  def generate_token
    token = Stripe::Token.create({
      card: {
        number: '5555555555554444',
        exp_month: 9,
        exp_year: 2020,
        cvc: '314',
      },
    })
  end