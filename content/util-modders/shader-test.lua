util_shader = {
    enabled = false,
    transparency = 1.0,
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
    should_apply = function()
	return util_shader.enabled
    end,
    send_vars = function()
	return {
	    screen_scale = G.TILESCALE*G.TILESIZE*G.CANV_SCALE,
	    time = G.TIMERS.REAL,
	    transparency = util_shader.transparency,
	    seed = 1,
	}
    end
}
