class Authentication::SessionsController < ApplicationController 
    skip_before_action :protect_pages
    def new
    end

    def create
        @usuario = User.find_by("email = :login OR username = :login", login: params[:login])
        
        if @usuario&.authenticate(params[:password])
            session[:user_id] = @usuario.id
            redirect_to products_path, notice: 'Usuario correcto'
        else  
            redirect_to sessions_path, alert: "El usuario o la contraseña asignada, o son correctos"
        end
    end 

    def destroy 
        session.delete(:user_id)
        redirect_to products_path, notice: 'Has eliminado la session correctamente'
    end 

    private 
    def user_params
        params.require(:user).permit(:email, :username, :password, :phone)
    end
end