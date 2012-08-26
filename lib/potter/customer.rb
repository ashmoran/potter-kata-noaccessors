class Customer
  def buy_books(barcodes, options)
    options[:from_shop].
      find_a_checkout_assitant_to_sell(to_customer: self).
      sell_me_these_books(barcodes)
  end
end
