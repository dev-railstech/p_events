class Notifier < ActionMailer::Base
  default from: "no-reply@taskfish.com"

  def invitation(user,email,event)
    @event = event
    @user = user
    mail( :to => email,
          :subject => "Event invitation from #{@user.name}"  )

  end
end
