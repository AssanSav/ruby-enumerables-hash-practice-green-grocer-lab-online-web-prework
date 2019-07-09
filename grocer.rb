require 'pry'
def consolidate_cart(array)
  new_hash = {}
  array.each do |arr|
    arr.each do |key, value|
      if new_hash[key]
        new_hash[key][:count] += 1 
      else 
        new_hash[key] = value 
        new_hash[key][:count] = 1 
       end
    end
  end
  return new_hash
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        discount = "#{coupon[:item]} W/COUPON"
        if cart[discount] 
          cart[discount][:count] += coupon[:num]
        else
          cart[discount] = {}
          cart[discount] = {:price => coupon[:cost]/coupon[:num], :clearance => cart[coupon[:item]][:clearance], :count => coupon[:num]}
          end
        cart[coupon[:item]][:count] -= coupon[:num]
      end    
    end
  end 
  cart
end

def apply_clearance(cart)
 cart.each do |key, value|
   if value[:clearance] == true
     value[:price] = (value[:price] * 80)/100
 #binding.pry
    end
  end
  cart 
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(merge_cart, coupons)
  cart = apply_clearance(coupons_cart)
  total = 0 
  cart.each do |item, property|
    total = property[:price] * property[:count]
    total >= 100 ? total * 0.1 : nil 
 binding.pry
  end
end
