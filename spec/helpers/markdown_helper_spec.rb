require 'spec_helper'

describe MarkdownHelper do
  describe ".markdown" do
    let(:markdown_text) { "This is *bongos*, indeed." }
    let(:html) { "<p>This is <em>bongos</em>, indeed.</p>\n" }

    it "returns html" do
      expect(markdown(markdown_text)).to eq(html)
    end
  end
end
