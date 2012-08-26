require 'bigdecimal'

class SpecialOffers
  def initialize
    @items = []
  end

  def remember_item(barcode)
    @items << barcode
  end

  def apply_discounts(receipt)
    if @items.include?("A") && @items.include?("B") && @items.include?("C")
      receipt.record_item("Three book set", -(8 * 3 * BigDecimal.new("0.1")))
    elsif @items.include?("A") && @items.include?("B")
      receipt.record_item("Two book set", -(8 * 2 * BigDecimal.new("0.05")))
    end
  end
end
