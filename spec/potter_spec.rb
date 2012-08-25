require 'spec_helper'

class Checkout
  def initialize(receipt, special_offers)
    @receipt = receipt
    @special_offers = special_offers
    @total = 0
  end
  
  def scan(barcode)
    @special_offers.remember_item(barcode)
    @total += 8
  end

  def total_items
    @receipt.print_total(@total)
  end
end

describe "Potter" do
  let(:receipt) { mock("Receipt", print_total: nil) }
  let(:special_offers) { mock("SpecialOffers", remember_item: nil) }
  subject(:checkout) { Checkout.new(receipt, special_offers) }

  # # SpecialOffers interface
  # before(:each) do
  #   @special_offers_scanned_items = [ ]
  # end

  # def item_scanned(barcode)
  #   @special_offers_scanned_items << barcode
  # end

  # def special_offers_scanned_items
  #   @special_offers_scanned_items
  # end

  context "one book" do
    it "is standard price" do
      checkout.scan("A")
      receipt.should_receive(:print_total).with(8)
      checkout.total_items
    end
  end

  context "two same books" do
    it "is standard price" do
      checkout.scan("A")
      checkout.scan("A")
      checkout.total_items
      receipt.should_receive(:print_total).with(16)
      checkout.total_items
    end
  end

  context "two different books" do
    it "informs the SpecialOffers" do
      special_offers.should_receive(:remember_item).with("A")
      special_offers.should_receive(:remember_item).with("B")

      checkout.scan("A")
      checkout.scan("B")
    end

  #   it "applies discounts" do
  #     checkout.scan("A")
  #     checkout.scan("B")

  #     checkout.total_items
  #   end

  #   it "has a 10% discount" do
  #     checkout.scan("A")
  #     checkout.scan("B")
  #     checkout.total_items

  #     total.should be == 14.4
  #   end
  end
end
