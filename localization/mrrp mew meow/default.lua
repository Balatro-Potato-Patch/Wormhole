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
				"Upgrade level of first played",
				"{C:attention}poker hand{} of round",
				"if it contains a {C:attention}#1#{}",
				"and no scoring {C:attention}face{} cards",
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
	Tarot = {
		c_worm_mrrp_reentry = {
			name = "Reentry",
			text = {
				"Remove enhancements,",
				"seals, and editions from",
				"selected playing cards,",
				"then gain {C:money}#1#{} per",
				"modification removed"
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
		worm_mrrp_cosmic_sticker ={
			name=
				"Cosmic Sticker"
			, text={
				"Used this Joker",
				"to win on {C:attention}Cosmic{}",
				"{C:attention}Stake{} difficulty"
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
				{
					"Hey, i'm {C:attention}SarcasticPotato{} (aka. {C:attention}Sarc{})",
					"{C:mrrp_orange2,s:0.9}Like. you know. from the mod. {C:attention,s:0.9}SarcPot{}"
				},
				{
					"I did most of the {C:attention}art{} for our portion",
					"of the mod and helped {C:attention}design{} and",
					"{C:attention}concept{} a lot of the Jokers as well."
				},
				{
					"Maybe not the best idea to have",
					"the slowest dev (and artist)",
					"participate in a modjam but {C:attention}hey{}."
				},
			},
		},
		PotatoPatchDev_Shinku = {
			name = 'Shinku',
			text = {
				{
					"Hi. I'm {C:mrrp_pink}Shinku{}."
				},
				{
					"I worked on/created",
					"mods like {C:hearts}Ortalab{}",
					"and {C:mrrp_pink}Parallel Update{}."
				}
			},
		},
		PotatoPatchDev_MP = {
			name = 'MP',
			text = {
				{
					"Hey-hey. {C:mrrp_blue}MP{} here."
				},
				{
					"This was my first jam, and I had",
					"a LOT of Joker concepts for this.",
					"Oh, and I made some code too!"
				},
				{
					"{C:mrrp_blue}Buru-nyuu~{}"
				},
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
				{
					"hey there everynyan my name's {C:mrrp_green,E:1}Minty{} :3",
					"you may know me from silly little mods",
					"like {C:mrrp_pink,E:2}Menthol{} or {C:mrrp_pink,E:2}Bibliography{}"
				},
				{
					"i did some {C:mrrp_blue}code{} because it's fun",
					"and I'm good at it :3c",
				},
				{
					"and i like to nya",
					"{C:mrrp_pink}nyaaaaaa~ {C:mrrp_cyan}:3 {C:mrrp_green}:3 {C:mrrp_orange}:3"
				},
			},
		},
		PotatoPatchDev_Cyan = {
			name = 'Cyan',
			text = {
				{
					"{C:mrrp_cyan,E:2}CyanSoCalico{}, neurotic catboy! :3",
				},
				{
					"I was recruited as an {C:mrrp_cyan}artist{} but",
					"also ended up doing a lot of the",
					"code, concepts, and coordination!",
				},
				{
					"I'm so honored that I was given",
					"a chance as the new kit in town",
					"by all of the people I admire ;w;",
					"{C:mrrp_pink,E:1}Best first anything-jam ever <3{}"
				},
				{
					"Look out for {C:mrrp_cyan,E:1}Steady Hand{}!"
				}
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

	--	MINTY
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
		worm_mrrp_biblio_win = {
			"Catch those clowns!"
		},
		worm_mrrp_biblio_loss = {
			"Well, next",
			"time try catching",
			"MORE clowns."
		},
		worm_mrrp_no_biblio_win = {
			"I've got a whole",
			"Bibliography of",
			"cool jokers like this!"
		},
		worm_mrrp_no_biblio_loss = {
			"Dang, maybe those",
			"cards should be",
			"put through some",
			"kind of crucible..."
		},

	--	SARC
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

	--	MP
		worm_mrrp_no_wtmjq = {
			"If you like these",
			"lines there's more",
			"where that came from!"
		},
		worm_mrrp_no_index = {
			"The Will of the City",
			"calls you to",
			"The Index."
		},
		worm_mrrp_index = {
			"How 'bout I throw in",
			"another Prescript to",
			"play another round",
			"for you!"
		},

	--	CYAN
		worm_mrrp_mmm_win = {
			"Hey! One of",
			"those Jokers",
			"is {C:mrrp_pink}ours{}!! :D"
		},
		worm_mrrp_mmm_loss = {
			"It wasn't {C:mrrp_pink}our{}",
			"Joker's fault,",
			"was it? :<",
		},
		worm_mrrp_no_steady_loss = {
			"Augh! If only you",
			"were able to hold",
			"a {C:mrrp_cyan,E:2}Steady Hand{}...",
		},
		worm_mrrp_no_steady_win = {
			"Awesome job",
			"holding a",
			"{C:mrrp_cyan,E:2}Steady Hand{}!",
		},

	}
},
}
