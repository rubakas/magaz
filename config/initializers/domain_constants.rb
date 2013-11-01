HOSTNAME_SITE = case Rails.env
when 'production' then 'magaz.ua'
when 'development' then 'magaz.local'
when 'test' then 'magaz.local'
end

HOSTNAME_SHOP = case Rails.env
when 'production' then 'mymagaz.ua'
when 'development' then 'mymagaz.local'
when 'test' then 'mymagaz.local'
end