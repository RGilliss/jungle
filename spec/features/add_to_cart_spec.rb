require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    first('.actions').first('.btn').click
    expect(page).to have_content("My Cart (1)")
    # puts page.html
    save_screenshot
  end

end