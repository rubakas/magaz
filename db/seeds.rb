# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Theme.count == 0
  partner = ThemeServices::CreatePartner.run(name: "Magaz.com", website_url: "https://magaz.com")

  archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
  10.times do |n|
    ThemeServices::ImportFromArchive.call(archive_path: archive_path,
                                          theme: Theme.new,
                                          theme_attributes: { name: "Theme_#{n}",
                                                              style_name: "Style_#{n}",
                                                              price: 1.5*n, industry: "Deafult",
                                                              partner_id: partner.result.id})
  end
end