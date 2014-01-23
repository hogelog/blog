require 'spec_helper'

describe Blog::Application do
  describe ".config.secret_key_base" do
    subject { Blog::Application.config.secret_key_base }
    it { expect(subject).to eq("secret_token") }
  end
end
