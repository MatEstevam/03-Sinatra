class User < ActiveRecord::Base
  has_many :posts
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: /\A.*@.*\.com\z/ }

  before_validation :strip_email_whitespace
  after_create :send_welcome_email


  private

    def strip_email_whitespace
      self.email = email.strip if email.present?
    end

    def send_welcome_email
      FakeMailer.instance.mail("#{email}", "Welcome!")
    end
end
