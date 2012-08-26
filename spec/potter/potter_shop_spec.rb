require 'spec_helper'

require 'potter/potter_shop'
require 'potter/customer'
require 'potter/checkout_assistant'

describe PotterShop do
  let(:customer) { mock(Customer) }
  subject(:shop) { PotterShop.new }

  describe "#find_a_checkout_assitant_to_sell" do
    it "builds a CheckoutAssistant" do
      shop.
        find_a_checkout_assitant_to_sell(to_customer: customer).
        should be_a(CheckoutAssistant)
    end
  end
end
