def stock_picker (array_prices)
  hash_day_profits = day_bought_sold_and_profit(array_prices)
  profits = hash_day_profits.values
  max_profit = profits.max
  p day_with_max_profit = hash_day_profits.key(max_profit)
end

def day_bought_sold_and_profit (prices)
  hash = {}
  prices.each_index do |buy_index|
    prices.each_index do |sell_index|
      if sell_index > buy_index
        hash[[buy_index, sell_index]] = prices[sell_index] -
        prices[buy_index]
      end
    end
  end
  hash
end

def array_to_hash (array)
  hash_prices = {}
  array.each_with_index do |price, day|
    hash_prices[day] = price
  end
  hash_prices
end

#test
list_of_prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
stock_picker(list_of_prices)
