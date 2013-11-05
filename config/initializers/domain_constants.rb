HOSTNAME = case Rails.env
when 'production' then 'magaz.ua'
when 'development' then 'magaz.local'
when 'test' then 'magaz.local'
end