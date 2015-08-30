def update_quality(items)
  items.each do |item|

    sell_in = item.sell_in
    quality = item.quality

    # time passes...
    sell_in -= 1

    case item.name
    when /aged brie/i
      sell_in < 0 ? quality += 2 : quality += 1
    when /sulfuras/i
      next
    when /backstage pass(?:es)?/i
      case
      when sell_in < 0
        quality = 0
      when sell_in < 5
        quality += 3
      when sell_in < 10
        quality += 2
      else
        quality += 1
      end
    when /conjured/i
      sell_in < 0 ? quality -= 4 : quality -= 2
    else
      sell_in < 0 ? quality -= 2 : quality -= 1
    end

    item.sell_in = sell_in

    case
    when quality < 0
      item.quality = 0
    when quality > 50
      item.quality = 50
    else
      item.quality = quality
    end

  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

