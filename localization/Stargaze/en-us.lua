return {
	descriptions = {
		PotatoPatch = {

			PotatoPatchTeam_Stargaze = { name = "Stargaze" },

			PotatoPatchDev_FALATRO = {
				name = "FALATRO",
				text = {
					"Basically the only programmer...",
				}
			},

			PotatoPatchDev_KaitlynTheStampede = {
				name = "KaitlynTheStampede",
				text = {
					"Blehh, :3",
				}
			},

			PotatoPatchDev_DanielDeisar = {
				name = "DanielDeisar",
				text = {
					"What is Deisar?",
				}
			},
		},

		Joker = {
			j_worm_sg_typhoon = {
				name = "Humanoid Typhoon",
				text = {
					"This Joker gains {X:mult,C:white}X#3#{} Mult if",
					"played hand is a {C:attention}#2#{}",
					"{s:0.8}poker hand changes each round",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive}){}",
				},
			},

			j_worm_sg_punisher = {
				name = "The Punisher",
				text = {
					{ "{C:mult}+15{} Mult if {C:attention}5 cards{} are played" },
					{ "Prevents Death and {C:attention}evolves" }
				},
			},

			j_worm_sg_punisher2 = {
				name = "The Punisher",
				text = {
					"{X:mult,C:white}X#1#{} Mult, loses {X:mult,C:white}X#2#{} per round",
					"{C:red}Destroys{} self when depleted"
				}
			},

			j_worm_sg_knives = {
				name = "Million Knives",
				text = {
					"On the {C:attention}final hand{} of round,",
					"{C:red}destroy{} {C:attention}lowest ranked{} card in hand,",
					"and add a copy of the {C:attention}highest ranked{}",
					"card in hand to your deck",
				},
			},

			j_worm_sg_journalist = {
				name = "Journalist Stryfe",
				text = {
					"This Joker gains {C:chips}+#2#{} Chips",
					"({C:chips,s:0.8}+#3#{s:0.8} instead if all Joker slots filled)",
					"if played {C:attention}poker hand{} is",
					"the same as {C:attention}previous{} hand",
					"{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}Chips){}",
				},
			},

			j_worm_sg_journalist2 = {
				name = "Journalist Thompson",
				text = {
					"This Joker gains {X:chips,C:white}X#2#{} Chips",
					"{s:0.8}({X:chips,C:white,s:0.8}X#3#{s:0.8} instead if all Joker slots filled)",
					"if {C:attention}poker hand{} has not",
					"been played {C:attention}this round{}",
					"{C:inactive}(Currently {X:chips,C:white}X#1#{} {C:inactive}Chips){}"
				},
			},

			j_worm_sg_nomanland = {
				name = "People Of No Man's Land",
				text = {
					"Earn {C:money}$#3#{} every {C:attention}#2#{} Jokers sold",
					"{C:inactive}(#1#/#2#){}",
				},
			},

			j_worm_sg_GOD = {
				name = "ABSOLUTE GOD OF THE UNIVERSE",
				text = {
					"Every {C:attention}#3# {C:inactive}[#2#] {C:planet}Planet{} cards used,",
					"gain one {C:attention,E:1}Revive{} that prevents Death",
					"{C:inactive}(Total Revives: {C:attention}#1#{C:inactive}){}"
				},
			},
		},

		Back = {
			b_worm_sg_cosmos = {
				name = "Cosmos Deck",
				text = {
					"Start with a {C:dark_edition}Negative{} {C:attention,T:j_space}Space Joker{}",
					"Planet cards have a {C:green}#1# in #2#{} chance",
					"to create a {C:tarot}Tarot{} or {C:spectral}Spectral{} card",
					"{C:inactive}(Must have room!){}"
				},
			},
		},
	},
	misc = {
		dictionary = {
			j_worm_sg_punisher = "Saved by The Punisher",
			j_worm_sg_GOD = "Saved by DIVINE INTERVENTION"
		}
	}
}
