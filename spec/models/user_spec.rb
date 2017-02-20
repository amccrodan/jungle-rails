require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save successfully with all required fields' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(@user.id).to be_present
    end

    it 'should not save successfully without first_name' do
      @user = User.create({
        first_name:  nil,
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not save successfully without last_name' do
      @user = User.create({
        first_name:  'First',
        last_name: nil,
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not save successfully without email' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      })

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should have a unique email (case inensitive)' do
      @user1 = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'TEST@TEST.com',
        password: 'password',
        password_confirmation: 'password'
      })

      @user2 = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'test@tEsT.COM',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not save successfully without password' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: nil,
        password_confirmation: 'password'
      })

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save successfully without password_confirmation' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: nil
      })

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save successfully with mismatched passwords' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'not_password'
      })

      expect(@user.id).to be_nil
    end

    it 'should not save successfully with too short a password' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'pas',
        password_confirmation: 'pas'
      })

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user object when successful' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(User.authenticate_with_credentials('user@user.com', 'password')).to eql(@user)
    end

    it 'should return nil when unsuccessful' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(User.authenticate_with_credentials('user@user.com', 'not_password')).to be_nil
    end

    it 'should succeed with whitespace around email' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(User.authenticate_with_credentials('  user@user.com  ', 'password')).to eql(@user)
    end

    it 'should succeed with different case than in db' do
      @user = User.create({
        first_name:  'First',
        last_name: 'Last',
        email: 'user@user.com',
        password: 'password',
        password_confirmation: 'password'
      })

      expect(User.authenticate_with_credentials('USer@uSEr.Com', 'password')).to eql(@user)
    end
  end
end
