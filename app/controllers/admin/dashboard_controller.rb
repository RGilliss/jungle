class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_NAME'], password: ENV['HTTP_PASS']
  def show
    @category_count = Category.count
    @product_count = Product.count
  end
end
