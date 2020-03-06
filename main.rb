require 'dxopal'
include DXOpal

Sound.register(:zun1, 'zun1.wav')
Sound.register(:zun2, 'zun2.wav')
Sound.register(:zun3, 'zun3.wav')
Sound.register(:zun4, 'zun4.wav')
Sound.register(:doko, 'doko.wav')
Sound.register(:kiyoshi, 'kiyoshi.wav')
Sound.register(:yabe, 'yabe.wav')

Window.load_resources do
  Window.bgcolor = C_BLACK
  # zun doko
  zun, doko = zundoko = ["ズン", "ドコ"]

  # zun counter
  count = 0
  all = 0
  str = []
  endflag = false

  # main loop
  Window.loop do
    if !endflag
      # create zun or doko
      zd = zundoko[rand 2]
      str << '' if all % 11 == 0
      str[all / 11] += zd + ' '
      all += 1
      str.each_with_index do |s, i|
        Window.draw_font(0, i * 40, s, Font.default, color: C_WHITE)
      end

      if zd == 'ズン'
        if count == 0
          Sound[:zun4].play
        elsif count == 1
          Sound[:zun2].play
        elsif count == 2
          Sound[:zun3].play
        elsif count == 3
          Sound[:zun4].play
        else
          Sound[:yabe].play
        end
      else
        Sound[:doko].play
      end
      sleep 1

      # judge
      case zd
      when zun
        count += 1
      when doko
        if count >= 4
          str[all / 11] += 'キ!ヨ!シ!'
          Sound[:kiyoshi].play
          str.each_with_index do |s, i|
            Window.draw_font(0, i * 40, s, Font.default, color: C_WHITE)
          end
          endflag = true
        else
          count = 0
        end
      end
    else
      str.each_with_index do |s, i|
        Window.draw_font(0, i * 40, s, Font.default, color: C_WHITE)
      end
    end
  end
end
