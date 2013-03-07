class CombineItemsInCart < ActiveRecord::Migration
  def up
      Cart.all.each do |cart|
          # count the number of products for each cart
          sums = cart.line_items.group(:product_id).sum(:quantity)

          sums.each do |product_id, quantity|
              if quantity > 1
                  # remove all products in the given cart that match the product
                  # id
                  cart.line_items.where(product_id: product_id).delete_all
                  # and replace them with a single line_item with the quantity
                  # as the summation of the previous quantities
                  new_line_item = cart.line_items.new(product_id: product_id )
                  new_line_item.quantity = quantity
                  new_line_item.save
              end
          end
      end

  end

  def down
      # split items with a quantity greater than one into multiple items
      LineItem.where("quantity>1").each do |line_item|
          # create individual items
          line_item.quantity.times do
              LineItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
          end

          line_item.destroy
      end
  end
end
