require 'spec_helper'

require 'potter/customer'
require 'potter/checkout_assistant'
require 'potter/potter_shop'

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
