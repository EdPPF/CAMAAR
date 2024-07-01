require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before do
    # Ensure the default URL options are set
    @host = 'localhost'
    @port = 3000
    @default_url_options = { host: @host, port: @port }
    allow(Rails.application.config.action_mailer).to receive(:default_url_options).and_return(@default_url_options)
  end
  describe "welcome_email" do
    let(:user) { FactoryBot.create(:user, email: 'gabrielbfranca@gmail.com') }
    let(:password) { "123456" }

    before { Devise.mailer = UserMailer }  # Temporarily set UserMailer for tests

    it 'sends a welcome email with password reset link' do
      expect { UserMailer.welcome_email(user, password).deliver_now! }
        .to change { ActionMailer::Base.deliveries.count }.by(1)

      # Optional: Test email content (if applicable)
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body.encoded).to include(user.nome)
    end
  end

end
