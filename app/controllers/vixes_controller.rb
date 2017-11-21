class VixesController < ApplicationController
    
    require 'json'
    
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
    
    def exec_spike
        @result ||= session[:result]
        session[:result] = nil
    end
    
    def python_calc
        vix = params[:vix]
        fvmean = params[:fvmean]
        args = {}
        args["vix"] = params[:vix]
        args["fvix"] = params[:fvmean]
        args["otm"] = params[:otm] 
        args["dte"] = params[:dte]
        
        
        result = `python3 lib/assets/python/analyze_learned_model_1.py '#{JSON.generate(args)}'`
        # result = system("python lib/assets/python/exec_spike.py #{args}")
        @result = result
        session[:result] = @result
        redirect_to '/exec_spike'
    
    end
    
    
    
    
    
    
    
end
