require 'ruby2d'

class Integer
    N_BYTES = [42].pack('i').size
    N_BITS = N_BYTES * 16
    MAX = 2 ** (N_BITS - 2) - 1
    MIN = -MAX - 1
end
=begin
Formula of rotating entity via mouse pos.
(in Unity-C#)
float AngleRad = Mathf.Atan2(Input.mousePosition.y - transform.position.y, Input.mousePosition.x - transform.position.x);
         float AngleDeg = (180 / Mathf.PI) * AngleRad;
         this.transform.rotation = Quaternion.Euler(0, 0, AngleDeg);
=end

class Vector2D
    attr_accessor :x, :y
    def initialize(x, y)
        @x = x
        @y = y
    end

    def show
        puts %{Vec<#{@x}, #{@y}>}
    end
end

class ColorConfig
    def initialize(choice, r: nil, g: nil, b: nil, a: nil, hex: nil)
        @r = r
        @g = g
        @b = b
        @a = a
        @value = nil
        @hex = hex

        if choice == 0
            hex(@hex)
        elsif choice == 1
            rgba([@r, @g, @b, @a])
        else
            raise "ColorConfig_IndexError: Color settings will be 0 or 1 (0 for hex, 1 for rgba)."
        end
    end

    def rgba(rgba_list)
        rgba_list.each do |x|
            if x > 1 or x < 0
                raise "RGBA_RangeError: #{x} will be in 0 <= x <= 1."
            else
                nil
            end
        end
        @value = rgba_list
    end

    def hex(hex_value)
        hex_range = [1,2,3,4,5,6,7,8,9,0,"a","b","c","d","e","f"]
        hex_value.split('').each do |x|
            if x == "#"
                nil
            elsif x.in?(hex_range)
                nil
            else
                raise "HexValueError(Yours= #{x}): each element will be contain in this list: #{hex_range}"
            end
        end
        @value = hex_value
    end

    def show
        p @value
    end
end

set title: "GunBoi"
set background: "black"
set width: 1920, height: 1080
set fullscreen: true

bg_music = Music.new('./music.mp3')
bg_music.loop = true
bg_music.volume = 30
bg_music.play

class Projectile
    WIDTH = 6 * 3
    HEIGHT = 6 * 3
    SPEED = 12

    def initialize(x,y)
        @image = Sprite.new(
            'projectile.png',
            x: @x,
            y: @y,
            width: WIDTH,
            height: HEIGHT,
            rotate: 180
        )
        @x_velocity = Math.sin(@image.rotate * Math::PI / 180) * SPEED
        @y_velocity = -Math.cos(@image.rotate * Math::PI / 180) * SPEED
    end

    def move
        @image.x += @x_velocity
        @image.y += @y_velocity
    end
end
class Player
    attr_accessor :health, :ammo, :width, :height, :speed, :projectile_speed, :player_sprite, :gun
    def initialize(health: 100, ammo: Integer::MAX, height: 20, width: 20, speed: 0.04)
        @ammo = ammo
        @width = width
        @height = height
        @speed = speed

        @gun_x = Window.width  / 2 + 45
        @gun_y = Window.height / 2 + 45
        @projectile_speed = defined? projectile_speed ? projectile_speed : @speed
        
        @player = Ruby2D::Sprite.new(
            "player_png/ayaz.png",
            x: @gun_x - 65, y: @gun_y - 65,
            height: 200, width: 200,
            rotate:0
        )
        @gun = Ruby2D::Sprite.new(
            "gun.png",
            x: @gun_x + 30 , y: @gun_y,
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
        @player.rotate = @angle
    end
end
player = Player.new()
update {

    on :key_held do |event|
        if event.key == "a"
            player.player.x -= player.speed
            player.gun.x -= player.speed
        elsif event.key == "d"
            player.player.x += player.speed
            player.gun.x -= player.speed
        elsif event.key == "w"
            player.player.y -= player.speed
            player.gun.y -= player.speed
        elsif event.key == "s"
            player.player.y += player.speed
            player.gun.y += player.speed
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
