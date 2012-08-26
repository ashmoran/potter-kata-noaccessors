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

class CheckoutAssistant
  def initialize(checkout)
    @checkout = checkout
  end

  def sell_me_these_books(barcodes)
    barcodes.each do |barcode|
      @checkout.scan(barcode)
    end

    @checkout.total_items
  end
end

class Checkout
  def initialize(receipt, special_offers)
    @receipt = receipt
    @special_offers = special_offers
  end

  def scan(barcode)
    @receipt.record_item(barcode)
    @special_offers.remember_item(barcode)
  end

  def total_items
    @special_offers.apply_discounts(@receipt)
    @receipt.print_total
  end
end

class Receipt
  def initialize(customer)
    @customer = customer
    @total = 0
  end

  def record_item(barcode)
    @total += 8
  end

  def print_total
    @customer.your_price_to_pay_is(@total)
  end
end
