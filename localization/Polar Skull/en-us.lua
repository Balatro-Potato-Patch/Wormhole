local rocket_text = {
	"All played hands score as",
	"{C:attention}#1#{}, while also",
	"gaining the original hand's",
	"{C:mult}Mult{} and {C:chips}Chips{} for {C:attention}#2#{} #4#",
	"{B:1,C:white}#3#",
}

return {
	descriptions = {
		Back = {},
		Joker = {
			j_worm_polarskull_launchpad = {
				name = "Launch Pad",
				text = {
					"When {C:attention}Boss Blind{} is defeated,",
					"create the {C:polarskull_rocket}Rocket{} Card",
					"for final played {C:attention}poker hand{}",
					"that round",
				},
			},
			j_worm_polarskull_rocket_science = {
				name = "Rocket Science",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"each time you play a {C:polarskull_rocket}Rocket{} card",
					"for a different hand than the",
					"currently {C:attention}active{} {C:polarskull_rocket}Rocket{}",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				}
			},
			j_worm_polarskull_olimar = {
				name = "Olimar",
				text = {
					{
						"{C:polarskull_rocket}Rocket{} cards become {C:dark_edition}#1#{} when used",
						"Multiple {C:polarskull_rocket}Rocket{} cards can be {C:attention}active{} at once and",
						"once, and may appear multiple times",
						"{C:inactive}(Rightmost {C:polarskull_rocket}Rocket{} {C:inactive}card determines hand name)"
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
			c_worm_polarskull_changzheng5 = {
				name = "Changzheng 5",
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
				name = "Titan IEEE",
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
				name = "Rocket Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
			p_worm_rocket_normal_2 = {
				name = "Rocket Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
			p_worm_rocket_jumbo = {
				name = "Jumbo Rocket Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
				},
			},
			p_worm_rocket_mega = {
				name = "Mega Rocket Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards",
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
					"e",
				},
			},
			PotatoPatchDev_noodlemire = {
				name = "Noodlemire",
				text = {
					"Bowl of Noodles",
					"Kickstarted the idea of the {C:dark_edition}Rocket{} consumables!",
					"Also made some art."
				},
			},
			PotatoPatchDev_mariofan = {
				name = "MarioFan597",
				text = {
					"e",
				},
			},
			PotatoPatchDev_rainstar = {
				name = "Rainstar",
				text = {
					"e",
				},
			},
			PotatoPatchDev_comykel = {
				name = "Comykel",
				text = {
					"{C:attention}Sick pixel artist!{}",
					"The one who did almost all of the {C:dark_edition}Rockets'{} art!",

				},
			},
			PotatoPatchDev_jade = {
				name = "Jade Penguin",
				text = {
					"Pupil of Chartreuse Chamber",
					"Made the art of Friendly Neighborhood Martian,",
					"and helped made the ideas of some of the stuff you see here from our team!",
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
		},
		v_dictionary = {
			k_polarskull_left = "#1# left",
		},
	},
}
