sendDebugMessage("BalatrosAPalindrome loading!")

PotatoPatchUtils.Team({name="BalatrosAPalindrome", colour=G.C.BLUE})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="Nogardagem"})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="NerdyBread42"})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="IzzyWizz"})
PotatoPatchUtils.Developer({team="BalatrosAPalindrome",name="Knightingale0"})


SMODS.Atlas {
	-- Key for code to find it with
	key = "Palindrome",
	-- The name of the file, for the code to pull the atlas from
	path = "BalatrosAPalindrome/Palindrome.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

-- Nothing planet card
SMODS.Consumable {
    key = "nothing",
    loc_txt = {
		name = 'Nothing',
		text = {
			"bruh",
		}
	},
    set = "Planet",
    cost = 3,
    pos = { x = 0, y = 0 },
    config = { anim_time = 0 },
    can_use = function(self, card) return true end,
    keep_on_use = function(self, card) return true end,
    --use = function(self, card, area, copier) self.pos.x = self.pos.x + 1 end,
    update = function(self, card, dt)
        self.config.anim_time = self.config.anim_time + dt
        self.pos.x = math.sin(self.config.anim_time) * 0.5 + 0.5
    end
}

SMODS.Joker {
	key = 'perkeo2',
	loc_txt = {
		name = 'Perkeo 2',
		text = {
			"Creates a {C:dark_edition}Negative{} copy of",
			"{C:attention}1{} random {C:attention}consumable{}",
			"card in your possession",
			"at the end of the {C:attention}shop",
		}
	},
	-- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
	config = { extra = {} },
	rarity = 1,
	atlas = 'Palindrome',
	pos = { x = 0, y = 0 },
	-- soul_pos sets the soul sprite, only used in vanilla for legendary jokers and Hologram.
	--soul_pos = { x = 4, y = 1 },
	cost = 1,
	loc_vars = function(self, info_queue, card)
		-- This is the way to add an info_queue, which is extra information about other cards
		-- like Stone Cards on Marble/Stone Jokers, Steel Cards on Steel Joker, and
		-- in this case, information about negative editions on Perkeo.
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
	end,
	calculate = function(self, card, context)
		if context.ending_shop then
			--[[ I very heavily recommend looking through the SMODS wiki
				page that talks about the event manager if you ever need to use it.
				
				For a simple explanation, all the animations and effects happen in a queue.
				A lot of things will be handles automatically, but there are some cases when
				you'll want to use an event manager, usually when things don't run in the order
				you expect them to, or have other edge case things, like ghost cards that still
				exist after you try removing them.
				
				The most common use I've seen is when changing the state of cards, where it
				copies a card and adds it like in this case, or when a card is destroyed or
				when a card is generated. It's daunting, but, it's usually nothing you'll have
				to worry about, and it will make sense if you just take it slow and read the wiki.]]
            
            if #G.consumeables.cards == 0 then return end
            
			G.E_MANAGER:add_event(Event({
				func = function()
					-- pseudorandom_element is a vanilla function that chooses a single random value from a table of values, which in this case, is your consumables.
					-- pseudoseed('perkeo2') could be replaced with any text string at all - It's simply a way to make sure that it's affected by the game seed, because if you use math.random(), a base Lua function, then it'll generate things truly randomly, and can't be reproduced with the same Balatro seed. LocalThunk likes to have the joker names in the pseudoseed string, so you'll often find people do the same.
					
                    
                    local card = copy_card(pseudorandom_element(G.consumeables.cards, 'perkeo2'), nil)

					-- Vanilla function, it's (edition, immediate, silent), so this is ({edition = 'e_negative'}, immediate = true, silent = nil)
					card:set_edition('e_negative', true)
					card:add_to_deck()
					-- card:emplace puts a card in a cardarea, this one is G.consumeables, but G.jokers works, and custom card areas could also work.
					-- I think playing cards use "create_playing_card()" and are separate.
					G.consumeables:emplace(card)
					return true
				end
			}))
			--[[ You can send a message outside a return by using SMODS.calculate_effect]]
			SMODS.calculate_effect(
                { message = localize('k_duplicated_ex') }, -- This can be any `calculate` return table
                context.blueprint_card or card -- The card used by the message
			)
		end
	end
}