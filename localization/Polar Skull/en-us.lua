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
				name="Not Discovered",
				text={
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
		}
	},
	misc = {
		dictionary = {
			b_polarskull_rocket_cards = "Rocket Cards",
			k_polarskull_rocket = "Rocket",
			k_polarskull_inactive = "Inactive",
			k_polarskull_round_singular = "Round",
			k_polarskull_round_plural = "Rounds",
		},		
		v_dictionary = {
			k_polarskull_left = "#1# left"
		}
	}
}
