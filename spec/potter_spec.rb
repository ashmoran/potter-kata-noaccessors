require 'spec_helper'

require 'potter'

describe "Potter" do
  let(:customer) { Customer.new }
  subject(:shop) { PotterShop.new }

  it "tells the customer what they owe" do
    # TODO: this should not be a message expectation
    customer.should_receive(:your_price_to_pay_is).with(16)
    customer.buy_books(%w[ A A ], from_shop: shop)
  end

  it "applies discounts" do
    # TODO: this should not be a message expectation
    customer.should_receive(:your_price_to_pay_is).with(BigDecimal.new("15.2"))
    customer.buy_books(%w[ A B ], from_shop: shop)
  end

  it "answers the kata example" do
    # TODO: this should not be a message expectation
    customer.should_receive(:your_price_to_pay_is).with(BigDecimal.new("52.20"))
    customer.buy_books(%w[ A A B B C C D E ], from_shop: shop)
  end
end
