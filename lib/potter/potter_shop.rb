require 'potter/checkout'
require 'potter/checkout_assistant'
require 'potter/receipt'
require 'potter/special_offers'

class PotterShop
  def find_a_checkout_assitant_to_sell(options)
    CheckoutAssistant.new(
      Checkout.new(
        Receipt.new(options[:to_customer]),
        SpecialOffers.new
      )
    )
  end
end
