class CompanyMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(company)
    @company = company
    @url  = 'http://example.com/login'
    mail(to: 'aydinbg@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
