util_shader = {
	enabled = false,
}

-- watch um Mods/Wormhole/assets/shaders/util-modders/test.fs
require"debugplus.watcher".types.um = {
	desc = "This is hella unsupported",
	check = function()
		if SMODS and SMODS.ScreenShaders then
			return true
		end
		return false, "Steamodded (v1.0.0~+) is necessary to watch shader files."
	end,
	run = function(content)
		local result, shader = pcall(love.graphics.newShader, content)
		if not result then
			return print("[Watcher] Error Loading Shader:", shader)
		end
		G.SHADERS.worm_util_test = shader
		return true
	end,
}


SMODS.ScreenShader {
    key = "util_test",
    path = "util-modders/test.fs",
    -- send_vars = function(self)
    --     return {
    --         iTime = G.TIMERS.REAL
    --     }
    -- end,
    should_apply = function()
        return util_shader.enabled
    end
}
