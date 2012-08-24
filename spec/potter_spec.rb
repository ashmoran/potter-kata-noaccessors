require 'spec_helper'

class Checkout
  def initialize(display)
    @display = display
    @total = 0
  end
  
  def scan(barcode)
    @total += 8
  end

  def total_items
    @display.show_total(@total)
  end
end

describe "Potter" do
  subject(:checkout) { Checkout.new(self) }

  # Display interface
  def show_total(total)
    @total = total
  end

  def total
    @total
  end

  context "one book" do
    it "is standard price" do
      checkout.scan("A")
      checkout.total_items
      total.should be == 8
    end
  end
  
  context "two same books" do
    it "is standard price" do
      checkout.scan("A")
      checkout.scan("A")
      checkout.total_items
      total.should be == 16
    end
  end
end