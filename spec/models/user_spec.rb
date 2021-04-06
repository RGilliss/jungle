require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user1 = User.create(name: "Jules", email: "winnfield.j@ymail.com", password: "abc123", password_confirmation: "abc123")
    @user2 = User.create(name: nil, email: "j@ymail.com", password: "qwe123", password_confirmation: "qwe123")
    @user3 = User.create(name: "Dwight", email: nil, password: "qwe123", password_confirmation: "qwe123")
    @user4 = User.create(name: "Pam", email: "pam@dundermifflin.com", password: nil , password_confirmation: "qwe123")
    @user5 = User.create(name: "Kevin", email: "kevin@sabre.net", password: "qwe123", password_confirmation: nil)
    @user6 = User.create(name: "Meridith", email: "mer@sabre.net", password: "qwe123", password_confirmation: "abc456")
    @user7 = User.create(name: "Creed", email: "wiNNfield.j@ymail.com", password: "qwe123", password_confirmation: "qwe123")
    @user8 = User.create(name: "Oscar", email: "oscar@dundermifflin.com", password: "qw", password_confirmation: "qw")
    @user9 = User.create(name: "Stanley", email: "   stanley@dundermifflin.com      ", password: "qwerty", password_confirmation: "qwerty")

  end
  describe "Validations" do
    it "must save a new user with valid credentials" do
      expect(@user1.password).to eq("abc123")
      expect(@user1.name).to eq("Jules")
      expect(@user1.email).to eq("winnfield.j@ymail.com")
      expect(@user1.errors.full_messages).to eq([])
    end
    it "will throw an error when name is left as nil" do
      expect(@user2.errors.full_messages).to eq(["Name can't be blank"])
    end
    it "will throw an error when email is left as nil" do
      expect(@user3.errors.full_messages).to eq(["Email can't be blank"])
    end
    it "will throw an error when password is left as nil" do
      expect(@user4.errors.full_messages).to eq(["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 3 characters)"])
    end
    it "will throw an error when password confirmation is left as nil" do
      expect(@user5.errors.full_messages).to eq(["Password confirmation can't be blank"])
    end
    it "will throw an error when password confirmation does not match password" do
      expect(@user6.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
    end
    it "will only accept emails that do not exist in the database (no matter the case)" do
      expect(@user7.errors.full_messages).to eq(["Email has already been taken"])
    end
    it "will only accept password that are greater than 2 characters" do
      expect(@user8.errors.full_messages).to eq(["Password is too short (minimum is 3 characters)"])
    end
    it "will strip whitespace before and after an email" do
      expect(@user9.email).to eq("stanley@dundermifflin.com")
    end
  end

  describe ".authenticate_with_credentials" do
    it "will successfully login if credentials are authenticated" do
      expect(@user1.authenticate_with_credentials(@user1.email, @user1.password)).to eq(@user1)
    end
    it "will return nil if password does not match" do
      expect(@user1.authenticate_with_credentials(@user1.email, @user2.password)).to eq(nil)
    end
    it "will return nil if email does not match" do
      expect(@user1.authenticate_with_credentials(@user2.email, @user1.password)).to eq(nil)
    end
    it "will strip whitespace before and after an email" do
      expect(@user1.authenticate_with_credentials("  winnfield.j@ymail.com  ", @user1.password)).to eq(@user1)
    end
    it "will log a user in if their email is correct (no matter the case) and password is correct (case sensitive)" do
      expect(@user1.authenticate_with_credentials("wiNNfield.j@ymail.com", @user1.password)).to eq(@user1)
    end
  end
end
