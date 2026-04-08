-- Team Dummies JokerQuips

-- [Generic] WIN Quips:
local EXPECTED_WINS = 11; for i=1, EXPECTED_WINS do SMODS.JimboQuip({key='dummies_win_'..tostring(i), type='win'}) end
-- [Generic] LOSS Quips:
local EXPECTED_LOSS = 11; for i=1, EXPECTED_LOSS do SMODS.JimboQuip({key='dummies_loss_'..tostring(i), type='loss'}) end

-- [Custom] Quips:

-- Flowire Trolling Potato Devs:
for i = 1, 3 do
	SMODS.JimboQuip({ key = 'dummies_flowire_'..tostring(i), type = math.random() > 0.5 and 'win' or 'loss' })
end
