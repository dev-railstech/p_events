desc "This task is called by the Heroku scheduler add-on"
task :notify_expired => :environment do
  Event.active.all.each do |event|
    if event.expire_at > Time.now
      event.is_active = false
      Notifier.event_expiry(event.user,event).deliver
      puts "event expired successfully"
    end
  end
  puts "done."
end