require 'spec_helper'

require 'potter'

describe PotterShop do
  let(:customer) { Customer.new }
  subject(:shop) { PotterShop.new }

  describe "#find_a_checkout_assitant_to_sell" do
    it "builds a CheckoutAssistant" do
      shop.
        find_a_checkout_assitant_to_sell(to_customer: customer).
        should be_a(CheckoutAssistant)
    end
  end

  it "tells the customer what they owe" do
    # TODO: this should not me a message expectation
    customer.should_receive(:your_price_to_pay_is).with(16)
    customer.buy_books(%w[ A A ], from_shop: shop)
  end
end

describe Customer do
  let(:checkout_assistant) { mock(CheckoutAssistant, sell_me_these_books: nil) }
  let(:shop) { mock(PotterShop, find_a_checkout_assitant_to_sell: checkout_assistant) }
  subject(:customer) { Customer.new }

  describe "#buy_books" do
    it "finds a CheckoutAssistant" do
      shop.should_receive(:find_a_checkout_assitant_to_sell).with(to_customer: customer)
      customer.buy_books(%w[ A A ], from_shop: shop)
    end

    it "asks to buy the books" do
      checkout_assistant.should_receive(:sell_me_these_books).with(%w[ A A ])
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

describe CheckoutAssistant do
  let(:checkout) { mock(Checkout, scan: nil, total_items: nil) }
  subject(:checkout_assistant) { CheckoutAssistant.new(checkout) }

  describe "#sell_me_these_books" do
    it "scans all the items" do
      checkout.should_receive(:scan).with("A")
      checkout.should_receive(:scan).with("B")

      checkout_assistant.sell_me_these_books(%w[ A B ])
    end

    it "asks for the total" do
      checkout.should_receive(:total_items)
      checkout_assistant.sell_me_these_books(%w[ A B ])
    end
  end
end
