class StoreController < ApplicationController
  def index
      session[:counter] = 0 if session[:counter].nil?
      session[:counter] += 1
      @counter = session[:counter]
      @products = Product.order(:title)
  end
end
