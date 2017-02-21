require 'rails_helper'

RSpec.feature "AddToCart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Clicking add to cart updates cart contents" do
    # ACT
    visit root_path

    first('article.product > footer').find('a', text: 'Add').click
    sleep(2)

    # DEBUG / VERIFY
    expect(page).to have_css('#navbar > ul > li > a', text: '(1)')
    save_screenshot
  end

end
