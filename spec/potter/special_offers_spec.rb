require 'spec_helper'

require 'potter/special_offers'
require 'potter/receipt'

describe SpecialOffers do
  subject(:special_offers) { SpecialOffers.new }

  describe "#apply_discounts" do
    let(:receipt) { mock(Receipt) }

    it "doesn't throw an error" do
      special_offers.apply_discounts(receipt)
    end

    context "no offers" do
      it "does nothing to the receipt" do
        special_offers.remember_item("A")
        special_offers.remember_item("A")

        receipt.should_not_receive(:record_item)
        special_offers.apply_discounts(receipt)
      end
    end
  end
end
