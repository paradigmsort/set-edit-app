require 'spec_helper'

describe "AuthenticationPages" do
  subject{ page }

  describe 'as non-signed-in user' do
    before { visit root_path }

    it { should have_link("Sign in") }
    it { should have_link("Sign up") }
  end

  describe 'as signed-in user' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
    end

    it { should have_content(user.email) }
    it { should have_link("Edit profile") }
    it { should have_link("Sign out") }
  end
end
