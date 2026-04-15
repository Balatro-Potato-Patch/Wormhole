local rocket_text = {
	"All played hands score as",
	"{C:attention}#1#{}, while also",
	"gaining the original hand's",
	"{C:mult}Mult{} and {C:chips}Chips{} for {C:attention}#2#{} #4#",
	"{B:1,C:white}#3#",
}

return {
	descriptions = {
		Back = {
			b_worm_polarskull_space_station = {
				name = "Space Station Deck",
				text = {
					"Start with {C:attention,T:v_worm_polarskull_gravitational_slingshot}Gravitational Slingshot{}",
					"and {C:polarskull_rocket,T:c_worm_polarskull_atlascentaur}Atlas-Centaur{}",
				},
			},
		},
		Joker = {
			j_worm_polarskull_martian = {
				name = {
					"F.N.M.",
					"{s:0.8}Friendly Neighborhood Martian"
				},
				text = {
					"If current {C:attention}Ante{} is beaten by",
					"only playing a {C:attention}#1#{},",
					"create {C:attention}#2#{} {C:spectral}Spectral{} cards,",
					"poker hand changes each {C:attention}Ante{}",
					"{C:inactive}(Must have room)",
					"{C:inactive}(Currently: {B:1,C:white}#3#{C:inactive})",
				},
			},
			j_worm_polarskull_launchpad = {
				name = "Launch Pad",
				text = {
					"When {C:attention}Boss Blind{} is defeated,",
					"create the {C:polarskull_rocket}Rocket{} Card for",
					"final played {C:attention}poker hand{} that round",
					"{C:inactive}(Must have room)"
				},
			},
			j_worm_polarskull_rocket_science = {
				name = "Rocket Science",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult each",
					"time you play a {C:polarskull_rocket}Rocket{} card",
					"for a different hand than",
					"the currently {C:attention}active{} {C:polarskull_rocket}Rocket{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				}
			},
			j_worm_polarskull_olimar = {
				name = "Olimar",
				text = {
					{
						"{C:polarskull_rocket}Rocket{} cards become",
						"{C:dark_edition}#1#{} when used",
					},
					{
						"Multiple {C:polarskull_rocket}Rocket{} cards",
						"can be {C:attention}active{} at once and",
						"may appear multiple times",
						"{C:inactive}(Rightmost {C:polarskull_rocket}Rocket{} {C:inactive}card",
						"{C:inactive}determines hand name)"
					},
				}
			}
		},
		polarskull_rocket = {
			c_worm_polarskull_atlasv = {
				name = "Atlas V",
				text = rocket_text,
			},
			c_worm_polarskull_vostok1 = {
				name = "Vostok 1",
				text = rocket_text,
			},
			c_worm_polarskull_longmarch5 = {
				name = "Long March 5",
				text = rocket_text,
			},
			c_worm_polarskull_soyuz1 = {
				name = "Soyuz 1",
				text = rocket_text,
			},
			c_worm_polarskull_titaniv = {
				name = "Titan IV",
				text = rocket_text,
			},
			c_worm_polarskull_atlascentaur = {
				name = "Atlas-Centaur",
				text = rocket_text,
			},
			c_worm_polarskull_spaceshuttle = {
				name = "Space Shuttle",
				text = rocket_text,
			},
			c_worm_polarskull_sls = {
				name = "Space Launch System",
				text = rocket_text,
			},
			c_worm_polarskull_titanieee = {
				name = "Titan IIIE",
				text = rocket_text,
			},
			c_worm_polarskull_saturnv = {
				name = "Saturn V",
				text = rocket_text,
			},
			c_worm_polarskull_deltaii = {
				name = "Delta II",
				text = rocket_text,
			},
			c_worm_polarskull_ariane5 = {
				name = "Ariane 5",
				text = rocket_text,
			},
		},
		Spectral = {
			c_worm_polarskull_ssdolphin = {
				name = "SS Dolphin",
				text = {
					"All played hands contain every",
					"{C:legendary,E:1}Poker Hand{} for {C:attention}#2#{} #4#,",
					"combining all base {C:mult}Mult{} and {C:chips}Chips{} values",
					"{B:1,C:white}#3#",
				},
			},
			c_worm_polarskull_ssdolphin_ppm = {
				name = "SS Dolphin",
				text = {
					"All played hands contain every",
					"{C:legendary,E:1}Poker Hand{} for {C:attention}#2#{} #4#,",
					"combining all base {C:mult}Mult{} and {C:chips}Chips{} values",
					"{C:inactive}(Not affected by {C:attention}Perpetual Motion Machine{C:inactive})",
					"{B:1,C:white}#3#",
				},
			},
		},
		Other = {
			undiscovered_polarskull_rocket = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},

			p_worm_rocket_normal_1 = {
				name = "Basic Booster Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
			p_worm_rocket_normal_2 = {
				name = "Basic Booster Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
			p_worm_rocket_jumbo = {
				name = "Jumbo Booster Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
			p_worm_rocket_mega = {
				name = "Mega Booster Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
		},
		Voucher = {
			v_worm_polarskull_gravitational_slingshot = {
				name = "Gravitational Slingshot",
				text = {
					"The current {C:attention}active {C:polarskull_rocket}Rocket{} card",
					"lasts for {C:attention}+1{} extra round",
					"each time you play the",
					"{C:planet}Planet Card{} for the same hand",
				},
			},
			v_worm_polarskull_prepetual_motion_machine = {
				name = "Prepetual Motion Machine",
				text = {
					"{C:attention}Active {C:polarskull_rocket}Rockets{} last {C:attention}indefinitely{}",
					"until another {C:polarskull_rocket}Rocket{} is used",
				},
			},
		},

		PotatoPatch = {
			PotatoPatchTeam_polar_skull = {
				name = "Polar Skull",
			},
			PotatoPatchDev_cloudzxiii = {
				name = "cloudzXIII",
				text = {
					"{C:gold,E:1}May your heart be your guiding key",
					"Helped with brainstorming and",
					"coding the Jokers for our team!",
				},
			},
			PotatoPatchDev_noodlemire = {
				name = "Noodlemire",
				text = {
					"{C:money}Bowl of Noodles",
					"Lead programmer and idea producer",
					"behind the {C:polarskull_rocket}Rocket{} Cards!",
					"Also made some art and bugfixes."
				},
			},
			PotatoPatchDev_mariofan = {
				name = "MarioFan597",
				text = {
					"{C:red,s:1.5,E:1}Letsa go!",
					"Helped with various things like",
					"text formating, brainstorming,",
					"coding, and art"
				},
			},
			PotatoPatchDev_rainstar = {
				name = "Rainstar",
				text = {
					"{C:money}The sun.",
					"Formulated the team.",
					"Coded 2 vouchers and a deck."
				},
			},
			PotatoPatchDev_comykel = {
				name = "Comykel",
				text = {
					"{C:attention,s:0.9,E:1}Throughout Heaven and Earth, I alone am the jobless one.{}",
					"The one who did almost all of the art!",
					"if you're interested in his works, see CMYKL (the mod!)",
				},
			},
			PotatoPatchDev_jade = {
				name = "Jade Penguin",
				text = {
					"{C:green}Pupil of Chartreuse Chamber{}",
					"Made some of the art, and helped made the ideas of",
					"some of the stuff you see here from our team!",
					"{C:dark_edition}+1{} Joker Slot :)",
				},
			},
		},
	},
	misc = {
		dictionary = {
			b_polarskull_rocket_cards = "Rocket Cards",
			k_polarskull_rocket = "Rocket",
			k_polarskull_inactive = "Inactive",
			k_polarskull_round_singular = "Round",
			k_polarskull_round_plural = "Rounds",
			k_polarskull_rocket_pack = "Rocket Pack",
			k_polarskull_plus_rocket = "+1 Rocket",
			k_polarskull_plus_round = "+1 Round!",
			k_polarskull_unlimited = "unlimited",
		},
		v_dictionary = {
			k_polarskull_left = "#1# left",
			k_polarskull_martian_inactive = "Inactive",
			k_polarskull_martian_active = "Active",
		},
		v_text = {
			ch_c_rocket_paper_scissors = { "All {C:attention}Boss Blinds{} are {C:attention,T:bl_mouth}The Mouth{} or {C:attention,T:bl_eye}The Eye{}" },
			ch_c_polarskull_credits_1 = {"          {C:inactive,s:0.9}Made by Team {C:polarskull_rocket,s:0.9}Polar Skull{}"},
			ch_c_polarskull_credits_2 = {"           {C:inactive,s:0.9}Idea by {C:red,s:0.9}MarioFan597{}"},
			ch_c_polarskull_credits_3 = {"           {C:inactive,s:0.9}Coded by {C:gold,s:0.9}cloudzXIII{}"}
		},
		challenge_names = {
			c_worm_rocket_paper_scissors = "Rocket Paper Scissors",
		},
		quips = {
			worm_polarskull_martian_party = {"{f:worm_polarskull_noto}🥳🎉🎊"},
			worm_polarskull_martian_music = {"{f:worm_polarskull_noto}🤙👽🎸🎶"},
			worm_polarskull_martian_world = {"{f:worm_polarskull_noto}🧑🌍👍👏"},
			worm_polarskull_martian_workout = {"{f:worm_polarskull_noto}💪🃏🏋️🏙️"},
			worm_polarskull_martian_plsrocket = {"{f:worm_polarskull_noto}👎👉🚀🙏"},
			worm_polarskull_martian_dumbass = {"{f:worm_polarskull_noto}🤦🤷"},
			worm_polarskull_martian_broke = {"{f:worm_polarskull_noto}💀🪦💔😢"},
			worm_polarskull_martian_retry = {"{f:worm_polarskull_noto}🚮🔁🚶"},
		},
		achievement_names = {
			ach_worm_polarskull_dandori = "Dandori",
			ach_worm_polarskull_sschamp = "Space Station Champ",
			ach_worm_polarskull_completion = "Polar Skull Completionist",
		},
		achievement_descriptions = {
			ach_worm_polarskull_dandori = "Discover Olimar in a run.",
			ach_worm_polarskull_sschamp = {
				"Win a run using the Space Station",
				"Deck on Gold Stake or higher."
			},
			ach_worm_polarskull_completion = {
				"Discover 100% of Team",
				"Polar Skull's content."
			},
		},
	},
}
