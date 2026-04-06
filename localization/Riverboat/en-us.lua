return {
    descriptions = {
        PotatoPatch = {
            PotatoPatchTeam_riverboat = { name = "Riverboat" },
            PotatoPatchDev_blamperer = { name = "blamperer", text = { "t" } },
            PotatoPatchDev_fooping = { name = "fooping", text = { "t" } },
        },
        Joker = {
            j_worm_the_past = {
                name = "The Past",
                text = {
                    "Tracks total {C:attention}Hands{} played this run",
                    "Currently: {C:attention}#1#",
                    "{C:inactive}Yearns for the Future."
                }
            },
            j_worm_the_past_paired = {
                name = "The Past",
                text = {
                    "{C:attention}#1#{} hands played X {C:attention}#2#{} Jokers bought",
                    "{C:inactive}They were never apart. Only waiting."
                }
            },
            j_worm_the_future = {
                name = "The Future",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "for each {C:attention}Joker{} purchased this run",
                    "{C:inactive}Yearns for the Past."
                }
            },
            j_worm_the_future_paired = {
                name = "The Future",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "{C:attention}#2#{} hands played X {C:attention}#3#{} Jokers bought",
                    "{C:inactive}They were never apart. Only waiting."
                }
            },
            j_worm_ulala = {
                name = "Ulala",
                text = {
                    "Gains {C:mult}+#2#{} Mult if played hand",
                    "contains a scoring {C:attention}5{},",
                    "resets if played hand does not",
                    "contain a scoring {C:attention}5{}",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_worm_riverboat_test = {
                name = "test joker",
                text = {
                    "When a {C:planet}Planet{} card is used,",
                    "add {X:purple,C:white}#1#X{} the product of its",
                    "{C:chips}Chips{} and {C:mult}Mult to",
                    "{C:purple}Score{} immediately"
                }
            },
            j_worm_riverboat_calignment = {
                name = "Cosmic Alignment",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult for",
                    "every level {C:attention}above 1",
                    "on all poker hands which",
                    "are {C:red}not{} the played hand",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
                }
            },
            j_worm_riverboat_orbital = {
                name = "Orbital Period",
                text = {
                    "Creates the {C:planet}Planet{} for the",
                    "{C:attention}#1##2# played{} hand this round",
                    "{C:inactive}(Must have room, progresses each round)"
                }
            },
            j_worm_riverboat_threeseven = {
                name = "NGC 2169",
                text = {
                    "Played {C:attention}3{}s and {C:attention}7{}s give",
                    "{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
                    "when scored"
                }
            },
            j_worm_riverboat_worm_hole = {
                name = "Worm Hole",
                text = {
                    "Played but {C:attention}unscored{} cards have a",
                    "{C:green}#1# in #2#{} chance to {C:red}lose one rank{} and",
                    "give this Joker {C:chips}+#3#{} Chips",
                    "{C:inactive}(Currently {C:chips}+#4# {C:inactive}Chips)",
                    "{C:inactive}(2s are destroyed instead)"
                }
            },
            j_worm_riverboat_roche = {
                name = "Roche Limit",
                text = {
                    "If final score is over {C:attention}#1#%{} of Blind score,",
                    "{C:red}destroy{} a held {C:planet}Planet{} and add",
                    "its {C:chips}Chips{} and {C:mult}Mult{} to the winning hand"
                }
            },
            j_worm_riverboat_fractal = {
                name = "Fractal",
                text = {
                    "{C:green}#1# in #2#{} chance for each",
                    "played card to become",
                    "{C:attention}Holographic{} when scored",
                    "{C:inactive}(Only if it has no edition)"
                }
            }
        },
        Enhanced = {
            m_worm_riverboat_stardust = {
                name = "Stardust Card",
                text = {
                    "Adds {C:chips}+#1#{} Chips or {C:mult}+#2#{} Mult",
                    "to played hand if scored"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_revolve_ex = "Revolve!",
            k_disintegrated_ex = "Disintegrated!"
        }
    }
}
