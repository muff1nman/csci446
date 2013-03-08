require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    fixtures :products

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

    def new_product( image_url)
        Product.new(title: "My Book Title",
                    description: "yyyy",
                    price: 1,
                    image_url: image_url)

    end

    test "image url" do
        ok = %w{ fred.gif fred.jpg fred.png FRED.Jpg http://a.b.c/x/y/z/fred.gif }
        bad = %w{ fred.doc fred.gif/more fred.gif.more }

        ok.each do |good_url|
            assert new_product(good_url).valid?, "#{good_url} shouldn't be invalid"
        end

        bad.each do |bad_url|
            assert new_product(bad_url).invalid?, "#{bad_url} shouldn't be valid"
        end
    end

    test "product is not valid without a unique title" do
        product = Product.new(title: products(:ruby).title,
                              description: "hello",
                              price: 23,
                              image_url: "fred.gif")
        assert !product.save
        assert_equal "has already been taken", product.errors[:title].join('; ')
    end

    test "product title length minumum of 10" do
        product = Product.new(
                              description: products(:ruby).description,
                              price: products(:ruby).price,
                              image_url: products(:ruby).image_url)

        product.title = "TooLittle"
        assert product.invalid?
        assert_equal "is too short (minimum is 10 characters)",
           product.errors[:title].join('; ')

        product.title = "Just_Right"
        assert product.valid?

        product.title = "WayOverboardherebutthatsokwithme"
        assert product.valid?

    end
end
