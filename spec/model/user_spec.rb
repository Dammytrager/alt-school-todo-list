require 'rails_helper.rb'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'validations' do
    context 'when first_name' do
      it 'returns error when not present' do
        user.update(first_name: nil)

        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.first).to eq("First name can't be blank")
      end

      it 'returns no error when present' do
        expect(user.valid?).to be_truthy
        expect(user.errors.any?).to be_falsey
      end
    end

    context 'when last_name' do
      it 'returns error when not present' do
        user.update(last_name: nil)

        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.first).to eq("Last name can't be blank")
      end

      it 'returns no error when present' do
        expect(user.valid?).to be_truthy
        expect(user.errors.any?).to be_falsey
      end
    end

    context 'when email' do
      it 'returns error when not present' do
        user.update(email: nil)

        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.first).to eq("Email can't be blank")
      end

      it 'return error when format is not correct' do
        user.update(email: 'shdhdhdksk')

        expect(user.valid?).to be_falsey
        expect(user.errors.full_messages.first).to eq("Email is not valid")
      end

      it 'returns no error when present' do
        expect(user.valid?).to be_truthy
        expect(user.errors.any?).to be_falsey
      end
    end

    context 'when password' do
      it 'returns error when not present' do
        expect { create(:user, password: nil) }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'returns no error when present' do
        expect(user.valid?).to be_truthy
        expect(user.errors.any?).to be_falsey
      end
    end
  end

  context '#full_name' do
    it 'returns the full name' do
      expect(user.full_name).to eql('John Doe')
    end
  end

  context '.total_users' do
    context 'when no user' do
      it 'return 0' do
        expect(User.total_users).to eql(0)
      end
    end

    context 'when user' do
      before { user }

      it 'returns user count' do
        expect(User.total_users).to eql(1)
      end
    end
  end
end
