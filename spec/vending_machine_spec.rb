require 'spec_helper'

class VendingMachine
  def initialize(dispenser)
    @dispenser = dispenser 
  end

  def vend
    @dispenser.release_item
  end
end

describe VendingMachine do
  let(:dispenser) { double("Dispenser", release_item: nil) }
  subject(:vending_machine) { VendingMachine.new(dispenser) }

  context "a single item, no charge, stock unlimited" do
    it "vends" do
      dispenser.should_receive(:release_item)
      vending_machine.vend
    end
  end

end