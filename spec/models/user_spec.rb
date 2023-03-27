require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

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
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end

    it 'should generate an error if the email is not unique' do
      user1 = described_class.new
      user1.first_name = 'Robert'
      user1.last_name = 'Plant'
      user1.email = 'robert.plant@trees.com'
      user1.password = 'password'
      user1.password_confirmation = 'password'
      expect { user1.save! }.not_to raise_error

      user2 = described_class.new
      user2.first_name = 'Bob'
      user2.last_name = 'Planter'
      user2.email = 'ROBERT.plant@trees.com'
      user2.password = 'password'
      user2.password_confirmation = 'password'
      user2.save
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should generate an error if the email is not an email address" do
      subject.first_name = 'Robert'
      subject.last_name =  'Plant'
      subject.email = 'robert.plantstrees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(subject.errors.full_messages).to include("Email is not an email")
    end

    it "should generate an error if the password is empty" do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = nil
      subject.password_confirmation = 'password'
      subject.save
      expect(subject.errors.full_messages).to include("Password can't be blank")
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

    it "should generate an error if the password and password confirmation do not match" do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'wordpass'
      subject.save
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should generate an error if the password is less than 8 characters" do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'paSeven'
      subject.password_confirmation = 'paSeven'
      subject.save
      expect(subject.errors.full_messages).to include("Password must contain 8 or more characters")
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should authenticate a user if the log in details are correct' do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(User.authenticate_with_credentials(subject.email, subject.password)).to be_an_instance_of described_class
    end

    it 'should return nil if the email is incorrect' do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(User.authenticate_with_credentials('fred.shrub@weeds.com', subject.password)).to be_nil
    end

    it 'should trim the email before authenticating it' do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(User.authenticate_with_credentials('  robert.plant@trees.com  ', subject.password)).to be_an_instance_of described_class
    end

    it 'should authenticate the email without being case-sensitive' do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'ROBert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(User.authenticate_with_credentials('roBert.pLant@trEes.coM', subject.password)).to be_an_instance_of described_class
    end

    it 'should return nil if the password is incorrect' do
      subject.first_name = 'Robert'
      subject.last_name = 'Plant'
      subject.email = 'robert.plant@trees.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      subject.save
      expect(User.authenticate_with_credentials('robert.plant@trees.com', 'wordpass')).to be_nil
    end

  end
end