local constellation_text = {t1 = "Faint", t2 = "Noticable", t3 = "Bright", t4 = "Shining"}
local CONSTELLATIONS = {
	c_worm_tlr_const_orion_t1 = {
		name = "Orion",
		text = {
			"Reroll the Boss Blind"
		}
	},
	c_worm_tlr_const_orion_t2 = {
		name = "Orion",
		text = {
			"Set Boss Blind to",
			"{C:attention}1{} of {C:attention}2{} choices"
		}
	},
	c_worm_tlr_const_orion_t3 = {
		name = "Orion",
		text = {
			"Set Boss Blind to",
			"{C:attention}1{} of {C:attention}2{} choices",
			"Reroll choices up to {C:attention}#1#{} time"
		}
	},
	c_worm_tlr_const_orion_t4 = {
		name = "Orion",
		text = {
			"Set Boss Blind to",
			"{C:attention}1{} of {C:attention}2{} choices",
			"Reroll choices up to {C:attention}#1#{} times",
			"{C:inactive}Choices may include blinds{}",
			"{C:inactive}that cannot usually appear{}",
		}
	},
	c_worm_tlr_const_canis_major_t1 = {
		name = "Canis Major",
		text = {
			"Create up to {C:attention}#1#{} random",
			"{V:1}Constellation{} cards",
			"{C:inactive}(Must have room){}"
		},
	},
	c_worm_tlr_const_canis_major_t2 = {
		name = "Canis Major",
		text = {
			"Create up to {C:attention}#1#{} out of {C:attention}#2#{}",
			"selected {V:1}Constellation{} cards",
		},
	},
	c_worm_tlr_const_canis_major_t3 = {
		name = "Canis Major",
		text = {
			"Create up to {C:attention}#1#{} out of {C:attention}#2#{}",
			"selected {V:1}Constellation{} cards",
		},
	},
	c_worm_tlr_const_canis_major_t4 = {
		name = "Canis Major",
		text = {
			"Create up to {C:attention}#1#{} out of {C:attention}#2#{}",
			"{C:dark_edition}negative {V:1}Constellation{} cards",
		},
	},
	c_worm_tlr_const_perseus_t1 = {
		name = "Perseus",
		text = {
			"{C:green}#1# in #2#{} chance to",
			"disable current boss blind"
		}
	},
	c_worm_tlr_const_perseus_t2 = {
		name = "Perseus",
		text = {
			"{C:green}#1# in #2#{} chance to",
			"disable current boss blind"
		}
	},
	c_worm_tlr_const_perseus_t3 = {
		name = "Perseus",
		text = {
			"{C:green}#1# in #2#{} chance to",
			"disable current boss blind"
		}
	},
	c_worm_tlr_const_perseus_t4 = {
		name = "Perseus",
		text = {
			"Disable current boss blind",
		}
	},
	c_worm_tlr_const_serpens_t1 = {
		name = "Serpens",
		text = {
			"{C:blue}+1{} Hands and {C:red}+1{} Discards",
			"for the next {C:attention}Blind"
		}
	},
	c_worm_tlr_const_serpens_t2 = {
		name = "Serpens",
		text = {
			"{C:blue}+1{} Hands and {C:red}+2{} Discards",
			"for the next {C:attention}Blind"
		}
	},
	c_worm_tlr_const_serpens_t3 = {
		name = "Serpens",
		text = {
			"{C:blue}+2{} Hands and {C:red}+2{} Discards",
			"for the next {C:attention}Blind"
		}
	},
	c_worm_tlr_const_serpens_t4 = {
		name = "Serpens",
		text = {
			"{C:blue}+3{} Hands and {C:red}+3{} Discards",
			"for the next {C:attention}Blind"
		}
	},

	c_worm_tlr_const_ursa_minor_t1 = {
		name = "Ursa Minor",
		text = {
			"Reduce current {C:attention}Blind", 
			"size by {C:attention}10%"
		}
	},
	c_worm_tlr_const_ursa_minor_t2 = {
		name = "Ursa Minor",
		text = {
			"Reduce current {C:attention}Blind", 
			"size by {C:attention}15%"
		}
	},
	c_worm_tlr_const_ursa_minor_t3 = {
		name = "Ursa Minor",
		text = {
			"Reduce current {C:attention}Blind", 
			"size by {C:attention}25%"
		}
	},
	c_worm_tlr_const_ursa_minor_t4 = {
	name = "Ursa Minor",
		text = {
			"Reduce current {C:attention}Blind", 
			"size by {C:attention}50%"
		}
	},

	c_worm_tlr_const_ursa_major_t1 = {
		name = "Ursa Major",
		text = {
			"Increase current {C:attention}Blind's",
			"reward by {C:money}$3"
		}
	},
	c_worm_tlr_const_ursa_major_t2 = {
		name = "Ursa Major",
		text = {
			"Increase current {C:attention}Blind's",
			"reward by {C:money}$6"
		}
	},
	c_worm_tlr_const_ursa_major_t3 = {
		name = "Ursa Major",
		text = {
			"Increase current {C:attention}Blind's",
			"reward by {C:money}$10"
		}
	},
	c_worm_tlr_const_ursa_major_t4 = {
	name = "Ursa Major",
		text = {
			"Increase current {C:attention}Blind's",
			"reward by {C:money}$25"
		}
	},

	c_worm_tlr_const_pictor_t1 = {
		name = "Pictor",
		text = {
			"{C:attention}+1{} Hand size for",
			"the next {C:attention}Blind"
		}
	},
	c_worm_tlr_const_pictor_t2 = {
		name = "Pictor",
		text = {
			"{C:attention}+2{} Hand size for",
			"the next {C:attention}Blind"
		}
	},
	c_worm_tlr_const_pictor_t3 = {
		name = "Pictor",
		text = {
			"{C:attention}+3{} Hand size for",
			"the next {C:attention}Blind"
		}
	},
	c_worm_tlr_const_pictor_t4 = {
	name = "Pictor",
		text = {
			"{C:attention}+4{} Hand size for",
			"the next {C:attention}Blind"
		}
	},

	c_worm_tlr_const_canis_minor_t1 = {
		name = "Canis Minor",
		text = {
			"Creates the last",
			"{V:1}Constellation{} card",
			"used during this run",
			"as a Noticeable",
			"{V:1, s:0.8}Canis Minor{s:0.8} excluded"
		}
	},
	c_worm_tlr_const_canis_minor_t2 = {
		name = "Canis Minor",
		text = {
			"Creates the last",
			"{V:1}Constellation{} card",
			"used during this run",
			"as a Bright",
			"{V:1, s:0.8}Canis Minor{s:0.8} excluded"
		}
	},
	c_worm_tlr_const_canis_minor_t3 = {
		name = "Canis Minor",
		text = {
			"Creates the last",
			"{V:1}Constellation{} card",
			"used during this run",
			"as a {C:dark_edition}Negative{} Bright",
			"{s:0.8,V:1}Canis Minor{s:0.8} excluded"
		}
	},
	c_worm_tlr_const_canis_minor_t4 = {
		name = "Canis Minor",
		text = {
			"Creates the last",
			"{V:1}Constellation{} card",
			"used during this run",
			"as 2 {C:dark_edition}Negative{} Shining",
			"{V:1, s:0.8}Canis Minor{s:0.8} excluded"
		}
	},
	c_worm_tlr_const_draco_t1 = {
		name = "Draco",
		text = {
			"Create current",
			"blind's {C:attention}Tag{}"
		}
	},
	c_worm_tlr_const_draco_t2 = {
		name = "Draco",
		text = {
			"Create this ante's",
			"blind's {C:attention}Tags{}"
		}
	},
	c_worm_tlr_const_draco_t3 = {
		name = "Draco",
		text = {
			"Create this ante's",
			"blind's {C:attention}Tags{} and",
			"select up to {C:attention}#1#{}",
			"out of {C:attention}#2#{} additional {C:attention}Tag{}"
		}
	},
	c_worm_tlr_const_draco_t4 = {
		name = "Draco",
		text = {
			"Create up to {C:attention}#1#{}",
			"out of {C:attention}#2#{} selected {C:attention}Tags{}"
		}
	},
	c_worm_tlr_const_hercules_t1 = {
		name = "Hercules",
		text = {
			"Fight an extra",
			"{C:attention}Small Blind",
			"{C:inactive}No reward",
			"{C:inactive}Must be used while in shop"
		}
	},
	c_worm_tlr_const_hercules_t2 = {
		name = "Hercules",
		text = {
			"Fight an extra",
			"{C:attention}Big Blind",
			"{C:inactive}No reward",
			"{C:inactive}Must be used while in shop"
		}
	},
	c_worm_tlr_const_hercules_t3 = {
		name = "Hercules",
		text = {
			"Fight an extra",
			"{C:attention}Big Blind",
			"{C:inactive}Must be used while in shop"
		}
	},
	c_worm_tlr_const_hercules_t4 = {
		name = "Hercules",
		text = {
			"Fight an extra",
			"{C:attention}Boss Blind",
			"{C:inactive}[Will fight {C:attention}#1#{C:inactive}]",
			"{C:inactive}Changes at end of round",
			"{C:inactive}Must be used while in shop"
		}
	}
}
local ORIGINAL_CONSTELLATIONS = copy_table(CONSTELLATIONS)


for key, obj in pairs(CONSTELLATIONS) do
	local add = "{s:0.7,E:2}" .. constellation_text[string.sub(key, -2)]
	obj.name = {obj.name, add}
end

local Other = {
	worm_tlr_star_seal = {
		name = 'Star Seal',
		text = {
			'Create a tier {C:attention}2{}',
			'{C:worm_tlr_constellation}Constellation{} when scored',
			'if chips scored exceeds',
			'{C:attention}#1#%{} of required chips',
			'{C:inactive}(Must have room)'
		}
	},
	worm_tlr_const_info = {
		name = "Constellation Info",
		text = {
			"This card will",
			"be upgraded when",
			"defeating boss blind"
		}
	},
	worm_tlr_const_info_mask = {
		name = "Constellation Info",
		text = {
			"This card will",
			"be upgraded twice when",
			"defeating boss blind"
		}
	},
	worm_tlr_const_max_level = {
		name = "Maxed out",
		text = {
			"The card cannot",
			"be upgraded any further",
			"{C:inactive,s:0.8}(At least by normal means)"
		}
	},
	worm_tlr_const_max_real = {
		name = "Beyond",
		text = {
			"The card cannot",
			"be upgraded any further"
		}
	},
	undiscovered_worm_tlr_constellation = {
		name = "Not Discovered",
		text={
			"Purchase or use",
			"this card in an",
			"unseeded run to",
			"learn what it does"
		},
	},
	p_worm_tlr_const_normal = {
		name = "Constellation Pack",
		text = {
			"Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{V:1} Constellation{} cards to take",
		}
	},
	p_worm_tlr_const_jumbo = {
		name = "Jumbo Constellation Pack",
		text = {
			"Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{V:1} Constellation{} cards to take",
		}
	},
	p_worm_tlr_const_mega = {
		name = "Mega Constellation Pack",
		text = {
			"Choose {C:attention}#1#{} of up to",
			"{C:attention}#2#{V:1} Constellation{} cards to take",
		}
	},
}

return {
	descriptions = {
		Tarot = {
			c_worm_tlr_observation = {
				name = "The Observer",
				text = {
					"Upgrades leftmost",
					"{V:1}Constellation{} card",
					"{C:inactive,s:0.7}Faint -> Noticable -> Bright -> ???"
				}
			}
		},
		Spectral = {
			c_worm_tlr_starmap = {
				name = "Star Map",
				text = {
					"Upgrade all {V:1}Constellation{} cards",
					"held to {C:edition}???"
				}
			},
			c_worm_tlr_formation = {
				name = "Formation",
				text = {
					"Add a {V:1}Star Seal{} to",
					"{C:attention}#1#{} Selected",
					"card in your hand"
				}
			},
		},
		Back = {
			b_worm_tlr_astrologist = {
				name = "Astrologist's Deck",
				text = {
					'Start run with',
                    '{C:worm_tlr_constellation,T:v_worm_tlr_skywatching}#1#{}',
                    'and {C:worm_tlr_constellation,T:v_worm_tlr_stargazing}#2#{}',
				}
			}
		},
		Joker = {
			j_worm_tlr_chert = {
				name = 'Chert',
				text = {
					'Create a tier {C:attention}1{}',
					'or {C:attention}2{C:worm_tlr_constellation} Constellation{}',
					'when {C:attention}Blind{} is selected',
					'{C:inactive}(Must have room){}',
				}
			},
			j_worm_tlr_nomaimask = {
				name = "Nomai Mask",
				text = {
					"{V:1}Constellation{} cards are upgraded",
					"twice when {C:attention}boss blind",
					"is defeated",
					"{C:inactive}And may reach {C:edition}???"
				}
			}
		},
		Voucher = {
			v_worm_tlr_skywatching = {
				name = 'Skywatching',
				text = {
					'Tier {C:attention}1{C:worm_tlr_constellation} Constellations{}',
            		'may appear in the shop'
				}
			},
			v_worm_tlr_stargazing = {
				name = 'Stargazing',
				text = {
					'Tier {C:attention}2 {C:worm_tlr_constellation}Constellations{}',
            		'may appear in the shop'
				}
			}
		},
		worm_tlr_constellation = CONSTELLATIONS,
		PotatoPatch = {
			PotatoPatchTeam_TLR = {name = "The Last Resort"},
			PotatoPatchDev_Foo54 = {
				name = "Foo54",
				text = {
					{
						"This is the first event",
						"I've participiated in!"
					},
					{
						"I named most of these cards",
						"and did a lot of the initial setup,",
						"utility functions, and a little bit of artwork.",
						"I also composed our booster pack music:",
						"{C:red,E:1}Distant Stars (ft. Kasane Teto & Adachi Rei)"
					},
					{
						"Shoutout to our artists they are cooking"
					}
				}
			},
			PotatoPatchDev_Jogla = {
				name = "Jogla",
				text = {
					{
						"UI coding hell",
						"{C:red}Not{} a wizard",
						"{C:inactive,s:0.7}...Though I do UI wizardy"
					},
					{
						"{C:tarot}Nomai.{}"
					},
				}
			},
			PotatoPatchDev_Breuhh = {
				name = "Breuh",
				text = {
					"Play my hit",
					"mod {E:1,C:common}Oscillate"
				}
			},
			PotatoPatchDev_Amphiapple = {
				name = "Amphiapple",
				text = {
					{
						"im not going to add to the mountain of lies anymore.",
						"most things you know about me are fake.",
						"ive faked most of my runs from both this and other acc",
						"(both nk map runs and maplist runs).",
						"i usually spend an hour-2 hours (and lie about the times it take me)",
						"on these runs by setting tower speed at 1.1x",
						"(rate changer mod)(some runs being more and some runs less)",
						"which makes it virtually indistinguishable for the human eye but noticeable when replayed.",
						'I did it to be able to just do multiple "hard" runs per week',
						"so people would realize im one of the best.",
						"my hardest legit run is axis of wizards on quad which",
						"took me about 7 hours over the course of 2 days back in v34 where",
						"mod helper didnt update for an entire month and i had to do something.",
						"i dont really find the game fun and have a life and strict parents to deal with",
						"(i know its not a good excuse to cheat).",
						"I already had plans to quit the game after v44 cause i already had lost interest.",
						"sorry to all the people whom ive disappointed.",
						"im leaving all bloons related servers and dont dm me i wont respond.",
						"-Slender, 2024"
					},
				}
			},
			PotatoPatchDev_Aura2247 = {
				name = "Aura2247",
				text = {
					{
						"One of the artists cooking",
						"art for the mod."
					},
					{
						"Could you have guessed that",
						"I like hollow knight?"
					},
					{
						"{C:tarot}Nomai.{}"
					},
				}
			},
			PotatoPatchDev_Quinn = {
				name = "Quinn",
				text = {
					"I didn't contribute much I was on vacation",
					"Hope you like the art tho {C:hearts}<3{}"
				}
			},
		},
		Other = Other,
		Tag = {
			tag_worm_tlr_const = {
				name = "Stellar Tag",
				text = {
					"Gives a free",
					"{C:attention}Mega Constellation Pack",
				},
			},
		}
	},
	misc = {
		dictionary = {
			k_worm_tlr_constellation = "Constellation",
			k_tlr_const_pack = "Constellation Pack",
			b_worm_tlr_constellation_cards = "Constellation",
			k_worm_tlr_add = "Add",
			k_worm_tlr_remove = "Remove",
			k_worm_tlr_selected = "Selected",
			k_worm_tlr_confirm = "Confirm",
			k_worm_tlr_orion_rerolls_left_1 = "Rerolls",
			k_worm_tlr_orion_rerolls_left_2 = "Left",
			k_plus_constellation = "+1 Constellation",
		},
		labels = {
			worm_tlr_constellation = "Constellation",
			worm_tlr_star_seal = 'Star Seal'
		}
	}
}