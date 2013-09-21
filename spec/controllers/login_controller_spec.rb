require 'spec_helper'

describe LoginController do

  describe "GET /login" do
    context "when guest" do
      it "renders show" do
        get :show
        expect(response).to render_template('show')
      end
    end
  end

end
