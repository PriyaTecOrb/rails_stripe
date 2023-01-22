class Stripe::AddCard < ApplicationService 
  require "stripe"
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']

  def createCustomerCard user,cardToken,auth
    cToken = (auth.role == "user"  ? user.stripe_customer_token : user.stripe_driver_token) 
    if cToken.present?
      card = createCard(user,cardToken,cToken)
      if card[:code]==200
        {code: 200, cToken: cToken, msg: "Customer created",:card=>card[:cId],:customer=>card[:customer]}
      else
        {code: 400, msg: card[:msg]}
      end
    else
      begin
        customer = Stripe::Customer.create({
          description: "User id #{user.contact}, FROM: #{ENV['cloud_develop']}",
          email: auth.email,
          name: "#{auth.full_name}", 
          source: cardToken  # obtained with Stripe.js
        })
        (auth.role == "user" ? user.update(stripe_customer_token: customer.id) : user.update(stripe_driver_token: customer.id))
        card = createCard(user,cardToken,customer.id)
        if card[:code]==200
          {code: 200, cToken: customer.id, msg: "Customer created",:card=>card[:cId],:customer=>card[:customer]}
        else
          {code:400,msg:card[:msg]}
        end
      rescue  Exception => e
        {code: 400, msg: e.message}
      end 
    end
  end

end