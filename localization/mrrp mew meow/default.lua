return {
descriptions={
	Joker={
		j_worm_alien_cat ={
			name=
				"Alien Cat"
			, text={
				"{C:green}#1# in #2#{} chance for",
				"each played {C:attention}#3#{} to",
				"create a {C:planet}#4#{}",
				"card when scored"
			}
		},
		j_worm_pallasite ={
			name=
				"Pallasite"
			, text={
				"If played {C:attention}poker hand{}",
				"was upgraded this round,",
				"cards give {C:money}$#1#{} when scored"
			}
		},
		j_worm_cookie_cat ={
			name=
				"Cookie Cat"
			, text={
				"{C:planet}#1#{} {C:attention}temporary{} levels to",
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
				"{C:mult}#1#{} Mult for every",
				"upgraded {C:attention}poker hand{}",
				"{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)"
			}
		},
		j_worm_gofish ={
			name=
				"Pisces"
			, text={
				"If poker hand contains a",
				"{C:attention}#1#{}, destroy it",
				"and create a {C:attention}#2#{}",
				"{C:red}self-destructs{}"
			}
		},
		j_worm_goldilocks ={
			name=
				"Goldilocks Zone"
			, text={
				"If played hand is a {C:attention}#1#{},",
				"turn the {C:attention}middlemost{} scoring card",
				"into a {C:attention}#2#{} with a {C:attention}#3# Seal{}"
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
		j_worm_orrery ={
			name=
				"Orrery"
			, text={
				"When upgrading level of any",
				"{C:attention}poker hand{}, create one copy",
				"between {C:tarot}The Star{}, {C:tarot}The Moon{},",
				"{C:tarot}The Sun{}, and/or {C:tarot}The World{}",
				"{C:inactive}(Must have room){}"
			}
		},
		j_worm_capitalism ={
			name={
				"Outer Space,",
				"The One Place",
				"Left Uncorrupt",
				"by Capitalism"
			}, text={
				"This Joker gains {C:mult}#1#{} Mult",
				"when ending a {C:attention}shop{} with",
				"no money being spent",
				"{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult){}"
			}
		},
	},
	Stake={
		stake_worm_cosmic ={
			name=
				'Cosmic Stake'
			, text={
				"Shop can have {C:attention}Gravity{} Jokers",
				"{C:inactive,s:0.8}(Halve all poker hand levels when bought){}",
				"{s:0.8}Applies {C:money,s:0.8}Gold Stake{}"
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
				"Halve all {C:attention}poker hand{}",
				"levels when bought"
			}
		},
		worm_cookie_cat_song ={
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
},
misc={
	v_dictionary={
		a_level_minus = "-#1# Level"
	},
	labels={
		worm_celestial = "Celestial",
	},
	dictionary={
	--	k_downgrade_ex = "Downgrade!",
	},
},
}