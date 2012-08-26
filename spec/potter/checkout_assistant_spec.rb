require 'spec_helper'

require 'potter/checkout_assistant'
require 'potter/checkout'

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
