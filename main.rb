zun, doko = zundoko = ["ズン", "ドコ"]

count = 0
loop do
  zd = zundoko[rand 2]
  print zd, " "
  sleep 1

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

