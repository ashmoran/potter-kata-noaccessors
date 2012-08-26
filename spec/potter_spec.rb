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
