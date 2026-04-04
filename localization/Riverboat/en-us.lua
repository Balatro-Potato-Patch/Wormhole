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
                    "When a {C:planet}Planet{} card is used, add",
                    "{X:purple,C:white}#1#X{} the product of its {C:chips}Chips{} and {C:mult}Mult",
                    "to {C:purple}Score{} immediately"
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
            k_revolve_ex = "Revolve!"
        }
    }
}
