class Vix < ActiveRecord::Base
    
    def self.find_info(vix, fvmean)
        vix_data = where(vix: vix, fvmean: fvmean).first
        if vix_data
            return vix_data
        else
            vix = vix.to_f
            fvmean = fvmean.to_f
            # check if either is in database or? 
            # find closest based on vix #
            max_vix = vix + 0.5
            min_vix = vix - 0.5
            data = where('vix < ?', max_vix ).where('vix > ? ', min_vix)
            closest = nil
            min_diff = nil
            data.each do |d|
                if !closest
                    closest = d.vix
                    min_diff = (vix-d.vix).abs
                else
                    if (vix-d.vix).abs < min_diff
                        min_diff = (vix-d.vix).abs
                        closest = d.vix
                    end
                end
            
            end
    
            vix_data = where(vix: closest, fvmean: fvmean).first
            if vix_data
                return vix_data
            else
                data = where(vix: closest)
                closest_fv = nil
                min_diff = nil
                data.each do |d|
                    if !closest_fv
                        closest_fv = d.fvmean
                        min_diff = (fvmean-d.fvmean).abs
                    else
                        if (fvmean-d.fvmean).abs < min_diff
                            min_diff = (fvmean-d.fvmean).abs
                            closest_fv = d.fvmean
                        end
                    end
                end
            end

            vix_data = where(vix: closest, fvmean: closest_fv)

        end
        return vix_data.first
    end
    
    
    
    
    
end
