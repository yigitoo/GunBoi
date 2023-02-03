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
            raise "Index Error: Color settings will be 0 or 1 (0 for hex, 1 for rgba)."
        end
    end

    def rgba(rgba_list)
        @value = rgba_list
    end

    def hex(hex_value)
        @value = hex_value
    end

    def show
        p @value
    end
end

ColorConfig.new(1, r: 1, g: 0.1, b: 3, a: 5).show