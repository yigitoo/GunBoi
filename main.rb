require 'ruby2d'

set title: %(snake_game)
set background: "black"
set width: 500, height: 500

bg_music = Music.new('./music.mp3')
bg_music.loop = true
bg_music.volume = 30
bg_music.play


def gen_bg_color
    hex_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0].join(' ').split
    hex_arr += ["a", "b", "c", "d", "e", "f"]

    color_code = "#"
    6.times do
        color_code += hex_arr.shuffle.first
    end

    return color_code
end

mouse_pos = [0, 0]
update {

    on :key_down do |event|
        if event.key == "a"

        end
    end

    on :mouse_down do |event|
        puts event.x, event.y
        case event.button
        when :left
            p %(heyyo)
        end
    end
}

show
