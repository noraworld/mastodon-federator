require 'mastodon'
require 'dotenv'

Dotenv.load
client = Mastodon::REST::Client.new base_url: ENV['BASE_URL'], bearer_token: ENV['BEARER_TOKEN']

print 'Which command do you want to run, follow or unfollow: '
cmd = gets.to_s.chomp

unless cmd == 'follow' || cmd == 'unfollow'
  puts "Invalid command #{cmd}"
  exit
end

print "Who do you want to #{cmd} [id]: "
id = gets.to_s.chomp
print "Are you sure you want to #{cmd} #{client.account(id).acct} [y/n]: "
confirmation = gets.to_s.chomp
unless confirmation == 'y'
  puts 'Canceled'
  exit
end

case cmd
when 'follow'
  target = client.follow(id)
  if target.following?
    puts 'Followed successfully'
  else
    puts 'Follow failed'
  end
when 'unfollow'
  target = client.unfollow(id)
  unless target.following?
    puts 'Unfollowed successfully'
  else
    puts 'Unfollow failed'
  end
else
  puts "We're sorry, but something went wrong"
  exit
end
