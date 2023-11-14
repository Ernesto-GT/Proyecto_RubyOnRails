class FavoritesController < ApplicationController
    def index
    end
    
    def create 
        product.favorite!
        respond_to do |format|
            format.html do
                redirect_to product_path(product)
            end
            format.turbo_stream do 
               render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product})
            end
        end
    end 
    def destroy
        product.unfavorite!
        respond_to do |format|
            format.html do
                redirect_to product_path(product), status: :see_other #El comando de status se coloca para cada funcion delete o destroy
            end#Con turbo hacemos que se renderise solo la el cambio de favorito en la pagina, y no todo el contenido 
            format.turbo_stream do 
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: {product: product})
            end
        end
    end 

    private 
    #memoization (toma la ultima consulta realizada, para no duplicar proceso)
    def product 
        @product ||= Product.find(params[:product_id])
    end 
end