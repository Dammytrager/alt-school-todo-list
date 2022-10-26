require 'rails_helper.rb'

RSpec.describe PagesController, type: :request do
  describe '#home' do
    context 'when user is not signed in' do
      it 'loads the home page' do
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).to match('Hello World')
        expect(response.body).to match('Sign In')
        expect(response.body).to match('Sign Up')
      end
    end

    context 'when the user is signed in' do
      let(:user) { create(:user) }

      before { sign_in_as(user) }

      it 'loads the home page' do
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).to match('Hello World')
        expect(response.body).to match('My Todos')
        expect(response.body).to match('Logout')
      end
    end
  end
end