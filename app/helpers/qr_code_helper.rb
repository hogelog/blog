module QrCodeHelper
  CODE_SIZE = 5
  def qr_code(url)
    qrcode = RQRCode::QRCode.new(url, size: CODE_SIZE, level: :h)
    render "shared/qr_code", qrcode: qrcode
  end
end
