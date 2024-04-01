class UsersController < ApplicationController 
    skip_before_action :protect_pages, only: :show 
    def show
        @usuario = User.find_by!(username: params[:username])
        
        #@categorias = Category.order(name: :asc).load_async
        @productos = Product.all.with_attached_photo

        @productos = @productos.where(user_id: @usuario.id)

        order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
        @productos = @productos.order(order_by).load_async 
        @pagy, @productos = pagy_countless(@productos, items: 12)    
    end
end 