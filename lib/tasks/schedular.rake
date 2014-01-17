desc "This task is called by the Heroku scheduler add-on"
task :notify_expired => :environment do
  Event.all.each do |event|
    if event.expire_at < Time.now and event.is_active == true
      event.is_active = false
      event.save
      Notifier.event_expiry(event.user,event).deliver
      puts "event expired successfully"
    end
  end
  puts "done."
end