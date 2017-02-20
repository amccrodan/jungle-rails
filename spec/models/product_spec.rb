require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.create(name: 'Testing') }

    it 'should save successfully with all required fields' do
      @product = category.products.create({
        name:  'Test Product Name',
        description: Faker::Hipster.paragraph(4),
        image: File.open(Rails.root.join('db', 'seed_assets', 'apparel1.jpg')),
        quantity: 10,
        price: 64.99
      })

      expect(@product.id).to be_present
    end

    it 'should not save successfully without a name' do
      @product = category.products.create({
        name: nil,
        description: Faker::Hipster.paragraph(4),
        image: File.open(Rails.root.join('db', 'seed_assets', 'apparel1.jpg')),
        quantity: 10,
        price: 64.99
      })

      expect(@product.id).to be_nil
    end

    it 'should not save successfully without a price' do
      @product = category.products.create({
        name:  'Test Product Name',
        description: Faker::Hipster.paragraph(4),
        image: File.open(Rails.root.join('db', 'seed_assets', 'apparel1.jpg')),
        quantity: 10,
        price: nil
      })

      expect(@product.id).to be_nil
    end

    it 'should not save successfully without a quantity' do
      @product = category.products.create({
        name:  'Test Product Name',
        description: Faker::Hipster.paragraph(4),
        image: File.open(Rails.root.join('db', 'seed_assets', 'apparel1.jpg')),
        quantity: nil,
        price: 64.99
      })

      expect(@product.id).to be_nil
    end

    it 'should not save successfully without a category' do
      @product = Product.create({
        name:  'Test Product Name',
        description: Faker::Hipster.paragraph(4),
        image: File.open(Rails.root.join('db', 'seed_assets', 'apparel1.jpg')),
        quantity: 10,
        price: 64.99
      })

      expect(@product.id).to be_nil
    end

    it 'has an error in errors.full_messages when it fails' do
      @product = Product.create({
        name:  'Test Product Name',
        description: Faker::Hipster.paragraph(4),
        image: File.open(Rails.root.join('db', 'seed_assets', 'apparel1.jpg')),
        quantity: 10,
        price: 64.99
      })

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
