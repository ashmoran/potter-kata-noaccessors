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

  context "receipt paper is given" do
    let(:paper) { StringIO.new }
    subject(:receipt) { Receipt.new(customer, paper) }

    it "prints to any paper that behaves like an IO" do
      receipt.record_item("FOO", 10)
      receipt.record_item("BAR")
      receipt.print_total

      paper.string.chomp.should be == -<<-RECEIPT
        FOO - 10
        BAR - 8
        Total: 18
      RECEIPT
    end
  end

  context "nil paper is given" do
    subject(:receipt) { Receipt.new(customer, nil) }

    it "doesn't raise an error, because client code currently passes nil sometimes" do
      expect {
        receipt.record_item("BAR")
        receipt.print_total
      }.to_not raise_error
    end
  end
end
