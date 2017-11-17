class VixesController < ApplicationController
    
    def index
        @data = session[:data]
        session[:data] = nil
        
    end
    
    
    def vix_data
        @vix = params[:vix]
        @fvmean = params[:fvmean]
        @data = Vix.find_info(@vix, @fvmean)
        session[:data] = @data
        redirect_to root_path
        
    end
    
    
    
    
    
end
