class Receipt
  def initialize(customer)
    @customer = customer
    @total = 0
  end

  def record_item(barcode, price = 8)
    @total += price
  end

  def print_total
    @customer.your_price_to_pay_is(@total)
  end
end
