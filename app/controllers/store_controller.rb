require 'will_paginate/array'

class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    @products = get_products.paginate(page: params[:page], order: 'title', per_page: 12)
    @cart = current_cart
    @available_categories = Category.available

    respond_to do |format|
      format.html
      format.js { render :index }
    end
  end

  private

  def get_products
    if params[:category_id].present?
      Product.where('category_id = ?', params[:category_id])
    else
      Product.all
    end
  end
end
