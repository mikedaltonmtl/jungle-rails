require 'rails_helper'


RSpec.describe Product, type: :model do
  describe 'Validations' do

    subject { described_class.new }

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
      expect(["Name can't be blank"]).to eql(subject.errors.full_messages)
    end

    it "should generate an error if the price is empty" do
      subject.name = "Robert"
      subject.price = nil
      subject.quantity = 80
      subject.category = Category.new(name: 'Plant')
      subject.save
      expect(["Price can't be blank"]).to eql(subject.errors.full_messages)
    end

    it "should generate an error if the quantity is empty" do
      subject.name = "Robert"
      subject.price = 100
      subject.quantity = nil
      subject.category = Category.new(name: 'Plant')
      subject.save
      expect(["Quantity can't be blank"]).to eql(subject.errors.full_messages)
    end

    it "should generate an error if the category is empty" do
      subject.name = "Robert"
      subject.price = 100
      subject.quantity = 80
      subject.category = nil
      subject.save
      expect(["Category must exist", "Category can't be blank"]).to eql(subject.errors.full_messages)
    end

  end
end