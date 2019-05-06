require 'rails_helper'

describe User, type: :model do
  let!(:user_params) {{
      name: '名前',
      note: '備考'
  }}

  describe 'validation' do
    describe 'name' do
      context 'ある場合' do
        subject { User.new(user_params).tap(&:valid?).errors.full_messages }
        it { is_expected.not_to include("Name can't be blank") }
      end

      context 'ない場合' do
        subject { User.new(user_params.merge({ name: '' })).tap(&:valid?).errors.full_messages }
        it { is_expected.to include("Name can't be blank") }
      end
    end
  end
end
