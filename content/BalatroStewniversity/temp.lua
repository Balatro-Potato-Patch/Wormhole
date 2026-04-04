
SMODS.ScreenShader {
    key = "black_hole",
    path = "BalatroStewniversity/black_hole.fs",
    send_vars = function(self)
        return {
            hole_coords = {love.mouse.getX(), love.mouse.getY()},
        }
    end
}

