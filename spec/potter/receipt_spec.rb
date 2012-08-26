require 'spec_helper'

require 'potter/receipt'
require 'potter/customer'

describe Receipt do
  let(:customer) { mock(Customer, your_price_to_pay_is: nil) }
  subject(:receipt) { Receipt.new(customer) }

  describe "#print_total" do
    it "prints the total based on the line items" do
      receipt.record_item("FOO", 10)
      receipt.record_item("BAR", 5)

      customer.should_receive(:your_price_to_pay_is).with(15)
      receipt.print_total
    end

    it "defaults the price" do
      receipt.record_item("FOO")
      receipt.record_item("BAR")

      customer.should_receive(:your_price_to_pay_is).with(16)
      receipt.print_total
    end

    it "makes price explicit, and not defaulted"
  end
end
