require 'test_helper'

class ProductTest < ActiveSupport::TestCase

    test "product attributes must not be empty" do
        product = Product.new
        assert product.invalid?
        assert product.errors[:title].any?
        assert product.errors[:description].any?
        assert product.errors[:image_url].any?
        assert product.errors[:price].any?
    end

    test "product price must be positive" do
        product = Product.new(title: "Crazy Snakes",
                              description: "They're craaaaazzzzy!",
                              image_url: "slither.gif")
        product.price = -1
        assert product.invalid?
        assert_equal "must be greater than or equal to 0.01",
            product.errors[:price].join('; ')

        product.price = 0
        assert product.invalid?
        assert_equal "must be greater than or equal to 0.01",
            product.errors[:price].join('; ')

        product.price = 1
        assert product.valid?
    end
end
