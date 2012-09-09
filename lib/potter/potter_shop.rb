require 'devnull'

require 'potter/checkout'
require 'potter/checkout_assistant'
require 'potter/receipt'
require 'potter/special_offers'

class PotterShop
  def find_a_checkout_assistant_to_sell(options)
    CheckoutAssistant.new(
      Checkout.new(
        Receipt.new(options.fetch(:to_customer), options.fetch(:print_receipt_on)),
        SpecialOffers.new
      )
    )
  end
end
