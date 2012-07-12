require 'spec_helper'

class VendingMachine
  class UnknownItemError < ArgumentError
    def initialize(item)
      @item = item
    end

    def message
      "Unknown item: #{@item}"
    end
  end

  def initialize(dispenser, options)
    @dispenser = dispenser
    @items = options[:items]
  end

  def vend(item = nil)
    if @items.include?(item)
      @dispenser.release_item(item)      
    else
      raise UnknownItemError.new(item)
    end
  end
end

describe VendingMachine do
  context "multiple items, no charge, stock unlimited" do
    let(:dispenser) { double("Dispenser", release_item: nil) }
    subject(:vending_machine) { VendingMachine.new(dispenser, items: [:crisps, :cola]) }

    context "known items" do
      it "vends the requested item" do
        dispenser.should_receive(:release_item).with(:crisps)
        vending_machine.vend(:crisps)
      end      
    end
    
    context "unknown item" do
      it "raises an error" do
        expect {
          vending_machine.vend(:porridge)
        }.to raise_error(VendingMachine::UnknownItemError) { |error|
          error.message.should include("Unknown item")
          error.message.should include("porridge")
        }
      end
    end
  end
end