class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 5}
  validates :url, presence: true, format: { :with => URI::DEFAULT_PARSER.make_regexp }
  validates :user, presence: true
end
