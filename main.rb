require 'dxopal'
include DXOpal

Sound.register(:zun1, 'zun1.wav')
Sound.register(:zun2, 'zun2.wav')
Sound.register(:zun3, 'zun3.wav')
Sound.register(:zun4, 'zun4.wav')
Sound.register(:doko, 'doko.wav')
Sound.register(:kiyoshi, 'kiyoshi.wav')
#Sound.register(:yabe, 'yabe.wav')

Window.load_resources do
  Window.bgcolor = C_BLACK
  # zun doko
  zun, doko = zundoko = ["ズン", "ドコ"]

  # zun counter
  count = 0
  all = 0
  loop_count = 0
  str = []
  kiyoshi = false
  stop = true
  zd = nil

  # main loop
  Window.loop do
    if stop
      Window.draw_font(250, 400, 'Push to Start', Font.default, color: C_WHITE)
      if Input.mouse_push?(M_LBUTTON)
        str = []
        all = 0
        count = 0
        kiyoshi = false
        stop = false
      end
    else
      if loop_count == 0
        # create zun or doko or kiyoshi
        str << '' if all % 11 == 0
        if kiyoshi
          zd = nil
          str[all / 11] += 'キヨシ！'
        else
          zd = zundoko[rand 2]
          str[all / 11] += zd + ' '
          all += 1
        end

        # count zun doko
        case zd
        when zun
          count += 1
        when doko
          kiyoshi = true if count >= 4
          count = 0
        end

        # SE
        if zd == zun
          if count == 1
            Sound[:zun1].play
          elsif count == 2
            Sound[:zun2].play
          elsif count == 3
            Sound[:zun3].play
          elsif count == 4
            Sound[:zun4].play
          else
            Sound[:zun1].play
          end
        elsif zd == doko
          Sound[:doko].play
        else
          Sound[:kiyoshi].play
          stop = true
        end
      end

      loop_count += 1
      loop_count %= 60
    end

    # display log
    str.each_with_index do |s, i|
      Window.draw_font(0, i * 40, s, Font.default, color: C_WHITE)
    end
  end
end
