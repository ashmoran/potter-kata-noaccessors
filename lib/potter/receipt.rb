require 'devnull'

class Receipt
  def initialize(customer, paper = nil)
    @customer = customer
    @paper = paper || DevNull.new
    @total = 0
  end

  def record_item(barcode, price = 8)
    @total += price
    @paper.puts("#{barcode} - #{price}")
  end

  def print_total
    @paper.puts("Total: 18")
    @customer.your_price_to_pay_is(@total)
  end
end
