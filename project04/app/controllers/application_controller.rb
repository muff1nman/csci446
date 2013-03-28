class ApplicationController < ActionController::Base
  protect_from_forgery


  private

    def current_cart
        Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end

    def reset_counter
        session[:counter] = 0 if !(session[:counter].nil?)
    end

  before_filter :authorize

  protected

  def authorize
    return if User.find_by_id(session[:user_id]) and request.format == "html"
    redirect_to login_url, notice: "Please log in" unless authenticate_or_request_with_http_basic do |user,pass|
      actual = User.find_by_name( user )
      puts "User: #{user} Pass: #{pass} Hash: #{BCrypt::Password.create(pass)}"
      puts "Actual: #{actual.name} and #{actual.password_digest}"
      actual.name == user and actual.password_digest.is_password?(pass)
    end 
  end

end
