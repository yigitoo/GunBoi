require 'ruby2d'

class Integer
    N_BYTES = [42].pack('i').size
    N_BITS = N_BYTES * 16
    MAX = 2 ** (N_BITS - 2) - 1
    MIN = -MAX - 1
end
=begin
 float AngleRad = Mathf.Atan2(Input.mousePosition.y - transform.position.y, Input.mousePosition.x - transform.position.x);
         float AngleDeg = (180 / Mathf.PI) * AngleRad;
         this.transform.rotation = Quaternion.Euler(0, 0, AngleDeg);

class Vector2D
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end
end
=end

set title: "GunBoi"
set background: "black"
set width: 1920, height: 1080
set fullscreen: true

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

class Player
    attr_accessor :health, :ammo, :width, :height, :speed, :projectile_speed, :player_sprite
    def initialize(health: 100, ammo: Integer::MAX, height: 20, width: 20, speed: 4)
        @ammo = ammo
        @width = width
        @height = height
        @speed = speed

        @gun_x = Window.width  / 2
        @gun_y = Window.height / 2
        @projectile_speed = defined? projectile_speed ? projectile_speed : @speed

        @gun = Ruby2D::Sprite.new(
            "gun.png",
            x: @gun_x , y: @gun_y,
            height: 25, width: 100,
            rotate: 0
        )
    end


    def fire(angle)
        @projectile = Quad.new(
            x1: 275, y1: 175,
            x2: 375, y2: 225,
            x3: 300, y3: 350,
            x4: 250, y4: 250,
            color: 'aqua',
            z: 10
        )
    end

    def set_mouse(mouseX, mouseY)
        @mouse_x = mouseX
        @mouse_y = mouseY
    end

    def rotate_gun()
        rel_x = @mouse_x - @gun_x
        rel_y = @mouse_y - @gun_y
        @angle = (Math.atan2(rel_y, rel_x)) * (180/Math::PI)
        @gun.rotate = @angle
    end
end
player = Player.new()
update {

    on :key_down do |event|
        if event.key == "a"
            player.player_sprite.x -= player.speed
        elsif event.key = "d"
            player.player_sprite.x += player.speed
        elsif event.key = "w"
            player.player_sprite.y += player.speed
        elsif event.key = "s"
            player.player_sprite.y -= player.speed
        end
    end

    on :mouse do |event|
        player.set_mouse(Window.mouse_x, Window.mouse_y)
        player.rotate_gun
        case event.button
        when :left
    #        player.fire
        end
    end
}

show
