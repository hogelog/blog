require 'spec_helper'

describe User do
  describe ".login_user" do
    let(:username) { "hogelog" }
    let(:password) { "hoge" }
    before { User.create_user(username, password) }

    context "with valid login_params" do
      let(:login_params) { {username: username, password: password} }

      it "returns login user" do
        user = User.login_user(login_params)
        expect(user).to be_present
      end
    end

    context "with invalid login params" do
      let(:login_params) { {username: username, password: 'invalid'} }

      it "raise invalid_user error" do
        expect { User.login_user(login_params) }.to raise_error(User::InvalidUser)
      end
    end
  end

  describe "#articles" do
    let(:article) { create(:article) }
    let(:user) { article.user }

    it "returns user's articles" do
      expect(user.articles.first).to eq(article)
    end
  end
end
