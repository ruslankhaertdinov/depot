class OrdersController < ApplicationController

  def index
    @orders = if current_user_admin?
                Order.paginate(page: params[:page], order: 'created_at desc', per_page: 10)
              else
                Order.for(current_user).paginate(page: params[:page], order: 'created_at desc', per_page: 10)
              end

    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def new
    @cart = current_cart

    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(params[:order], user_id: current_user.id)
    @order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifier.received(@order).deliver
        format.html { redirect_to store_url, notice:
            I18n.t('.thanks') }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

end
