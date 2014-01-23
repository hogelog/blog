class Article < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true
  validates :text, presence: true

  scope :recent, ->(count){ order('id DESC').limit(count) }

  def prev
    Article.where('id < ?', id).order(:id).last
  end

  def next
    Article.where('id > ?', id).order(:id).first
  end

  def self.extract_title_text(combined_text)
    lines = combined_text.to_s.split(/(?:\r\n|\r|\n)/)
    text = lines.size > 1 ? lines[1..-1].join("\r\n") : ""
    {
      title: lines[0].to_s,
      text: text,
    }
  end

  def title_text
    if text.blank?
      title
    else
      "#{title}\r\n#{text}"
    end
  end

  @@tataki ||= ::Tataki::Converter::SkkJisyo.new(%w[M jinmei])
  def hiragana
    self.title = @@tataki.to_kana(self.title)
    self.text = @@tataki.to_kana(self.text)
    @hiragana = true
    self
  end

  def hiragana?
    @hiragana
  end

  def social_title
    "#{title} - blog.hogel.org"
  end
end
