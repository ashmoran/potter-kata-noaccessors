require 'spec_helper'

require 'potter/potter_shop'
require 'potter/customer'
require 'potter/checkout_assistant'

describe PotterShop do
  let(:customer) { mock(Customer) }
  subject(:shop) { PotterShop.new }

  describe "#find_a_checkout_assistant_to_sell" do
    it "builds a CheckoutAssistant" do
      shop.
        find_a_checkout_assistant_to_sell(
        	to_customer: customer, print_receipt_on: StringIO.new
        ).should be_a(CheckoutAssistant)
    end
  end
end
