class FavoritesController < ApplicationController
    def new
        @favorite = Favorite.new
        @errors = flash[:errors]
        @stations = Station.all.sort_by{|station| station.name}
    end

    def create
        @favorite = Favorite.new(user_id: session[:user_id], station_id: favorites_params[:station_id], label: favorites_params[:label])
        if @favorite.valid?
            @favorite.save
            redirect_to home_path
        else
            flash[:errors] = @favorite.errors.full_messages
            redirect_to new_favorite_path
        end
    end

    def destroy
        @favorite = Favorite.find(params[:id])
        @favorite.destroy
        redirect_to home_path
    end
    

    private
    def favorites_params
        params.require(:favorite).permit(:station_id, :label)
    end
    
end
