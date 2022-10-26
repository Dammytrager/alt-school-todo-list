require 'rails_helper.rb'

RSpec.describe AuthController, type: :request do
  let(:user) { create(:user) }

  describe '#sign_in' do
    context 'when user is guest' do
      it 'loads the sign in page' do
        get sign_in_path
        expect(response.status).to eq(200)
        expect(response.body).to match('Email')
        expect(response.body).to match('Password')
        expect(response.body).to match('Submit')
        expect(response.body).to match('Sign in Page')
      end
    end

    context 'when user is signed in' do
      before { sign_in_as(user) }

      it 'redirects to the todo\'s list path' do
        get sign_in_path
        expect(response.status).to eq(302)
        follow_redirect!
        expect(response.status).to eq(200)
        expect(response.body).to match("#{user.first_name} Todo list")
      end
    end
  end

  describe '#sign_up' do
    context 'when user is guest' do
      it 'loads the sign up page' do
        get sign_up_path
        expect(response.status).to eq(200)
        expect(response.body).to match('First Name')
        expect(response.body).to match('Last Name')
        expect(response.body).to match('Email')
        expect(response.body).to match('Password')
        expect(response.body).to match('Submit')
        expect(response.body).to match('Sign up Page')
      end
    end

    context 'when user is signed in' do
      before { sign_in_as(user) }

      it 'redirects to the todo\'s list path' do
        get sign_up_path
        expect(response.status).to eq(302)
        follow_redirect!
        expect(response.status).to eq(200)
        expect(response.body).to match("#{user.first_name} Todo list")
      end
    end
  end

  describe '#login' do
    context 'when credentials are valid' do
      it 'sets the session redirects to the todo\'s path' do
        post login_path, params: { credentials: { email: user.email, password: '12345' } }
        expect(response.status).to eq(302)
        follow_redirect!
        expect(session[:user]).to eq(user.id)
        expect(response.status).to eq(200)
        expect(response.body).to match("#{user.first_name} Todo list")
      end
    end

    context 'when the email is valid but password is incorrect' do
      it 'renders the sign in page and shows error message' do
        post login_path, params: { credentials: { email: user.email, password: 'not correct' } }
        expect(response.status).to eq(200)
        expect(response.body).to match('Password is not correct')
      end
    end

    context 'when the email is invalid' do
      it 'renders the sign in page and shows error message' do
        post login_path, params: { credentials: { email: 'invalid@gmail.com', password: 'not correct' } }
        expect(response.status).to eq(200)
        expect(response.body).to match('User with email does not exist')
      end
    end
  end

  describe '#create_user' do
    context 'when the data is valid' do
      let(:data) { {email: 'pete@gmail.com', first_name: 'Pete', last_name: 'Lee', password: '123', password_confirmation: '123'} }

      it 'creates a user and redirects to the sign in page' do
        post sign_up_path, params: { user: data }

        expect(User.last.email).to eq(data[:email])
        expect(response.status).to eq(302)
      end
    end

    context 'when the user exists' do
      let(:data) { {email: user.email, first_name: 'Pete', last_name: 'Lee', password: '123', password_confirmation: '123'} }

      before { user }

      it 'shows an error message' do
        user_count = User.all.count
        post sign_up_path, params: { user: data }

        expect(User.all.count).to eq(user_count)
        expect(response.status).to eq(200)
        expect(response.body).to match('User with email already exists')
      end
    end

    context 'when the data is invalid' do
      let(:data) { {email: 'petessls', first_name: 'Pete', last_name: 'Lee', password: '123', password_confirmation: '123'} }

      it 'creates a user and redirects to the sign in page' do
        user_count = User.all.count
        post sign_up_path, params: { user: data }

        expect(User.all.count).to eq(user_count)
        expect(response.status).to eq(200)
        expect(response.body).to match('Email is not valid')
      end
    end
  end

  describe '#login' do
    context 'when user is logged in' do
      before { sign_in_as(user) }

      it 'clears the session' do
        post logout_path
        expect(session[:user]).to be_nil
        expect(response.status).to eq(302)
      end
    end
  end
end