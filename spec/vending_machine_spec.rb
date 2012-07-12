require 'spec_helper'

class VendingMachine
  def vend
    
  end
end

describe VendingMachine do
  subject(:vending_machine) { VendingMachine.new }

  it "vends" do
    vending_machine.vend
  end
end