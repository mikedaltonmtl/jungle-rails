require 'rails_helper'


RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save without error when all fields are set' do
      subject.name = "Robert"
      subject.price = 100
      subject.quantity = 80
      subject.category = Category.new(name: 'Plant')
      expect { subject.save! }.not_to raise_error
    end

    it "should generate an error if the name is empty" do
      subject.name = nil
      subject.price = 100
      subject.quantity = 80
      subject.category = Category.new(name: 'Plant')
      subject.save
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end

    it "should generate an error if the price is empty" do
      subject.name = "Robert"
      subject.price = nil
      subject.quantity = 80
      subject.category = Category.new(name: 'Plant')
      subject.save
      expect(subject.errors.full_messages).to include("Price can't be blank")
    end

    it "should generate an error if the quantity is empty" do
      subject.name = "Robert"
      subject.price = 100
      subject.quantity = nil
      subject.category = Category.new(name: 'Plant')
      subject.save
      expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should generate an error if the category is empty" do
      subject.name = "Robert"
      subject.price = 100
      subject.quantity = 80
      subject.category = nil
      subject.save
      expect(subject.errors.full_messages).to include("Category can't be blank")
    end

  end
end