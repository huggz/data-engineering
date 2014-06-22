require 'rails_helper'

RSpec.describe User do
  describe 'attributes' do
    it { should have_attribute :email }
    it { should have_attribute :encrypted_password }
    it { should_not have_attribute :password }
  end

  describe 'validations' do
    before { create :user }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end
end
