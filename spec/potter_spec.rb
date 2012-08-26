require 'spec_helper'

class PotterShop
  def sell(barcodes, options)
    customer        = options[:to_customer]
    receipt         = Receipt.new(customer)
    special_offers  = SpecialOffers.new
    checkout        = Checkout.new(receipt, special_offers)
  end
end

class Customer
  def buy_books(barcodes, options)
    options[:from_shop].sell(barcodes, to_customer: self)
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

class SpecialOffers
  
end

describe PotterShop do
  let(:customer) { Customer.new }
  subject(:shop) { PotterShop.new }

  it "tells the customer what they owe", pending: true do
    customer.buy_books(%w[ A A ], from_shop: shop)
    # TODO: this should not me a message expectation
    customer.should_receive(:your_price_to_pay_is).with(16)
  end

  # describe "#sell" do
  #   it "makes a receipt" do
  #     Receipt.should_receive(:new).with(customer)
  #   end
  # end
end

describe Customer do
  let(:shop) { mock(PotterShop) }
  subject(:customer) { Customer.new }

  describe "#buy_books" do
    it "asks the shop for the books" do
      shop.should_receive(:sell).with(%w[ A A ], to_customer: customer)
      customer.buy_books(%w[ A A ], from_shop: shop)
    end
  end
end

describe Checkout do
  let(:receipt) {
    mock("Receipt", print_total: nil, record_item: nil)
  }
  let(:special_offers) {
    mock("SpecialOffers", remember_item: nil, apply_discounts: nil)
  }

  subject(:checkout) { Checkout.new(receipt, special_offers) }

  describe "scanning" do
    it "informs the Receipt" do
      receipt.should_receive(:record_item).with("A")
      checkout.scan("A")
    end

    it "informs the SpecialOffers" do
      special_offers.should_receive(:remember_item).with("A")
      checkout.scan("A")
    end
  end

  describe "totalling" do
    it "applies discounts" do
      special_offers.should_receive(:apply_discounts).with(receipt)
      checkout.total_items
    end

    it "prints the total" do
      receipt.should_receive(:print_total)
      checkout.total_items
    end
  end
end

describe Receipt do
  let(:customer) { mock(Customer, your_price_to_pay_is: nil) }
  subject(:receipt) { Receipt.new(customer) }

  describe "#print_total" do
    it "prints the total based on the line items" do
      receipt.record_item("A")
      receipt.record_item("A")

      customer.should_receive(:your_price_to_pay_is).with(16)
      receipt.print_total
    end
  end
end