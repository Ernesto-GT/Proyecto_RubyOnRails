require 'net/http'
class Authentication::UsersController < ApplicationController 
    skip_before_action :protect_pages
    def new
        @usuario = User.new
    end

    def create
        @usuario = User.new(user_params)
        #@usuario.country = FetchCountryService.new(request.remote_ip).perform
        if @usuario.save 
            #FetchCountryJob.perform_later(@usuario.id, request.remote_ip)
            #UserMailer.with(user: @usuario).welcome.deliver_later #no se usa "deliver_now" para no relentizar el proceso, en caso que se dificulte el envio del email
            session[:user_id] = @usuario.id
            redirect_to products_path, notice: 'Se ha agregado el usuario exitosamente'
        else 
            render :new, status: :unprocessable_entity
        end
    end 

    private 
    def user_params
        params.require(:user).permit(:email, :username, :password, :phone)
    end
end