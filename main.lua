Wormhole = SMODS.current_mod

assert(SMODS.current_mod.lovely,
    "Lovely modules were not loaded.\nMake sure your Wormhole folder is not nested (there should be a bunch of files in the Wormhole folder and not just another folder).")

-- Reset Game Globals func to hook
function Wormhole.reset_game_globals(run_start) end

if PotatoPatchUtils then
	local file_blacklist = {
		['tlr_gorilla.dll'] = true,
		-- Format entries as `['filename.txt'] = true`
		['loadlogo.lua'] = true,
	}

	PotatoPatchUtils.load_files(Wormhole.path .. '/content', file_blacklist)
	if Balatest then
		PotatoPatchUtils.load_files(Wormhole.path .. '/test', file_blacklist)
	end
	SMODS.handle_loc_file(Wormhole.path)
	PotatoPatchUtils.LOC.init()

	SMODS.current_mod.extra_tabs = PotatoPatchUtils.CREDITS.register_page(SMODS.current_mod)
end

SMODS.Atlas {
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}

--#region Custom Menu
SMODS.Atlas {
	key = 'logo',
	path = 'wormhole logo.png',
	px = 148,
	py = 158
}

Wormhole.colours = {
	primary = HEX('73fdff'),
	secondary = HEX('011638')
}

function Wormhole.init_custom_menu(change_context)
	if Wormhole.config.menu then
		--Remove menu Ace
		if not G.title_top.cards[1].mod_flag then
			G.title_top.cards[1]:remove()
			G.title_top.T.w = G.title_top.T.w - (1.7675 / math.max(#G.title_top.cards, 1))
			G.title_top.T.x = G.title_top.T.x + (0.885 / math.max(#G.title_top.cards, 1))
		end

		-- Creates Wormhole Logo Sprite
		local SC_scale = 1.1 * (G.debug_splash_size_toggle and 0.8 or 1)
		G.SPLASH_WORMHOLE_LOGO = Sprite(0, 0,
			3.5 * SC_scale,
			3.5 * SC_scale * (G.ASSET_ATLAS["worm_logo"].py / G.ASSET_ATLAS["worm_logo"].px),
			G.ASSET_ATLAS["worm_logo"], { x = 0, y = 0 }
		)
		G.SPLASH_WORMHOLE_LOGO:set_alignment({
			major = G.title_top,
			type = 'cm',
			bond = 'Strong',
			offset = { x = 0, y = 0 }
		})
		G.SPLASH_WORMHOLE_LOGO:define_draw_steps({ {
			shader = 'dissolve',
		} })

		-- Define logo properties
		G.SPLASH_WORMHOLE_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }

		G.SPLASH_WORMHOLE_LOGO.dissolve_colours = { Wormhole.colours.primary, Wormhole.colours.secondary }
		G.SPLASH_WORMHOLE_LOGO.dissolve = 1

		G.SPLASH_WORMHOLE_LOGO.states.collide.can = true

		-- Define node functions for Logo
		function G.SPLASH_WORMHOLE_LOGO:click()
			play_sound('button', 1, 0.3)
			SMODS.LAST_SELECTED_MOD_TAB = nil
			G.FUNCS['openModUI_Wormhole']()
			G.OVERLAY_MENU:get_UIE_by_ID("overlay_menu_back_button").config.button = "exit_overlay_menu_Wormhole"
		end

		G.FUNCS.exit_overlay_menu_Wormhole = function()
			G.ACTIVE_MOD_UI = nil
			G.FUNCS.exit_overlay_menu()
		end

		function G.SPLASH_WORMHOLE_LOGO:hover()
			G.SPLASH_WORMHOLE_LOGO:juice_up(0.05, 0.03)
			play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
			Node.hover(self)
		end

		function G.SPLASH_WORMHOLE_LOGO:stop_hover() Node.stop_hover(self) end

		--Logo animation
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = change_context == 'game' and 1.5 or 0,
			blockable = false,
			blocking = false,
			func = (function()
				ease_value(G.SPLASH_WORMHOLE_LOGO, 'dissolve', -1, nil, nil, nil,
					change_context == 'splash' and 2.3 or 0.9)
				G.VIBRATION = G.VIBRATION + 1.5
				return true
			end)
		}))

		-- make the title screen use different background colors
		G.SPLASH_BACK:define_draw_steps({ {
			shader = 'splash',
			send = {
				{ name = 'time',       ref_table = G.TIMERS,         ref_value = 'REAL_SHADER' },
				{ name = 'vort_speed', val = 0.4 },
				{ name = 'colour_1',   ref_table = Wormhole.colours, ref_value = 'primary' },
				{ name = 'colour_2',   ref_table = Wormhole.colours, ref_value = 'secondary' },
			}
		} })
	end
end

--#endregion

--#region Config
Wormhole.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { align = "m", r = 0.1, padding = 0.05, colour = G.C.BLACK, minw = 8, minh = 6 },
		nodes = {
			{ n = G.UIT.R, config = { align = "cl", padding = 0, minh = 0.1 }, nodes = {} },

			{
				n = G.UIT.C,
				config = { align = "cm", padding = 0.05 },
				nodes = {
					-- Custom Menu Toggle
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cl", padding = 0.05 },
								nodes = {
									create_toggle { col = true, label = "", scale = 0.8, w = 0, shadow = true, ref_table = Wormhole.config, ref_value = "menu" },
								}
							},
							{
								n = G.UIT.C,
								config = { align = "c", padding = 0 },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('b_wormhole_custom_menu'), scale = 0.35, colour = G.C.UI.TEXT_LIGHT } },
								}
							},
						},
					},
					-- Nyancat tart effect toggle
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cl", padding = 0.05 },
								nodes = {
									create_toggle { col = true, label = "", scale = 0.8, w = 0, shadow = true, ref_table = Wormhole.config, ref_value = "disable_nyan" },
								}
							},
							{
								n = G.UIT.C,
								config = { align = "c", padding = 0 },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('b_wormhole_disable_nyan'), scale = 0.35, colour = G.C.UI.TEXT_LIGHT } },
								}
							},
						},
					},
					-- Family friendly mode
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cl", padding = 0.05 },
								nodes = {
									create_toggle { col = true, label = "", scale = 0.8, w = 0, shadow = true, ref_table = Wormhole.config, ref_value = "family_friendly" },
								}
							},
							{
								n = G.UIT.C,
								config = { align = "c", padding = 0 },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('b_wormhole_family_friendly'), scale = 0.35, colour = G.C.UI.TEXT_LIGHT } },
								}
							},
						},
					},
					-- Cosmic Gorilla Beast Mode
					{
						n = G.UIT.R,
						config = { align = "cm", padding = 0 },
						nodes = {
							{
								n = G.UIT.C,
								config = { align = "cl", padding = 0.05 },
								nodes = {
									create_toggle { col = true, label = "", scale = 0.8, w = 0, shadow = true, ref_table = Wormhole.config, ref_value = "cosmic_gorilla_beast_mode" },
								}
							},
							{
								n = G.UIT.C,
								config = { align = "c", padding = 0 },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('b_wormhole_cosmic_gorilla_beast_mode'), scale = 0.35, colour = G.C.UI.TEXT_LIGHT } },
								}
							},
						},
					},

					{ n = G.UIT.R, config = { minh = 0.04, minw = 4, colour = G.C.L_BLACK } }, -- Line Break

					-- Tetris Keybinds
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0
						},
						nodes = {
							{
								n = G.UIT.C,
								config = { align = 'cm', padding = 0.05 },
								nodes = {
									JtemTGM.UI.CreateSection("Tetris - Piece movement"),
									JtemTGM.UI.CreateKeybindUI("Move piece left", "move_left"),
									JtemTGM.UI.CreateKeybindUI("Move piece right", "move_right"),
									JtemTGM.UI.CreateKeybindUI("Move piece down", "move_down"),
									JtemTGM.UI.CreateKeybindUI("Sonic drop", "sonic_drop"),
									JtemTGM.UI.CreateSection("Tetris - Piece manipulation"),
									JtemTGM.UI.CreateKeybindUI("Rotate piece left", "rotate_left"),
									JtemTGM.UI.CreateKeybindUI("Rotate piece right", "rotate_right"),
									JtemTGM.UI.CreateKeybindUI("Hold piece", "hold"),
								}
							}
						},
					},
				}
			},

			{ n = G.UIT.R, config = { align = "cl", padding = 0, minh = 0.1 }, nodes = {} },

		}
	}
end
--#endregion

assert(SMODS.load_file("bg.lua"))()
