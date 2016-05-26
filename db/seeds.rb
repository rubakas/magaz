# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Theme.count == 0
  archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)
  10.times do |n|
    ThemeServices::ImportFromArchive.call(archive_path: archive_path,
                                        theme: Theme.new,
                                        theme_attributes: { name: "Default#{n}", style_name: "NewStyle#{n}",
                                                            price: 1.5*n, industry: "Oth#{n}r"})
  end
end
