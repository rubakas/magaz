HOSTNAME = case Rails.env
           when 'production' then 'magaz.ua'
           when 'development' then 'magaz.local'
           when 'test' then 'magaz.local'
           end

THEME_STORE_HOSTNAME =  case Rails.env
                        when 'production' then 'themes.magaz.ua'
                        when 'development' then 'themes.magaz.local'
                        when 'test' then 'themes.magaz.local'
                        end