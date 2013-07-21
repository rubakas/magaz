json.array!(@registrations) do |registration|
  json.extract! registration, 
  json.url registration_url(registration, format: :json)
end
