class UserMailer < ApplicationMailer
  default from: "linkdr.co@gmail.com"
  
  def technical_test
    @candidate = params[:candidate]
    byebug
    mail(to: @candidate.email, subject: "Congrats, you're Linkd!")
  end
end

