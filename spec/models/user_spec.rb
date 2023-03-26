require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    subject { described_class.new }

    it 'should save without error when all fields are set correctly' do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect { subject.save! }.not_to raise_error
    end

    it "should generate an error if the first name is empty" do
      subject.first_name = nil
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(subject.errors.full_messages).to include("First name can't be blank")
    end

    it "should generate an error if the last name is empty" do
      subject.first_name = 'Robert'
      subject.last_name =  nil
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(subject.errors.full_messages).to include("Last name can't be blank")
    end

    it "should generate an error if the email is empty" do
      subject.first_name = 'Robert'
      subject.last_name =  'Plant'
      subject.email = nil
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(subject.errors.full_messages).to include("Email can't be blank", "Email is not an email")
    end

    it "should generate an error if the password confirmation is empty" do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = nil
      subject.save
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end

  end
end