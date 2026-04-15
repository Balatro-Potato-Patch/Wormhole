return {
  descriptions = {
    worm_jr_satellite = {
      sat_worm_new_horizon = {
        name = "New Horizon",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "After playing a {C:attention}#2#{},",
            "draw {C:attention}#1#{} more card#3#"
          }
        }
      },
      sat_worm_messenger = {
        name = "MESSENGER",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand is a {C:attention}#2#{},",
            "{C:attention}unscored{} cards have a {C:green}#3# in #4#",
            "chance to give {C:money}$#1#{}"
          }
        }
      },
      sat_worm_tianwen_4 = {
        name = "Tianwen-4",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "create {C:attention}#1#{} cop#3# of",
            "#4#random scoring card#5#"
          }
        }
      },
      sat_worm_venera_9 = {
        name = "Venera 9",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "{C:attention}#1#{} card#3# in full deck",
            "have a {C:green}#4# in #5#{} change to",
            "become the rank of",
            "the {C:attention}#2#"
          }
        }
      },
      sat_worm_cassini_huygens = {
        name = "Cassini-Huygens",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand is a",
            "{C:attention}#2#{}, destroy {C:attention}#1#{} card#3#",
            "in full deck of ranks",
            "not in the {C:attention}#2#"
          }
        }
      },
      sat_worm_galileo = {
        name = "Galileo",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand is a",
            "{C:attention}#2#{}, convert {C:attention}#1#{} card#3#",
            "in full deck to the",
            "{C:attention}#2#{}'s most common suit"
          }
        }
      },
      sat_worm_sputnik_1 = {
        name = "Sputnik 1",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "apply a random",
            "{C:attention}enhancement{}, {C:attention}edition{}",
            "or {C:attention}seal{} to",
            "{C:attention}#1#{} card#3# in deck"
          }
        }
      },
      sat_worm_mariner_9 = {
        name = "Mariner 9",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand is a",
            "{C:attention}#2#{}, gain {C:money}$#1#{} per card",
            "of the rank of the {C:attention}#2#",
            "in your {C:attention}full deck"
          }
        }
      },
      sat_worm_voyager_2 = {
        name = "Voyager 2",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "cards in scoring hand",
            "permanently gain {C:white,X:mult}X#3#{} Mult"
          }
        }
      },
      sat_worm_death_egg = {
        name = "Death Egg",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "all Jokers give {C:white,X:mult}X#3#{} Mult"
          }
        }
      },
      sat_worm_dawn = {
        name = "Dawn",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "{C:attention}last 2{} played cards give",
            "{C:white,X:mult}X#3#{} Mult when scored"
          }
        }
      },
      sat_worm_manhole_cover = {
        name = "Manhole Cover",
        text = {
          {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
            "{C:attention}#2#",
          },
          {
            "If played hand",
            "is a {C:attention}#2#{},",
            "retrigger {C:attention}#1#{} card#3#",
            "at random"
          }
        }
      },
    },
    Voucher = {
      v_worm_jr_launch_pad = {
        name = 'Launch pad',
        text = {
          "Adds {C:attention}#1#{} {C:worm_jr_satellite}Satellite{} card",
          "to opened {C:planet}Celestial{} packs"
        }
      },
      v_worm_jr_flyby = {
        name = 'Fly-By',
        text = {
          "{C:worm_jr_satellite}Satellite{} cards create",
          "a {C:dark_edition}Negative{} {C:planet}Planet{} card",
          "for their {C:attention}corresponding",
          "{C:attention}hand type{} when used"
        }
      },
    },
    Back = {
      b_worm_jr_colonist = {
        name = "Colonist Deck",
        text = {
          "{C:worm_jr_satellite}Satellites{} cards may",
          "appear in the shop,",
          "start run with the",
          "{C:worm_jr_satellite,T:v_worm_jr_launch_pad}Launch Pad{} voucher"
        }
      },
    },
    Joker = {
      j_worm_jr_transponder = {
        name = "Transponder",
        text = {
          "Gains {X:mult,C:white}X#1#{} Mult for",
          "every {C:worm_jr_satellite}Satellite{} above 0",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
      },
      j_worm_jr_nasa = {
        name = "NASA",
        text = {
          "After defeating a {C:attention}Boss Blind{}, create the",
          "corresponding {C:worm_jr_satellite}Satellite{} card",
          "for your {C:attention}last played hand",
        }
      },
      j_worm_jr_deep_space_probe = {
        name = "Deep Space Probe",
        text = {
          "Every {C:attention}#2#{} level increases",
          "for poker hands,",
          "create a {C:worm_jr_satellite}Satellite{} Card",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive}/{C:inactive}#2#)",
        }
      },
      j_worm_jr_crash_course = {
        name = "Crash Course",
        text = {
          "If hand is played while holding",
          "its corresponding {C:planet}Planet{} card,",
          "destroy the {C:planet}Planet{} card and",
          "create its respective {C:worm_jr_satellite}Satellite{} Card",
        }
      },
    },
    Other = {
      p_worm_jr_orbital_normal = {
        name = "Orbital Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:worm_jr_satellite}Satellite{} cards",
          "to be used immediately"
        }
      },
      p_worm_jr_orbital_jumbo = {
        name = "Jumbo Orbital Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:worm_jr_satellite}Satellite{} cards",
          "to be used immediately"
        }
      },
      p_worm_jr_orbital_mega = {
        name = "Mega Orbital Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:worm_jr_satellite}Satellite{} cards",
          "to be used immediately"
        }
      },
    },
    Tag = {
      tag_worm_jr_planetarium = {
        name = "Planetarium Tag",
        text = {
          "Gives a free",
          "{C:worm_jr_satellite}Mega Orbital Pack"
        }
      },
    },
    PotatoPatch = {
      PotatoPatchTeam_JuryRigged = { name = "JuryRigged" },
      PotatoPatchDev_DowFrin = { name = "DowFrin", text = { { "Listen to {C:red}Fire4Fun{} by {C:money}Jhariah{} :7", "Credit to {C:chips}Inky{} for this credit art" }, { "I coded the framework + utils for the {C:worm_jr_satellite}Satellite{} cards,", "the vouchers and most of the jokers", }, { "All things considered this team was pretty amazing to work with!" } } },
      PotatoPatchDev_Maelmc = { name = "Maelmc", text = { "Play {C:attention}The Binding of Jimbo{} :)" } },
      PotatoPatchDev_Inky = { name = "Inky", text = { { "Did most of the satellite art and drew some joker art" }, { "(...yes, the Square Joker guy. That's him.)" } } },
      PotatoPatchDev_DoggFly = { name = "Dogg-Fly", text = { "i love yuri, yuri is my life" } },
      PotatoPatchDev_AbelSketch = { name = "AbelSketch", text = { { "{C:attention}Fun Fact:{} Theres a reason to not share water bottles!" }, { "I got Salmonela from one... 3:" } }},
      PotatoPatchDev_Blanthos = { name = "Blanthos", text = { "First we Gneep, then we Gnarp. Lets Gneep Gnarp." } },
      PotatoPatchDev_NinjaBanana = { name = "NinjaBanana", text = { "GUYS I'M NOT THE IMPOSTOR PLEASE DON'T EJECT ME" } },
    }
  },
  misc = {
    dictionary = {
      -- Standard badge text
      k_worm_jr_satellite = "Satellite",
      -- For Death Egg and Manhole
      k_worm_jr_satellite_fake = "Satellite..?",

      b_worm_jr_satellites = "Satellites",
      b_worm_jr_satellite_cards = "Satellite Cards",

      worm_jr_orbital_pack = "Orbital Pack",

      -- Satellite names for Run Info
      worm_jr_satellites_new_horizon = "New Horizon",
      worm_jr_satellites_messenger = "MESSENGER",
      worm_jr_satellites_tianwen_4 = "Tianwen-4",
      worm_jr_satellites_venera_9 = "Venera 9",
      worm_jr_satellites_galileo = "Galileo",
      worm_jr_satellites_cassini_huygens = "Cassini-Huygens",
      worm_jr_satellites_sputnik_1 = "Sputnik 1",
      worm_jr_satellites_mariner_9 = "Mariner 9",
      worm_jr_satellites_voyager_2 = "Voyager 2",
      worm_jr_satellites_death_egg = "Death Egg",
      worm_jr_satellites_dawn = "Dawn",
      worm_jr_satellites_manhole_cover = "Manhole Cover",

      worm_jr_plus_satellite = "+1 Satellite",
    }
  }
}
