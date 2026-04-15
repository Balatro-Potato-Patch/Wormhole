return {
    descriptions = {
        PotatoPatch = {
            VV = { name =  "Violent Violets" },
            FireIce = {
                name = "FireIce",
            },
            Gud = {
                name = "Gup",
            },
            Iso = {
                name = "Isotypical",
            },
            FirstTry = {
                name = "FirstTry",
            },
        },
        Joker = {
        j_worm_alienx = {
            name = "Alien X",
            text = {
                "{C:planet}Planet Cards{} have a {C:green}#1# in #2#{} Chance",
                "to activate a {C:spectral}Black Hole{}"
                }
            },
            j_worm_sttgl = {
            name = "Super Tengen Toppa Gurren Lagann",
            text = {
                {"Creates {C:attention}#3#{} duplicates of",
                "used non-{C:dark_edition}Negative{} {C:planet}Planet Cards{}"},
                {"{C:planet}Planet Cards{} have a {C:green}#1# in #2#{} Chance",
                "to be {C:dark_edition}Negative{} when duplicated"}
                }
            },
            j_worm_fraudthird = {
            name = {'{s:0.8}FRAUD // THIRD',
                'DISINTEGRATION LOOP'
            },
            text = {
                "{X:mult,C:white}X8{} Mult for every scored {C:attention}3{}"
                }
            },
            j_worm_cking = {
            name = "Crescent King",
            text = {
                "Levels up your most played",
                "poker hand after {C:attention}#1#{} Rounds",
                "{C:inactive}(#2#/#1#, #3#)",
                }
            },
            j_worm_tekit = {
            name = "Tek It",
            text = {
                "Using {C:tarot}The Moon{} increases this",
                "Joker's chips by {C:white,X:dark_edition}X#2#",
                "{C:inactive}(Currently: {C:white,X:chips}X#1#{C:inactive})",
                }
            },
            j_worm_astro_n = {
                name = "Astro Novalite",
                text = { {
                    "Adds {C:blue}+#2#{}",
                    "{C:blue}Hands{} and {C:red}Discards{}",
                    "when {C:attention}Blind{} is selected"
                },
                {
                    "Each unique {C:planet}Planet{} used",
                    "gives +1 additional Hands and Discards"
                }
            }
            },
            j_worm_spacecadet = {
                name = "Space Cadet",
                text = {
                    {
                        "{C:green}1 in 3 chance{} to do either of the following:"
                    },
                    {
                        "{C:money}+15$",
                        "{C:blue}+1 Hand",
                        "{X:mult,C:white}X2{} Mult",
                        "{C:attention}Retrigger{} a card once",
                        "{C:inactive,s:0.8}Multiple can activate at the same time."
                    }
                }
            }
        },
        Spectral = {
            c_worm_omnipotence = {
                name = "Omnipotence",
                text = {
                    "Create one Otherworldly Joker, but",
                    "set money to 0 and {C:red}destroy{} one random Joker"
                }
            }
        }
        
    },
    misc = {
        labels = {
			k_worm_otherworldly = "Otherworldly",
        },
        dictionary = {
			k_worm_otherworldly = "Otherworldly",
        }
    }
}