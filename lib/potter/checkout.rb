class Checkout
  def initialize(receipt, special_offers)
    @receipt = receipt
    @special_offers = special_offers
  end

  def scan(barcode)
    @receipt.record_item(barcode)
    @special_offers.remember_item(barcode)
  end

  def total_items
    @special_offers.apply_discounts(@receipt)
    @receipt.print_total
  end
end
