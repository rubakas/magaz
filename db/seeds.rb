# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Theme.count == 0
  attributes = {names: ["Pipeline", "Blockshop", "Mobilia", "Palo Alto", "Expression", "Ira",
                         "Envy", "Showcase", "California", "Parallax" ],
                industries: ["Other", "Food & Drink", "Food & Drink", "Sports & Recreation",
                             "Sports & Recreation", "Clothing & Fashion", "Health & Beauty",
                             "Health & Beauty", "Art & Photography", "Jewelry & Accessories" ],
                prices: [ 140, 140, 160, 0, 150, 160, 120, 180, 180, 0 ],
                styles: ["Cool", "Dark", "Warm", "Bold", "Coffee", "Classic", "Travel",
                         "Spring", "Standfort", "Outdoors"],
                comment: "This is example of review which created by backend team"}
  partner = ThemeServices::CreatePartner
            .new(params: { 'name' => "Magaz.com", 'website_url' => "https://magaz.com" })
            .run
  archive_path = ::File.expand_path("#{Rails.root}/test/fixtures/files/valid_theme.zip", __FILE__)

  10.times do |n|
    theme = Theme.new
    ThemeServices::ImportFromArchive
      .new(archive_path: archive_path,
            theme: theme,
            theme_attributes: {'name' => attributes[:names][n],
                               'price' => attributes[:prices][n],
                               'partner_id' => partner.result.id})
      .run
    theme.update_attributes(rating: rand(1..50))
    theme.theme_styles.each do |style|
      File.open(Rails.root+"test/fixtures/files/screenshots/#{attributes[:names][n]}-#{attributes[:styles][n]}.jpg") do |file|
        style.image = file
      end
      style.update_attributes(industry: attributes[:industries][n], name: attributes[:styles][n])
    end
    Review.create(body: attributes[:comment], mark: rand(-1..1), theme_id: theme.id, user: User.last)
  end
end
