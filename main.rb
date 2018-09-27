# Let's begin "Zun Doko Kiyoshi" !

# zun doko
zun, doko = zundoko = ["ズン", "ドコ"]

# zun counter
count = 0

# main loop
loop do
  # create zun or doko
  zd = zundoko[rand 2]
  print zd, " "
  sleep 0.3

  # judge
  case zd
  when zun
    count += 1
  when doko
    if count >= 4
      puts "キ!ヨ!シ!"
      break
    else
      count = 0
    end
  end
end

