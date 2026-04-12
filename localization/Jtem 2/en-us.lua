return {
	descriptions = {
		Joker = {
			j_worm_jtem2_cosmic_ray = {
				name = "Cosmic Ray",
				text = {
					"Convert a random card in full deck",
					"to a {C:attention}Gold{} card whenever a",
					"{C:planet}Planet{} card different from the most",
					"recently used one is used",
					"{C:inactive}(Last used planet: {V:1}#1#{C:inactive}){}",
				},
			},
			j_worm_jtem2_quantum_rock = {
				name = "Quantum Rock",
				text = {
					{
						"Exist in all places at the same time",
						"Only one can be observed",
					},
				},
			},
			j_worm_jtem2_solar_system = {
				name = "Artificial Solar System",
				text = {
					{
						"This Joker gains more abilities for each",
						"unique vanilla {C:planet}Planet{} card used",
					},
					{
						"{C:attention}USE{} to toggle planets render",
					},
				},
			},
			j_worm_jtem2_tetris = {
				name = {
					"Terror Instinct",
					"{E:1,s:0.5,C:edition}Tetris: The Grandmaster 3",
				},
				text = {
					{
						"{E:1,s:1.2,C:dark_edition}Play Tetris!",
						"{X:mult,C:white}XMult{} is determined by",
						"{C:attention}current level{} divided by 100 plus one",
						"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
					},
					{
						"Please check the mod options for {C:attention}keybinds{}!",
						"Level {C:attention}increases{} per piece placed",
						"{C:inactive,s:0.8}(A line clear is required at 99, 199, etc)",
					},
				},
			},
			j_worm_jtem2_egogeocentrism = {
				name = "Egogeocentrism",
				text = {
					"If played hand is a {C:attention}#1#{}",
					"{C:green}#3# in #4#{} chance for each",
					"played {C:attention}#2#{} to create a",
					"{C:planet}Planet{} card when scored",
					"{C:inactive}(Must have room){}",
				},
			},
		},
		Other = {
			worm_jtem2_solar_system_effect_c_mercury = {
				name = "Mercury's ability",
				text = {
					"{C:mult}#1#{} Mult or {C:chips}#2#{} Chips",
				},
			},
			worm_jtem2_solar_system_effect_c_venus = {
				name = "Venus' ability",
				text = {
					"Create {C:tarot}Tarot{} card ",
					"if score is on {C:attention}fire{}",
					"{C:inactive}(Must have room){}",
				},
			},
			worm_jtem2_solar_system_effect_c_earth = {
				name = "Earth's ability",
				text = {
					"All {C:planet}Planet{} cards and",
					"{C:planet}Celestial Packs{} in",
					"the shop cost {C:money}$#1#{} less",
				},
			},
			worm_jtem2_solar_system_effect_c_mars = {
				name = "Mars' ability",
				text = {
					"Create {C:attention}#1#{}",
					"when {C:attention}Blind{} is selected",
					"{C:inactive}(Must have room){}",
				},
			},
			worm_jtem2_solar_system_effect_c_ceres = {
				name = "Ceres' ability",
				text = {
					"{C:attention}#1#{} counts as {C:attention}#2#{}",
					"If cards share the same suit",
					"then counts as {C:attention}#3#{}",
				},
			},
			worm_jtem2_solar_system_effect_c_jupiter = {
				name = "Jupiter's ability",
				text = {
					"{X:mult,C:white}X#1#{}",
				},
			},
			worm_jtem2_solar_system_effect_c_saturn = {
				name = "Saturn's ability",
				text = {
					"Add #1# {C:attention}Stone{}",
					"cards to a deck",
				},
			},
			worm_jtem2_solar_system_effect_c_uranus = {
				name = "Uranus' ability",
				text = {
					"{X:chips,C:white}X#1#{}",
				},
			},
			worm_jtem2_solar_system_effect_c_neptune = {
				name = "Neptune's ability",
				text = {
					"Each {C:diamonds}#1#{} card",
					"gives {C:money}$#2#{}:",
					"{C:green}#3# in #4#{} when scored",
					"{C:green}#5# in #6#{} when held in hand",
				},
			},
			worm_jtem2_solar_system_effect_c_pluto = {
				name = "Pluto's ability",
				text = {
					"{C:green}#1# in #2#{} {C:attention}level up{}",
					"random poker hand",
					"{C:green}#1# in #2#{} {C:attention}decrease level{}",
					"of random poker hand",
				},
			},
			worm_jtem2_solar_system_effect_c_eris = {
				name = "Eris' ability",
				text = {
					"{C:attention}#1#{} counts",
					"as {C:attention}#2#{}",
					"If cards share the same suit",
					"then counts as {C:attention}#3#{}",
				},
			},
		},
		PotatoPatch = {
			PotatoPatchTeam_jtem2 = { name = "Jtem 2" },
			PotatoPatchDev_aikoyori = {
				name = "Aikoyori",
				text = {
					{ "box numero 1" },
				},
			},
			PotatoPatchDev_sleepyg11 = {
				name = "SleepyG11",
				text = {
					{ "box numero 1" },
				},
			},
			PotatoPatchDev_haya = {
				name = "Haya",
				text = {
					{ "box numero 1" },
				},
			},
			PotatoPatchDev_lexi = {
				name = "lexi",
				text = {
					{ "box numero 1" },
				},
			},
			PotatoPatchDev_ari = {
				name = "Ari",
				text = {
					{ "box numero 1" },
				},
			},
			PotatoPatchDev_missingnumber = {
				name = "missingnumber",
				text = {
					{ "box numero 1" },
				},
			},
		},
	},
	misc = {
		dictionary = {
			b_worm_jtem_reset = "RESET",

			k_worm_downgrade_ex = "Downgrade!",
		},
		-- Mostly taken from Handy
		jtem2_keybinds = {
			-- No button assigned
			["None"] = "None",
			-- Button which cannot be recognized
			["Unknown"] = "Unknown",

			-- Mouse
			["Left Mouse"] = nil,
			["Right Mouse"] = nil,
			["Middle Mouse"] = nil,
			["Mouse 4"] = nil,
			["Mouse 5"] = nil,
			["Wheel Up"] = nil,
			["Wheel Down"] = nil,
			-- Controls
			["Escape"] = nil,
			["Shift"] = nil,
			["Ctrl"] = nil,
			["Alt"] = nil,
			["GUI"] = nil, -- Windows button, or CMD for Mac
			["Enter"] = nil,
			["Tab"] = nil,
			["Backspace"] = nil,
			["Num Lock"] = nil,
			["Caps Lock"] = nil,
			["Scroll Lock"] = nil,
			-- Arrow keys
			["Left"] = nil,
			["Right"] = nil,
			["Up"] = nil,
			["Down"] = nil,
			-- Symbols
			["Backquote"] = nil, -- `
			["Singlequote"] = nil, -- '
			["Quote"] = nil, -- "
			["Left Bracket"] = nil, -- [
			["Right Bracket"] = nil, -- ]
			-- Weird buttons
			["Printscreen"] = nil,
			["Delete"] = nil,
			["Home"] = nil,
			["Insert"] = nil,
			["End"] = nil,
			["Pause"] = nil,
			["Help"] = nil,
			["Sysreq"] = nil,
			["Menu"] = nil,
			["Undo"] = nil,
			["Mode"] = nil,
			["Page Up"] = nil,
			["Page Down"] = nil,
			-- Very weird buttons, did they exist in 21th century?
			["Www"] = nil,
			["Mail"] = nil,
			["Calculator"] = nil,
			["Computer"] = nil,
			["Appsearch"] = nil,
			["Apphome"] = nil,
			["Appback"] = nil,
			["Appforward"] = nil,
			["Apprefresh"] = nil,
			["Appbookmarks"] = nil,
			["Currencyunit"] = nil,
			["Application"] = nil,
			["Power"] = nil, -- What a heck

			-- Gamepad: buttons
			["(A)"] = nil,
			["(B)"] = nil,
			["(X)"] = nil,
			["(Y)"] = nil,
			["(Back)"] = nil,
			["(Guide)"] = nil,
			["(Start)"] = nil,
			-- Gamepad: directions
			-- In Balatro, Left Stick movement treated as direction buttons
			["(Up)"] = nil,
			["(Down)"] = nil,
			["(Left)"] = nil,
			["(Right)"] = nil,
			-- Gamepad: sticks, triggers, bumpers and paddles
			["Left Stick"] = nil, -- Click
			["Right Stick"] = nil, -- Click
			["Left Bumper"] = nil, -- LB
			["Right Bumper"] = nil, -- RB
			["Left Trigger"] = nil, -- LT
			["Right Trigger"] = nil, -- RT
			-- Not supported by current LOVE engine version
			["First Paddle"] = nil, -- P1
			["Second Paddle"] = nil, -- P2
			["Third Paddle"] = nil, -- P3
			["Fourth Paddle"] = nil, -- P4
			["(Misc. Button)"] = nil,
			-- Gamepad: touchpad
			["Touchpad Press"] = nil,

			-- Not listed here, but can be added if you ever need:
			-- All english letters uppercase, (Q, W, E, R, T, Y...)
			-- All numbers (1, 2, 3...0)
			-- All F keys (F1, F2, F3...)
			-- All NUM keys (NUM 0 ... NUM 9, NUM Enter, NUM +, NUM -, NUM *, NUM /, NUM .)
			-- Other symbols (. ; / \ - + etc)
		},
	},
}
