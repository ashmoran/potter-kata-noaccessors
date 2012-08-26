require 'potter/checkout'
require 'potter/checkout_assistant'
require 'potter/receipt'
require 'potter/special_offers'

class PotterShop
  def find_a_checkout_assitant_to_sell(options)
    customer        = options[:to_customer]
    receipt         = Receipt.new(customer)
    special_offers  = SpecialOffers.new
    checkout        = Checkout.new(receipt, special_offers)
    CheckoutAssistant.new(checkout)
  end
end
