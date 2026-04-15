return {
	descriptions = {
		Back = {
			b_worm_jtem2_black_hole_deck = {
				name = "Black Hole Deck",
				text = {
					"{C:spectral}Spectral Cards{} may appear in shop",
					"but no {C:tarot}Tarot Cards{} can",
					"Start with {C:attention}2{} {C:spectral,T:c_worm_jtem2_kilonovae}Kilonovae{}",
				},
			},
		},
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
						"{X:mult,C:white}X#1#{}",
						"{C:attention}#2#{} of {V:1}#3#{}",
					},
					{
						"Exist in all places at the same time",
						"Only one can be observed",
						"{C:inactive}(Can be disabled in mod config){}",
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
			j_worm_jtem2_operation_plumbbob = {
				name = "Operation Plumbbob",
				text = {
					"Destroy {C:attention}all{} played cards",
					"if you have a {C:planet}Planet{} card",
					"Destroys a random {C:planet}Planet{}",
					"card if successful",
				},
			},
			j_worm_jtem2_stair = {
				name = "Astral Stair",
				text = {
					"Gives {C:mult}Mult{} equal to {C:mult}Mult{}",
					"of {C:attention}most played{} poker hand",
					"Changes to {C:chips}Chips{} at the end of round",
					"{C:inactive}(Currently {C:mult}#1#{C:inactive} Mult from {C:attention}#2#{C:inactive}){}",
				},
			},
			j_worm_jtem2_stair_chips = {
				name = "Astral Stair",
				text = {
					"Gives {C:chips}Chips{} equal to {C:chips}Chips{}",
					"of {C:attention}most played{} poker hand",
					"Changes to {C:mult}Mult{} at the end of round",
					"{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips from {C:attention}#2#{C:inactive}){}",
				},
			},
			j_worm_jtem2__stair = {
				name = "Stair",
				text = {
					"This Joker gains {C:white,X:mult} X#1#{} Mult",
					"if consecutive {C:attention}Straight",
					"from either end {C:inactive}(#2# and #3#){} of your last one",
					"{C:inactive}(Example: Next valid hand for [{C:attention}A{} 2 3 4 {C:attention}5{C:inactive}]",
					"{C:inactive}is [{C:attention}6{} 7 8 9 {C:attention}10{C:inactive}] or [{C:attention}K{} Q J 10 {C:attention}9{C:inactive}])",
				},
			},
			j_worm_jtem2_lumichan = {
				name = "Lumistratos",
				text = {
					{
						"This Joker gains {C:attention}#3#{} consumable slot",
						"for every {C:attention}#1#{} {C:inactive}[#2#]{C:attention} Consumables{} used",
						"{C:inactive}(Currently {C:attention}#4#{C:inactive} consumable slots)",
					},
					{
						"{C:inactive,E:1}Great Lady of Space,",
						"{C:inactive,E:1}a refined individual",
						"{C:inactive,E:1}who rules over the void.",
					},
				},
			},
			j_worm_jtem2_eclipse = {
				name = "Eclipse",
				text = {
					{
						"{X:purple,C:white,s:0.9}usable{}",
						"Cause an {C:attention,E:worm_jtem2_snaking}Eclipse{} {C:inactive}(Solar or Lunar){}",
						" by using respective {C:tarot}Tarots{} and {C:planet}Planets{} in order",
						"Use {C:tarot}Sun{}, {C:tarot}Moon{}, {C:planet}Earth{} for {C:red}Solar{} Eclipse",
						"Use {C:tarot}Sun{}, {C:planet}Earth{}, {C:tarot}Moon{} for {C:blue}Lunar{} Eclipse",
						"{C:inactive}(Currently {V:1}#1#{C:inactive})",
					},
					{
						"If used during {C:red}Solar{} Eclipse",
						"if {C:red}Discards{} is an {C:attention}odd number{}",
						"turns {C:attention}all cards in hand{} to {C:hearts}Hearts",
						"if {C:red}Discards{} is an {C:attention}even number{}",
						"turns {C:attention}all cards in hand{} to {C:diamonds}Diamonds",
					},
					{
						"If used during {C:blue}Lunar{} Eclipse",
						"if {C:blue}Hands{} is an {C:attention}odd number{}",
						"turns {C:attention}all cards in hand{} to {C:clubs}Clubs",
						"if {C:blue}Hands{} is an {C:attention}even number{}",
						"turns {C:attention}all cards in hand{} to {C:spades}Spades",
					},
				},
			},
			j_worm_jtem2_alien_alien = {
				name = {
					"{f:5}エイリアンエイリアン{}",
					"Alien Alien",
				},
				text = {
					{
						"{C:green}#1# in #2#{} chance to create",
						"a {C:tarot}Tarot{} card when",
						"a {C:planet}Planet{} card is used.",
					},
				},
			},
			j_worm_jtem2_kurzgesagt = {
				name = {
					"Kurzgesagt",
					"{s:0.8}- in a nutshell -",
				},
				text = {
					{
						"Scored {C:attention}Steel Cards{} becomes {C:green}Strange Card{}",
						"Scored {C:attention}Gold Cards{} becomes {C:blue}Gravacard{}",
						"Scored {C:attention}Stone Card{} becomes {C:spectral}Neutron Card{}",
					},
				},
			},
		},
		Enhanced = {
			m_worm_jtem2_strange_card = {
				name = "Strange Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult when held",
					"Randomize value on any {C:attention}hand drawn{}",
					"{C:inactive}(from {X:mult,C:white}X#2#{C:inactive} to {X:mult,C:white}X#3#{C:inactive})",
				},
			},
			m_worm_jtem2_gravacard = {
				name = "Gravacard",
				text = {
					"Gain {C:money}${} based on how many cards",
					"are to the {C:attention}right{} when held",
					"{X:blind,C:white}X#1#{} Blind Size when this is drawn",
				},
			},
			m_worm_jtem2_neutron_card = {
				name = "Neutron Card",
				text = {
					"When {C:attention}scored{}",
					"{X:mult,C:white}X#1#{} Mult if hand score is on fire",
					"{X:purple,C:white}X#2#{} Score otherwise",
				},
			},
		},
		Tarot = {
			c_worm_jtem2_shadow = {
				name = "The Shadow",
				text = {
					"{C:attention}Steals{} the levels of a",
					"{C:attention}random{} poker hand and applies",
					"it to your {C:attention}most played{} hand",
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
			worm_jtem2_black_hole_seal = {
				name = "Black Hole Seal",
				text = {
					"{C:green}#1# in #2#{} chance to upgrade a {C:attention}random{}",
					"poker hand when played and scored",
					"{C:green}#3# in #4#{} chance to {C:attention}destroy{} card",
				},
			},
			worm_jtem2_supermassive_black_hole_seal = {
				name = "Supermassive Black Hole Seal",
				text = {
					"{C:green}#1# in #2#{} chance to upgrade {C:attention}played{}",
					"poker hand when played and scored",
					"{C:green}#3# in #4#{} chance to {C:attention}destroy{} card",
				},
			},
		},
		Spectral = {
			c_worm_jtem2_kilonovae = {
				name = "Kilonovae",
				text = {
					"Apply {C:attention}Black Hole Seal{}",
					"to up to {C:attention}#1#{} selected cards",
					"Apply {C:spectral}Supermassive Black Hole Seal{}",
					"if card already has {C:attention}Black Hole Seal{}",
				},
			},
		},
		PotatoPatch = {
			PotatoPatchTeam_jtem2 = { name = "Jtem 2" },
			PotatoPatchDev_aikoyori = {
				name = "Aikoyori",
				text = {
					{
						"{s:3.2,E:worm_jtem2_rainbow_wiggle}Hello!{}",
						"This is {E:worm_jtem2_rainbow_wiggle,C:white}Aikoyori{} from {E:worm_jtem2_rainbow_wiggle,C:white}Shenanigans",
						" ",
						"Back at it with {C:worm_jtem2_teamcolor}Jtem{C:worm_jtem2_teamcolor,E:worm_jtem2_exponent}2{}after {C:attention,E:worm_jtem2_snaking}Hot Potato{} was not enough",
						"but I think we cooked. In what essentially is {C:attention,E:worm_jtem2_snaking}Hot Potato{C:attention,E:worm_jtem2_exponent}2{}",
						"I reduced my role as programmer and worked on",
						"{C:inactive}(^ this was a lie btw i did more than just art last minute)",
						"the {C:attention}these credits sprites{} you're looking at!",
						"That's all from me! See you next time!",
						" ",
						"{s:1.5,E:worm_jtem2_rainbow_wiggle}OH AND PLAY MY MOD AIKOYORI'S SHENANIGANS{}",
						"My favorite umamusume is {C:white,E:1}Kitasan Black{}",
						"{C:inactive}(was told to add one)",
						" ",
						"postmortem i just added like a joker ",
						"and 3 enhancements last minute go figure",
					},
					{
						"A word from our sponsor, {C:attention}my dog:",
						"woof",
						"- my dog",
					},
				},
			},
			PotatoPatchDev_sleepyg11 = {
				name = "SleepyG11",
				text = {
					{
						"As usual, did some coding.",
						"I'm proud of {C:attention}Artificial Solar System{} tho.",
						"Watch out for this rock, it's a bit {C:purple}sus{}",
						" ",
						"Cannot wait for {C:chips}f***ing{} event",
						" ",
						"My favorite umamusume is {C:white,E:1}Oguri Cap{}",
					},
					{
						"You already using or will use {C:chips}Handy{} anyway",
						"{C:inactive}(You have no choice){}",
						"So no advertizing here",
					},
				},
			},
			PotatoPatchDev_haya = {
				name = "Haya",
				text = {
					{
						"hi i am {s:2,C:edition}Paya{} from {s:2,C:dark_edition}Haya{}",
						"{s:0.5,C:inactive}Im suffocating please help{}",
						"{C:worm_jtem2_teamcolor}Jtem{C:worm_jtem2_teamcolor,E:worm_jtem2_exponent}2{} back at it again with the jeans",
						"",
						"I mostly took a backseat from coding",
						"due to time constraints yet I still managed",
						"to make something really {C:edition,s:1.5,E:worm_jtem2_snaking}funny{} haha 67",
						"",
						"My favorite umamusume is {C:white,E:1}Manhattan Cafe{}",
					},
					{
						"{s:2.3}Play {s:2.3,E:worm_jtem2_rainbow_wiggle}juuyon{} pls",
						"{s:0.8,C:inactive}https://github.com/hayaunderscore/juu-yon{}",
						"{s:0.8}I couldn't implement Taiko in Balala in time, sorry",
					},
				},
			},
			PotatoPatchDev_lexi = {
				name = "lexi",
				text = {
					{
						"wannabe music artist, dev for jeans alchemy",
						"{s:0.7}I'd rather be topped by 10 {C:worm_jtem2_lexi,s:0.7,E:1}lesbians{s:0.7} than top 10 {C:worm_jtem2_lexi,s:0.7,E:1}lesbians",
						"{C:worm_jtem2_lexi}triple6lexi.carrd.co{} <- my links and bio",
						"{s:0.8}youtu.be/O8uXhKOB3j8",
					},
					{
						'{s:0.8}"I had tried my hardest to give you what you wanted.',
						'{s:0.8}If you had just been honest, too goddamn cold-hearted."',
						"{s:0.8}charlie! - Cold Hearted",
						"{s:0.65}it's a good song",
					},
				},
			},
			PotatoPatchDev_ari = {
				name = "Ari",
				text = {
					{
						"Haya forced me to join this jam",
						"but I owe a lot of money to some very bad people",
						"so I didn't really do much",
					},
				},
			},
			PotatoPatchDev_missingnumber = {
				name = "missingnumber",
				text = {
					{
						'"Remember to drive responsibly, and definitely',
						"don't drive on the highway at 190 miles per hour!\"",
						"{s:0.8}- Yi Xi totally said this",
						"",
						"artist for {C:red,E:worm_jtem2_shrivel}Finity{} and {C:purple,E:worm_jtem2_snaking}0 ERROR",
						"{}listen to my music pls",
					},
				},
			},
		},
	},
	misc = {
		dictionary = {
			b_worm_jtem_reset = "RESET",

			k_worm_downgrade_ex = "Downgrade!",

			k_worm_mult_ex = "Mult!",
			k_worm_chips_ex = "Chips!",

			k_worm_jtem2_eclipse_solar = "Solar",
			k_worm_jtem2_eclipse_lunar = "Lunar",

			k_worm_jtem2_quantum = "Quantum",
		},
		labels = {
			k_worm_jtem2_quantum = "Quantum",
			worm_jtem2_black_hole_seal = "Black Hole Seal",
			worm_jtem2_supermassive_black_hole_seal = "Supermassive Black Hole Seal",
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
