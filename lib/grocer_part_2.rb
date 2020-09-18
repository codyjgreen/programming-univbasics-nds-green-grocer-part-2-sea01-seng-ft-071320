require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  i = 0
  coupons.each do |coupon|
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]
    if item_is_in_basket and count_is_big_enough_to_apply
      cart << { item: "#{item_with_coupon[:item]} W/COUPON", 
                price: coupon[:cost] / coupon[:num], 
                clearance: item_with_coupon[:clearance],
                count: coupon[:num]
              }
      item_with_coupon[:count] -= coupon[:num]
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  cart.map do |item|
    if item[:clearance]
      item[:price] *= 0.8
    end
    item
  end
end

def checkout(cart, coupons)
 consolidated_cart = consolidate_cart(cart)
 applied_coupons_cart = apply_coupons(consolidated_cart, coupons)
 final_cart = apply_clearance(applied_coupons_cart)
 total = 0
 counter = 0
 while counter < final_cart.length
   total += final_cart[counter][:price] * final_cart[counter][:count]
   counter += 1
 end
 if total > 100
   total -= (total * 0.1)
 end
 total
end