class Article < ActiveRecord::Base
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true
  validates :text, presence: true

  def self.extract_title_text(combined_text)
    lines = combined_text.to_s.split
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
end
