require 'bigdecimal'

class SpecialOffers
  def initialize
    @items = Hash.new(0)
  end

  def remember_item(barcode)
    @items[barcode] += 1
  end

  def apply_discounts(receipt)
    items = @items.dup

    while (set_size = items.select { |barcode, count| count >= 1 }.keys.length) >= 2
      discount =
        case set_size
        when 2
          BigDecimal.new("0.05")
        when 3
          BigDecimal.new("0.1")
        when 4
          BigDecimal.new("0.2")
        when 5
          BigDecimal.new("0.25")
        else
          0
        end

      receipt.record_item("#{set_size} book set", -(discount * set_size * 8))

      items.keys.each do |key|
        items[key] -= 1
      end
    end
  end
end
