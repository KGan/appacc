puts "Input your email:"
email = gets.chomp
user = User.create_or_return(email)
loop do
  puts "What do you want to do?"
  puts "0. Create shortened URL"
  puts "1. Visit shortened URL"
  puts "2. tag url"
  puts "3. top urls"
  puts "9. quit"
  option = gets.chomp.to_i

  if option == 0
    puts "Type in your long url"
    url = gets.chomp
    break if url.nil?
    s_url = ShortenedUrl.create_for_user_and_long_url!(user, url)

    puts "Short url is: #{s_url.short_url}"
  elsif option == 1
    puts "Type in the shortened URL"
    url = gets.chomp
    break if url.nil?
    Visit.record_visit!(user, url)
    address = ShortenedUrl.find_by_short_url(url)
    unless address
      puts "no url expansion found for #{url}"
      break
    end
    long_url = address.long_url
    puts "Tagged as:\n#{address.tags.pluck(:topic)}"
    Launchy.open(long_url) do |exception|
      puts exception
    end
  elsif option == 2
    puts "shortened url to tag?"
    url = gets.chomp.strip
    puts 'Tag as ?'
    new_tag = gets.chomp.strip
    break if new_tag.nil? or url.nil?
    Tagging.tag_url(user, ShortenedUrl.find_by_short_url(url), new_tag)
  elsif option == 3
    puts "category?"
    category = gets.chomp
    tt = TagTopic.find_by_topic(category)
    if tt
      puts "Popular in category '#{category}': #{tt.most_popular_link}"
    else
      puts "could not find category #{category}, giving you a random one."
      puts TagTopic.top_link_for.try(:short_url)
    end
  elsif option == 9
    exit(0)
  end
end
