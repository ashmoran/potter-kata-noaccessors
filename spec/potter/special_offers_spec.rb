require 'spec_helper'

require 'potter/special_offers'

class Receipt; end

describe SpecialOffers do
  subject(:special_offers) { SpecialOffers.new }

  describe "#remember_item" do
    it "doesn't throw an error" do
      special_offers.remember_item("A")
    end

    it "does something useful" do
      pending
    end
  end

  describe "#apply_discounts" do
    let(:receipt) { mock(Receipt) }

    it "doesn't throw an error" do
      special_offers.apply_discounts(receipt)
    end

    it "does something useful" do
      pending
    end
  end
end
