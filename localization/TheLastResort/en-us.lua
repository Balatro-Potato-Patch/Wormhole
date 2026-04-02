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
			"{C:attention}1{} of {C:attention}3{} choices"
		}
	},
	c_worm_tlr_const_orion_t4 = {
		name = "Orion",
		text = {
			"Set Boss Blind to",
			"{C:attention}1{} of {C:attention}3{} choices",
			"You may reroll your choices once",
			"Choices may include blinds",
			"That cannot usually appear",
		}
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
	}
}
for key, obj in pairs(CONSTELLATIONS) do
	local add = "{s:0.7,E:2}" .. constellation_text[string.sub(key, -2)]
	obj.name = {obj.name, add}
end

return {
	descriptions = {
		Tarot = {
			c_worm_tlr_observation = {
				name = "Observation",
				text = {
					"Upgrades leftmost",
					"{V:1}Constellation{} card to",
					"the next tier",
					"{C:inactive,s:0.7}Faint -> Noticable -> Bright -> Shining"
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
						"hi i'm foo",
						"yeah i code",
						"kinda new to this I started in february this year"
					},
					{
						"I named most of these cards",
						"and did a lot of setup",
						"and utility work"
					},
					{
						"Also shoutout to our artists they are cooking"
					},
					{
						"Go play FooBar after you play this",
						"its got some cool things"
					}
				}
			},
			PotatoPatchDev_Jolga = {
				name = "Jolga",
				text = {
					"fill out pls"
				}
			},
			PotatoPatchDev_Breuhh = {
				name = "Breuh",
				text = {
					"fill out pls"
				}
			},
			PotatoPatchDev_Amphiapple = {
				name = "Amphiapple",
				text = {
					"fill out pls"
				}
			},
			PotatoPatchDev_Aura2247 = {
				name = "Aura2247",
				text = {
					"fill out pls"
				}
			},
			PotatoPatchDev_Quinn = {
				name = "Quinn",
				text = {
					"fill out pls"
				}
			},
		},
		Other = {
			worm_tlr_const_info = {
				name = "Constellation Info",
				text = {
					"This card will",
					"be upgraded when",
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
		},
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
		},
		labels = {
			worm_tlr_constellation = "Constellation",
		}
	}
}