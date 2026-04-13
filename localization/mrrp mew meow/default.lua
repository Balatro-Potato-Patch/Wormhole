return {
descriptions={
	Joker={
		j_worm_mrrp_alien_cat ={
			name=
				"Alien Cat"
			, text={
				"{C:green}#1# in #2#{} chance for each",
				"played {C:attention}#3#{} to create a",
				"{C:planet}#4#{} card when scored"
			}
		},
		j_worm_mrrp_pallasite ={
			name=
				"Pallasite"
			, text={
				"If played {C:attention}poker hand{}",
				"was upgraded this round,",
				"cards give {C:money}$#1#{} when scored"
			}
		},
		j_worm_mrrp_cookie_cat ={
			name=
				"Cookie Cat"
			, text={
				"{C:planet}#1#{} {C:attention}temporary{} levels to",
				"each played {C:attention}poker hand{}",
				"{C:planet,s:0.8}#2#{s:0.8} level per hand played{}",
			}
		},
		j_worm_mrrp_countdown ={
			name=
				"Countdown to Launch"
			, text={
				"Upgrade level of played",
				"{C:attention}poker hand{} if it contains",
				"a {C:attention}#1#{} and no {C:attention}face{} cards"
			}
		},
		--[[]]
		j_worm_mrrp_felicette ={
			name=
				"Félicette"
			, text={
				"{C:mult}#1#{} Mult for every",
				"upgraded {C:attention}poker hand{}",
				"{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)"
			}
		},
		j_worm_mrrp_go_pisces ={
			name=
				"Go Pisces"
			, text={
				"If poker hand contains a",
				"{C:attention}#1#{}, destroy it",
				"and create a {C:attention}#2#{}",
				"{S:1.1,C:red,E:2}self-destructs{}"
			}
		},
		j_worm_mrrp_goldilocks ={
			name=
				"Goldilocks Zone"
			, text={
				"If played hand is a {C:attention}#1#{},",
				"turn the {C:attention}middlemost{} scoring card",
				"into a {C:attention}#2#{} with a {C:attention}#3# Seal{}"
			}
		},
		j_worm_mrrp_nyasa ={
			name=
				"NYASA Exploration Team"
			, text={
				"When {C:attention}Blind{} is selected,",
				"create a {C:planet}Space{} {C:attention}Joker{}",
				"{C:green}#2# in #3#{} chance that",
				"the Joker is {C:dark_edition}Negative{}",
				"{C:inactive}(Must have room otherwise){}"
			}
		},
		j_worm_mrrp_orrery ={
			name=
				"Orrery"
			, text={
				"When upgrading level of any",
				"{C:attention}poker hand{}, create copies of",
				"up to {C:tarot}#1#{}, {C:tarot}#2#{},",
				"{C:tarot}#3#{}, and/or {C:tarot}#4#{}",
				"{C:inactive}(Must have room){}"
			}
		},
		j_worm_mrrp_capitalism ={
			name={
				"The One Place That",
				"Hasn't Been Corrupted",
				"by Capitalism: {C:edition}SPACE{}!"
			}, text={
				"This Joker gains {C:mult}#1#{} Mult",
				"when ending a {C:attention}shop{} with",
				"no money being spent",
				"{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult){}"
			}
		},
		j_worm_mrrp_out_of_space = {
			name = "Out of Space",
			text = {
				{
					"{C:dark_edition}#1#{} Joker slot",
					"{C:dark_edition}#1#{} consumable slot",
					"{C:dark_edition}#1#{} hand size",
				},
				{
					"{X:blind,C:white}X#2#{} Blind size per",
					"empty {C:attention}Joker{} slot and",
					"empty {C:attention}consumeable{} slot"
				}
			}
		},
		j_worm_mrrp_staging = {
			name = "Staging",
			text = {
				"{X:mult,C:white}X#1#{} Mult per {C:attention}card{}",
				"discarded this round",
				"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})"
			}
		},
		j_worm_mrrp_perseids = {
			name = "Perseids",
			text = {
				"Each {C:attention}card{} in poker hand",
				"retriggers a random",
				"card in poker hand",
			}
		},
		j_worm_mrrp_tanabata = {
			name = "Tanabata",
			text = {
				"If poker hand contains a",
				"{C:attention}#1#{} and a {C:attention}#2#{}, create",
				"a random {C:planet}#3#{} card",
				"{C:inactive}(Must have room)"
			}
		},
		j_worm_mrrp_cats_eye_nebula = {
			name = "Cat's Eye Nebula",
			text = {
				"{C:chips}#1#{} Chips",
				"{C:chips}#2#{} per {C:attention}card{} scored",
				"Upon collapse, upgrade all",
				"{C:attention}poker hand{} levels by {C:attention}#3#{}"
			}
		}
	},
	Stake={
		stake_worm_mrrp_cosmic ={
			name=
				'Cosmic Stake'
			, text={
				"Shop can have {C:attention}Meteoric{} Jokers",
				"{C:inactive,s:0.8}(Halve all poker hand levels when bought){}",
				"{s:0.8}Applies {C:money,s:0.8}Gold Stake{}"
			}
		}
	},
	Back={
		b_worm_mrrp_doppler = {
			name = 'Doppler Deck',
			text = {
				"{C:planet}Planet{} cards give",
				"{C:blue}#1#{} additional level,",
				"but {C:red}#2#{} level to your",
				"{C:attention}most played{} poker hand",
			}
		}
	},
	Other={
		worm_mrrp_meteoric ={
			name=
				"Meteoric"
			, text={
				"Halve all {C:attention}poker hand{}",
				"levels when bought"
			}
		},
		worm_mrrp_cookie_cat_song ={
			name=
				"Cookie Cat"
			, text={
				"{C:dark_edition,E:1}Oohhhhh!{}",
				"{E:1}He's a frozen treat with an all new taste!",
				"{E:1}'Cause he came to this planet from outer space!",
				"{E:1}A refugee of an interstellar war!",
				"{E:1}But now he's at your local grocery store!",
				"{C:dark_edition,E:1}Cookie Cat!{}",
				"{E:1}He's a pet for your tummy!",
				"{C:dark_edition,E:1}Cookie Cat!{}",
				"{E:1}He's super duper yummy!",
				"{C:dark_edition,E:1}Cookie Cat!{}",
				"{E:1}He left his family behind!",
				"{C:dark_edition,E:1}Cookie Caaaaat!{}",
				"{C:inactive,s:0.8}Now available at Gurgens off Route 109{}"
			}
		},
	},
	PotatoPatch = {
		['PotatoPatchTeam_Mrrp Mew Meow :3'] = {
			name = 'Mrrp Mew Meow :3',
		},
		PotatoPatchDev_SarcPot = {
			name = 'SarcPot',
			text = {
				{'test'},
			},
		},
		PotatoPatchDev_Shinku = {
			name = 'Shinku',
			text = {
				{'test'},
			},
		},
		PotatoPatchDev_MP = {
			name = 'MP',
			text = {
				{'test'},
			},
		},
		PotatoPatchDev_Aure = {
			name = 'Aure',
			text = {
				{
					"Hi, I'm {E:2,C:mrrp_green}Aure{} aka {E:2,C:mrrp_green}Mr. SMODS."
				},
				{
					"I had {E:2,C:mrrp_blue}some{} of the ideas",
					"and did {E:2,C:mrrp_blue}some{} of the code",
					"for this team.",
				},
				{
					"{s:0.8,C:mrrp_blue}fishing jame when{}"
				}
			},
		},
		PotatoPatchDev_Minty = {
			name = 'mys. minty',
			text = {
				{"hey there everynyan my name's Minty :3"},
				{"i like to nya"},
				{"nyaaaaaa~ :3 :3 :3"},
			},
		},
		PotatoPatchDev_Cyan = {
			name = 'Cyan',
			text = {
				{'test'},
			},
		}
	}
},
misc={
	v_dictionary={
		a_level_minus = "-#1# Level",
		a_plus_tarot = "+#1# Tarot",
	},
	labels={
		worm_mrrp_meteoric = "Meteoric",
	},
	dictionary={
	--	k_downgrade_ex = "Downgrade!",
		k_make_a_wish_ex = "Make a wish!",
		k_flaring = "Flaring..."
	},
	quips = {
		worm_mrrp_no_menthol_win = {
			"Have you tried this",
			"silly little mod",
			"called Menthol?"
		},
		worm_mrrp_no_menthol_loss = {
			"I know what your",
			"build is missing -",
			"more cats!"
		},
		worm_mrrp_menthol_win = {
			"What a refreshing",
			"minty taste!"
		},
		worm_mrrp_menthol_loss = {
			"Maybe a bit",
			"TOO much mint?"
		},
		worm_mrrp_sarcpot = {
			"Playing SarcPot, huh?",
			"I know what",
			"you are... >:3"
		},
		worm_mrrp_no_sarcpot = {
			"Are you a girl,",
			"gay, or indie game",
			"fan? Play SarcPot!"
		},
	}
},
}
