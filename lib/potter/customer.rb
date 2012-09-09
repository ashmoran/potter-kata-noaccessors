class Customer
  def buy_books(barcodes, options)
    options.fetch(:from_shop).
      find_a_checkout_assistant_to_sell(
      	to_customer: self,
      	print_receipt_on: options.fetch(:get_receipt_printed_on, DevNull.new)
      ).
      sell_me_these_books(barcodes)
  end

  def your_price_to_pay_is(price)
  	
  end
end
