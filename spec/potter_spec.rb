require 'spec_helper'

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
