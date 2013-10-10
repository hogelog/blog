require 'spec_helper'

describe QrCodeHelper do
  describe ".qr_code" do
    let(:url) { "http://blog.hogel.org/" }
    subject { qr_code(url).chomp }

    it "returns qrcode table html" do
      expect(subject).to start_with("<div class='qr_code'><table>")
      expect(subject).to end_with("</table></div>")
    end
  end
end
