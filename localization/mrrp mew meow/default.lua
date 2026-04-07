return {
descriptions={
	Joker={
		j_worm_aliencat ={
			name=
				"Alien Cat"
			, text={
				"{C:green}#1# in #2#{} chance for",
				"each played {C:attention}#3#{} to",
				"create a {C:planet}#4#{}",
				"card when scored"
			}
		},
		j_worm_asteroidmine ={
			name=
				"Asteroid Mine"
			, text={
				"If played {C:attention}poker hand{}",
				"was upgraded this round,",
				"cards give {C:money}$#1#{} when scored"
			}
		},
		j_worm_cookiecat ={
			name=
				"Cookie Cat"
			, text={
				"{C:planet}+#1#{} {C:attention}temporary{} levels to",
				"each played {C:attention}poker hand{}",
				"{C:planet,s:0.8}#2#{s:0.8} level per hand played{}",
			}
		},
		j_worm_countdown ={
			name=
				"Countdown to Launch"
			, text={
				"Upgrade level of played",
				"{C:attention}poker hand{} if it contains",
				"a {C:attention}#1#{} and no {C:attention}face{} cards"
			}
		},
		--[[]]
		j_worm_felicette ={
			name=
				"Félicette"
			, text={
				"{C:chips}+#1#{} Chips for every",
				"upgraded {C:attention}poker hand{}",
				"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
			}
		},
		--[[] ]
		j_worm_felicette ={
			name=
				"Félicette"
			, text={
				"This Joker gains {C:chips}+#1#{} Chips",
				"whenever a {C:attention}poker hand{} is",
				"upgraded from {C:planet}Level 1{}"
				"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
			}
		}
		--[[]]
		j_worm_gofish ={
			name=
				"Pisces"
			, text={
				"If poker hand contains a {C:attention}#1#{},",
				"destroy it, then create a {C:attention}#2#{}",
				"{C:red}self-destructs{}"
			}
		},
		j_worm_goldilocks ={
			name=
				"Goldilocks Zone"
			, text={
				"If played hand is a {C:attention}#1#{},",
				"the middle scoring card becomes",
				"a {C:attention}#2#{} with a {C:attention}#3# Seal{}"
			}
		},
		j_worm_nasahiring ={
			name=
				"NASA's Exploration Team"
			, text={
				"When {C:attention}Blind{} is selected,",
				"create a {C:dark_edition}#1#{}",
				"{C:money}#2#{} {C:attention}Space{} Joker",
			}
		},
		j_worm_capitalism ={
			name={
				"The One Place",
				"Left Uncorrupt",
				"by Capitalism"
			}, text={
				"This Joker gains {C:mult}+#1#{} Mult",
				"when ending a {C:attention}shop{} with",
				"no money being spent",
				"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
			}
		},
	},
	Stake={
		worm_cosmic ={
			name=
				'Cosmic Stake'
			, text={
				"Shop can have {C:attention}Gravity{} Jokers",
				"{C:inactive,s:0.8}(Halves all hand levels){}"
			}
		}
	},
	Back={
		
	},
	Other={
		worm_celestial ={
			name=
				"Celestial"
			, text={
				"Halves all {C:attention}poker hand{}",
				"levels when acquired"
			}
		}
	},
},
misc={
	v_dictionary={
		a_level_minus = "-#1# Levels"
	},
	labels={
		worm_celestial = "Celestial",
	},
	dictionary={
		k_downgrade_ex = "Downgrade!"
	},
},
}