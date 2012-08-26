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

class Customer
  def buy_books(barcodes, options)
    options[:from_shop].
      find_a_checkout_assitant_to_sell(to_customer: self).
      sell_me_these_books(barcodes)
  end
end
