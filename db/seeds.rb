# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if MagazCore::Theme.count == 0
  archive_path = ::File.expand_path('../../gems/magaz_core/test/fixtures/files/valid_theme.zip', __FILE__)
  MagazCore::ThemeServices::ImportFromArchive.call(archive_path: archive_path,
                                                   theme: MagazCore::Theme.new,
                                                   theme_attributes: { name: 'Default' })
end
