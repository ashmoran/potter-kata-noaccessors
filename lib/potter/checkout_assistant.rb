class CheckoutAssistant
  def initialize(checkout)
    @checkout = checkout
  end

  def sell_me_these_books(barcodes)
    barcodes.each do |barcode|
      @checkout.scan(barcode)
    end

    @checkout.total_items
  end
end
