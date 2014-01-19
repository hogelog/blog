require 'spec_helper'

describe Admin::LoginController do

  describe "GET /admin/login" do
    context "when guest" do
      it "renders show" do
        get :show
        expect(response).to render_template('show')
      end
    end
  end

end
