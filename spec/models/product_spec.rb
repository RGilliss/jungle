require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category1 = Category.create(id: 1, name: "electronics")
    @category2 = Category.create(id: 2, name: "indoor")
    @category3 = Category.create(id: 3, name: "outdoor")
    @category4 = Category.create(id: 4, name: "pet")

    @product1 = Product.create(name: "Intellivision", price_cents: 350000, quantity: 44, category_id: @category1.id)
    @product2 = Product.create(name: nil, price_cents: 6000, quantity: 150, category_id: @category4.id)
    @product3 = Product.create(name: "couch", price_cents: nil, quantity: 3, category_id: @category2.id)
    @product4 = Product.create(name: "trampoline", price_cents: 50000, quantity: nil, category_id: @category3.id)
    @product5 = Product.create(name: "rubber dog bone", price_cents: 6000, quantity: 150, category_id: nil)
  end
  describe 'Validations' do 
    it "will save a new product successfully" do
      expect(@product1.name).to eq("Intellivision")
      expect(@product1.price_cents).to eq(350000)
      expect(@product1.quantity).to eq(44)
      expect(@product1.category_id).to eq(@category1.id)
    end
    it "will throw an error when name is left as nil" do
      expect(@product2.errors.full_messages).to eq(["Name can't be blank"])
    end
    it "will throw an error when price is left as nil" do
      expect(@product3.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end
    it "will throw an error when quantity is left as nil" do
      expect(@product4.errors.full_messages).to eq(["Quantity can't be blank"])
    end
    it "will throw an error when category is left as nil" do
      expect(@product5.errors.full_messages).to eq(["Category can't be blank"])

    end
  end
end
