class SpecialOffers
  def initialize
    @items = []
  end

  def remember_item(barcode)
    @items << barcode
  end

  def apply_discounts(receipt)
    if @items.include?("A") && @items.include?("B")
      receipt.record_item("Two book set", -0.8)
    end
  end
end
