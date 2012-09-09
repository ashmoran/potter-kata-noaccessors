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

  context "the kata edge case example" do
    let(:paper) { StringIO.new }

    it "answers the kata example" do
      # TODO: this should not be a message expectation
      customer.should_receive(:your_price_to_pay_is).with(BigDecimal.new("51.6"))
      customer.buy_books(%w[ A A B B C C D E ], from_shop: shop)
    end

    it "answers the kata example" do
      customer.buy_books(%w[ A A B B C C D E ], from_shop: shop, get_receipt_printed_on: paper)

      paper.string.chomp.should be == -<<-RECEIPT
        A - 8.0
        A - 8.0
        B - 8.0
        B - 8.0
        C - 8.0
        C - 8.0
        D - 8.0
        E - 8.0
        5 book set - -10.0
        3 book set - -2.4
        Total: 51.6
      RECEIPT
    end
  end
end
