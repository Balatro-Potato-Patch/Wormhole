-- Prevents selling specific Jokers that 
-- add consumable slots (eg. Put It On My Tab)
-- if selling it would overflow held consumables
local sell_card_ref = Card.sell_card
function Card:sell_card()
    if self and self.ability and self.ability.extra and type(self.ability.extra) == 'table'
    and self.ability.extra.cons_slots_mod then
        if #G.consumeables.cards <= G.consumeables.config.card_limit - self.ability.extra.cons_slots_mod then
            return sell_card_ref(self)
        else
            self.area:remove_from_highlighted(self)
            Wormhole.Absinthe.alert_no_space(self, G.consumeables)
        end
    else
        return sell_card_ref(self)
    end
end
