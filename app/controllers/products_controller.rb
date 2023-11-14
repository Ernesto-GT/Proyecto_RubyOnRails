class ProductsController < ApplicationController
    skip_before_action :protect_pages, only: [:index, :show ]
    #Mostrar todos los productos
    def index
        @categorias = Category.order(name: :asc).load_async
        @productos = Product.all.with_attached_photo

        if params[:category_id]
           @productos = @productos.where(category_id: params[:category_id])
        end
        if params[:min_price].present?
            @productos = @productos.where("price >= ?", params[:min_price])
        end
        if params[:max_price].present?
            @productos = @productos.where("price <= ?", params[:max_price])
        end
        if params[:query_text].present?
            @productos = @productos.search_full_text(params[:query_text])
        end
        if params[:favorites].present?
            @productos = @productos.joins(:favorites).where({favorites: {user_id: Current.user.id}})
        end

        order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])

        @productos = @productos.order(order_by).load_async 
        @pagy, @productos = pagy_countless(@productos, items: 12)
        #pendiente de optimizar
        #@pagy, @productos = pagy_countless(FindProducts.new.call(products_params_index).load_async, items: 5)
    end
    #Nota: La variable '@producto' maneja todos los campos de x producto, y tiene que ser usada para todas
        # las funciones que utilicen dicho producto
    def show
        producto #Mostrar el detalle de un producto en particular
        #categorias
    end 

    def new 
        @producto = Product.new
    end 

    def create 
        @producto = Product.new(product_params)

        if @producto.save 
                            #Los mensajes para variables flash se clasifican en 2 tipos "notice" y "alert"
            redirect_to products_path, notice: 'Tu producto a sido agregado a la lista' 
        else
            render :new, status: :unprocessable_entity
        end 
    end 

    def edit
        authorize! producto
    end

    def update
        authorize! producto
        if producto.update(product_params)
            authorize! producto
            redirect_to products_path, notice: 'El producto ha sido actualizado'
        else 
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        authorize! producto
        producto.destroy
        redirect_to products_path, notice: 'El producto ha sido borrado exitosamente', status: :see_other
    end
    private 
    def product_params
        params.require(:product).permit(:title, :description, :price, :photo, :category_id)
    end 

    def products_params_index
        params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites)
    end
    def producto
        @producto ||= Product.find(params[:id])
    end 

    def categorias
        @categoria = Category.find(params[:id])
    end 
end
