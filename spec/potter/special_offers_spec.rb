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

    context "two different books" do
      it "applies a 5% discount" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")

        receipt.should_receive(:record_item).with("2 book set", BigDecimal.new("-0.8"))
        special_offers.apply_discounts(receipt)
      end
    end

    context "two different books among three" do
      it "applies a 5% discount" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")
        special_offers.remember_item("B")

        receipt.should_receive(:record_item).with("2 book set", BigDecimal.new("-0.8"))
        special_offers.apply_discounts(receipt)
      end
    end

    context "three different books" do
      it "applies a 10% discount" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")
        special_offers.remember_item("C")

        receipt.should_receive(:record_item).with("3 book set", BigDecimal.new("-2.4"))
        special_offers.apply_discounts(receipt)
      end
    end

    context "four different books" do
      it "applies a 20% discount" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")
        special_offers.remember_item("C")
        special_offers.remember_item("D")

        receipt.should_receive(:record_item).with("4 book set", BigDecimal.new("-6.4"))
        special_offers.apply_discounts(receipt)        
      end
    end

    context "five different books" do
      it "applies a 25% discount" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")
        special_offers.remember_item("C")
        special_offers.remember_item("D")
        special_offers.remember_item("E")

        receipt.should_receive(:record_item).with("5 book set", BigDecimal.new("-10"))
        special_offers.apply_discounts(receipt)
      end
    end

    context "a set of three and a set of two" do
      it "applies both discounts" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")
        special_offers.remember_item("C")

        special_offers.remember_item("B")
        special_offers.remember_item("C")

        receipt.should_receive(:record_item).with("3 book set", BigDecimal.new("-2.4"))
        receipt.should_receive(:record_item).with("2 book set", BigDecimal.new("-0.8"))
        special_offers.apply_discounts(receipt)
      end
    end

    context "a set of four and a set of three and a set of two" do
      it "applies both discounts" do
        special_offers.remember_item("A")
        special_offers.remember_item("B")
        special_offers.remember_item("C")
        special_offers.remember_item("D")

        special_offers.remember_item("B")
        special_offers.remember_item("C")
        special_offers.remember_item("D")

        special_offers.remember_item("D")
        special_offers.remember_item("E")

        receipt.should_receive(:record_item).with("4 book set", BigDecimal.new("-6.4"))
        receipt.should_receive(:record_item).with("3 book set", BigDecimal.new("-2.4"))
        receipt.should_receive(:record_item).with("2 book set", BigDecimal.new("-0.8"))
        special_offers.apply_discounts(receipt)
      end
    end
  end
end
