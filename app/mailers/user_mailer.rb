class UserMailer < ApplicationMailer
  default from: "linkdr.co@gmail.com"
  
  def technical_test
    @candidate = params[:candidate]
    mail(to: @candidate.email, subject: "Congrats, you're Linkd!")
  end
end

