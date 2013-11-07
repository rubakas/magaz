json.array!(@admin_pages) do |admin_page|
  json.extract! admin_page, :name, :description
  json.url admin_page_url(admin_page, format: :json)
end
