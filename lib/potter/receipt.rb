require 'devnull'

class Receipt
  def initialize(customer, paper = DevNull.new)
    @customer = customer
    @paper = paper
    @total = 0
  end

  def record_item(barcode, price = 8)
    @total += price
    @paper.puts("#{barcode} - #{format_price(price)}")
  end

  def print_total
    @paper.puts("Total: #{format_price(@total)}")
    @customer.your_price_to_pay_is(BigDecimal.new(@total))
  end

  private

  def format_price(price)
    BigDecimal.new(price).to_s("F")
  end
end
