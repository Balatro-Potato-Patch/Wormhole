SMODS.Challenge {
  key = 'rocket_paper_scissors',
  button_colour = HEX("83e9f8"),
  rules = {
    custom = {
      {id = "rocket_paper_scissors" },
      {id = "polarskull_credits_1"},
      {id = "polarskull_credits_2"},
      {id = "polarskull_credits_3"}
    },
  },
  deck = { type = "Challenge Deck", },
  jokers = {},
  restrictions = {
    banned_cards = {},
    banned_other = {},
  },
}
local get_new_boss_ref = get_new_boss
function get_new_boss()
  if G.GAME.modifiers.rocket_paper_scissors then
    local boss = pseudorandom_element({"bl_eye","bl_mouth"}, pseudoseed('boss'))
    --(uncomment below if we want to hardcode it so it alters every ante)
    --local boss = G.GAME.round_resets.ante % 2 == 0  and "bl_mouth" or "bl_eye"
    return boss
  end
  return get_new_boss_ref()
end