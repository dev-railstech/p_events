class Notifier < ActionMailer::Base
  default from: "no-reply@taskfish.com"

  def notify_user(user,email,event)
    @event = event
    @user = user
    mail( :to => email,
          :subject => "Event invitation from #{@user.name}"  )

  end

  def invitation(user,email,event)
    @event = event
    @user = user
    mail( :to => email,
          :subject => "Event invitation from #{@user.name}"  )

  end
end
