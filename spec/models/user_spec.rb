require 'rails_helper'

RSpec.describe User, type: :model do
  it {should have_many(:messages)}
  it {should have_many(:authorizations)}

  describe '.find for oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '1234567') }

    context 'user already has authorization' do

      it 'return the user' do
        user.authorizations.create(provider: 'twitter', uid: '1234567')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end
    
    context 'user has not authorization' do

      context 'user already exist' do

        let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '1234567', info: { email: user.email }) }

        it 'does not create new user' do
          expect{ User.find_for_oauth(auth) }.to_not change(User, :count)
        end
        it 'create authorization for user' do
          expect{ User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end
        it 'create authorization with provider and uid' do
          user = User.find_for_oauth(auth)
          authorization = user.authorizations.first

          expect( authorization.provider ).to eq auth.provider
          expect( authorization.uid ).to eq auth.uid
        end
        it 'return to user' do
          expect( User.find_for_oauth(auth) ).to eq user
        end
      end

      context 'user does not exists' do

        let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '1234567', info: {email: 'new@user.com'} ) }

        it 'creates new user' do
          expect{ User.find_for_oauth(auth) }.to change(User, :count).by(1)
        end
        it 'return new user' do
          expect( User.find_for_oauth(auth) ).to be_a(User) 
        end
        it 'fill user email' do
          user = User.find_for_oauth(auth)
          expect( user.email ).to eq auth.info.email
        end
        it 'create authorization for user' do 
          user = User.find_for_oauth(auth)
          expect( user.authorizations ).to_not be_empty
        end
        it 'create authorization with valid provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first
          expect( authorization.provider ).to eq auth.provider
          expect( authorization.uid ).to eq auth.uid
        end
      end
    end
  end
end
