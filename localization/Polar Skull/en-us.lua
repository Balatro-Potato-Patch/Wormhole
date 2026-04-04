local rocket_text = {
	"All played hands score as",
	"{C:attention}#1#{}, while also",
	"gaining the original hand's",
	"{C:mult}mult{} and {C:chips}chips{} for {C:attention}#2#{} #4#",
	"{B:1,C:white}#3#"
}

return {
	descriptions = {
		Back = {
		},
		Joker = {
			j_worm_polarskull_untitled = {
				name = "???",
				text = {
					"When {C:attention}Boss Blind{} is defeated,",
					"create the {C:polarskull_rocket}Rocket{} Card",
					"for final played {C:attention}poker hand{}",
					"that round",
				}
			}
		},
		polarskull_rocket = {
			c_worm_polarskull_atlasv = {
				name = "Atlas V",
				text = rocket_text
			},
			c_worm_polarskull_vostok1 = {
				name = "Vostok 1",
				text = rocket_text
			},
			c_worm_polarskull_changzheng5 = {
				name = "Changzheng 5",
				text = rocket_text
			},
			c_worm_polarskull_soyuz = {
				name = "Soyuz",
				text = rocket_text
			},
			c_worm_polarskull_titaniv = {
				name = "Titan IV",
				text = rocket_text
			},
			c_worm_polarskull_atlascentaur = {
				name = "Atlas-Centaur",
				text = rocket_text
			},
			c_worm_polarskull_spaceshuttle = {
				name = "Space Shuttle",
				text = rocket_text
			},
			c_worm_polarskull_sls = {
				name = "Space Launch System",
				text = rocket_text
			},
			c_worm_polarskull_titanieee = {
				name = "Titan IEEE",
				text = rocket_text
			},
			c_worm_polarskull_saturnv = {
				name = "Saturn V",
				text = rocket_text
			},
			c_worm_polarskull_deltaii = {
				name = "Delta II",
				text = rocket_text
			},
			c_worm_polarskull_ariane5 = {
				name = "Ariane 5",
				text = rocket_text
			},
			c_worm_polarskull_ssdolphin = {
				name = "SS Dolphin",
				text = {
					"All played hands count as",
					"containing all hands for {C:attention}#2#{} #4#,",
					"all base {C:mult}mult{} and {C:chips}chips{} included",
					"{B:1,C:white}#3#"
				}
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
				name = 'Rocket Pack',
				text = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards to',
					'be used immediately'
				}
			},
			p_worm_rocket_normal_2 = {
				name = 'Rocket Pack',
				text = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards to',
					'be used immediately'
				}
			},
			p_worm_rocket_jumbo = {
				name = 'Jumbo Rocket Pack',
				text = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards to',
					'be used immediately'
				}
			},
			p_worm_rocket_mega = {
				name = 'Mega Rocket Pack',
				text = {
					'Choose {C:attention}#1#{} of up to',
					'{C:attention}#2#{} {C:polarskull_rocket}Rocket{} cards to',
					'be used immediately'
				}
			},
		},

		PotatoPatch = {
			PotatoPatchTeam_polar_skull = {
				name = "Polar Skull"
			},
			PotatoPatchDev_cloudzxiii = {
				name = "cloudzXIII",
				text = {
					"e"
				}
			},
			PotatoPatchDev_mire = {
				name = "Mire",
				text = {
					"e"
				}
			},
			PotatoPatchDev_mariofan = {
				name = "MarioFan597",
				text = {
					"e"
				}
			},
			PotatoPatchDev_rainstar = {
				name = "Rainstar",
				text = {
					"e"
				}
			},
			PotatoPatchDev_comykel = {
				name = "Comykel",
				text = {
					"e"
				}
			},
			PotatoPatchDev_jade = {
				name = "Jade Penguin",
				text = {
					"e"
				}
			}
		}
	},
	misc = {
		dictionary = {
			b_polarskull_rocket_cards = "Rocket Cards",
			k_polarskull_rocket = "Rocket",
			k_polarskull_inactive = "Inactive",
			k_polarskull_round_singular = "Round",
			k_polarskull_round_plural = "Rounds",
			k_polarskull_rocket_pack = "Rocket Pack",
			k_polarskull_plus_rocket = "+1 Rocket"
		},
		v_dictionary = {
			k_polarskull_left = "#1# left"
		}
	}
}
