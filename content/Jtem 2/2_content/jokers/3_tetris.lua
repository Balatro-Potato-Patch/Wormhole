-- It's fucking tetris

JtemTGM = {}

-- Pieces, arranged in a 2d array
-- Indexed by rotation number 1-4
-- For simplicity, rotation is calculated later
JtemTGM.pieces = {
	I = {
		-- Default rotation
		{
			{ 0, 0, 0, 0 },
			{ 1, 1, 1, 1 },
			{ 0, 0, 0, 0 },
			{ 0, 0, 0, 0 },
		},
		color = G.C.RED,
	},
	O = {
		{
			{ 0, 0, 0, 0 },
			{ 0, 1, 1, 0 },
			{ 0, 1, 1, 0 },
			{ 0, 0, 0, 0 },
		},
		color = G.C.YELLOW,
	},
	-- All other pieces are technically in a 3x3 grid, but accounted in rotation as 4x4
	-- This means all pieces are bottom-aligned, ala ARS
	T = {
		{
			{ 0, 0, 0 },
			{ 1, 1, 1 },
			{ 0, 1, 0 },
		},
		color = G.C.BLUE,
	},
	L = {
		{
			{ 0, 0, 0 },
			{ 1, 1, 1 },
			{ 1, 0, 0 },
		},
		color = G.C.ORANGE,
	},
	J = {
		{
			{ 0, 0, 0 },
			{ 1, 1, 1 },
			{ 0, 0, 1 },
		},
		color = darken(G.C.BLUE, 0.5),
	},
	S = {
		{
			{ 0, 0, 0 },
			{ 0, 1, 1 },
			{ 1, 1, 0 },
		},
		color = G.C.PURPLE,
	},
	Z = {
		{
			{ 0, 0, 0 },
			{ 1, 1, 0 },
			{ 0, 1, 1 },
		},
		color = G.C.GREEN,
	},
}
JtemTGM.pieces_index = { "I", "T", "L", "J", "S", "Z", "O" }
JtemTGM.starting_pieces = { "I", "T", "L", "J" }

-- https://devforum.roblox.com/t/coding-challenge-5-rotating-90-degrees/581975/16
local function rotateCW(matrix)
	local res = {}
	local n = 0
	for i, v in pairs(matrix) do
		local tableSize = #v
		table.insert(res, {})
		n = n + 1
		for x = tableSize, 1, -1 do
			table.insert(res[n], matrix[x][i])
		end
	end
	return res
end

-- Each piece is rotated 3 additional times, referencing the last rotation.
-- Also add an additional row and column if the length is 3.
for name, piece in pairs(JtemTGM.pieces) do
	-- rotate each piece
	for i = 2, 4 do
		piece[i] = rotateCW(piece[i - 1])
	end

	-- specific stuff for specific pieces
	-- I, S and Z only have 2 states
	if name == "I" or name == "S" then
		piece[3] = piece[1]
		piece[4] = piece[2]
	end
	if name == "Z" then
		-- rotation 2 and 4 base on rotation 4
		piece[3] = piece[1]
		piece[2] = piece[4]
	end

	for n, rotation in ipairs(piece) do
		local dstate = name == "I" or name == "S" or name == "Z" or name == "O"

		-- annoying stuff to keep it bottom aligned
		-- 3rd rotation state must have empty space on the first column
		if n == 3 and not dstate then
			table.insert(rotation, 1, { 0, 0, 0, 0 })
		end

		-- check for amount of rows and columns
		-- add an additional if 3
		for _, col in ipairs(rotation) do
			col[4] = col[4] or 0
		end
		local l = #rotation
		if l == 3 then
			rotation[4] = { 0, 0, 0, 0 }
		end

		for _, col in ipairs(rotation) do
			local str = ""
			for _, row in ipairs(col) do
				str = str .. tostring(row)
			end
		end
	end
end

--#region Constants & Util Functions

-- A board is a 2D array of values, a character (corresponding to the piece type it came from) means its occupied
-- if it is 0 then it is not occupied
local BOARD_W, BOARD_H = 10, 20 -- Additional 5 blocks out of view, all pieces start at the 20th cell
local BLOCK_W, BLOCK_H = 2, 2
-- Clearance
local BOARD_HCLEARANCE = -5
-- Max level
local MAX_LEVEL = 999

-- All current states
local STATE_NONE = 0
local STATE_DROPPING = 1 -- Piece is dropping
local STATE_LOCKING = 2  -- Piece has hit the ground, lock after a certain time, can go back to STATE_DROPPING
local STATE_LOCKED = 3   -- Locked the piece in
local STATE_ARE = 4      -- ARE checking
local STATE_READY = 5    -- Getting ready
local STATE_GO = 6
local STATE_GAMEOVER = 7 -- Game is over
local STATE_DROPOUT = 8  -- Puyo style drop out
local STATE_CONGRATULATIONS = 9
local STATE_YOUR = 10
local STATE_AER = 11
local STATE_GRADESHOW = 12
local STATE_WAIT = 13 -- Waiting to try again
local STATE_INVISIBLETETRIS = 14

local function GtoSpeed(g)
	return g / 256
end

local igs = {
	[0] = { "9", 125, 10, 20, 40, 50 },
	[1] = { "8", 80, 10, 20, 30, 40 },
	[2] = { "7", 80, 10, 20, 30, 40 },
	[3] = { "6", 50, 10, 15, 30, 40 },
	[4] = { "5", 45, 10, 15, 20, 40 },
	[5] = { "4", 45, 5, 15, 20, 30 },
	[6] = { "4", 45, 5, 10, 20, 30 },
	[7] = { "3", 40, 5, 10, 15, 30 },
	[8] = { "3", 40, 5, 10, 15, 30 },
	[9] = { "2", 40, 5, 10, 15, 30 },
	[10] = { "2", 40, 2, 12, 13, 30 },
	[11] = { "2", 40, 2, 12, 13, 30 },
	[12] = { "1", 30, 2, 12, 13, 30 },
	[13] = { "1", 30, 2, 12, 13, 30 },
	[14] = { "1", 30, 2, 12, 13, 30 },
	[15] = { "S1", 20, 2, 12, 13, 30 },
	[16] = { "S1", 20, 2, 12, 13, 30 },
	[17] = { "S1", 20, 2, 12, 13, 30 },
	[18] = { "S2", 20, 2, 12, 13, 30 },
	[19] = { "S3", 20, 2, 12, 13, 30 },
	[20] = { "S4", 15, 2, 12, 13, 30 },
	[21] = { "S4", 15, 2, 12, 13, 30 },
	[22] = { "S4", 15, 2, 12, 13, 30 },
	[23] = { "S5", 15, 2, 12, 13, 30 },
	[24] = { "S5", 15, 2, 12, 13, 30 },
	[25] = { "S6", 15, 2, 12, 13, 30 },
	[26] = { "S6", 15, 2, 12, 13, 30 },
	[27] = { "S7", 15, 2, 12, 13, 30 },
	[28] = { "S7", 15, 2, 12, 13, 30 },
	[29] = { "S8", 15, 2, 12, 13, 30 },
	[30] = { "S8", 10, 2, 12, 13, 30 },
	[31] = { "S9", 10, 2, 12, 13, 30 },
}

function JtemTGM.GetLinePoints(grade, lines)
	if lines <= 0 then return 0 end
	return igs[grade][lines + 2] or 0
end

function JtemTGM.GetDecayRate(grade)
	return igs[grade][2]
end

function JtemTGM.GetGradeName(grade)
	return igs[grade][1]
end

local COMBO_MULTIPLIER = {
	{ 1.0, 1.0, 1.0, 1.0 },
	{ 1.2, 1.4, 1.5, 1.0 },
	{ 1.2, 1.5, 1.8, 1.0 },
	{ 1.4, 1.6, 2.0, 1.0 },
	{ 1.4, 1.7, 2.2, 1.0 },
	{ 1.4, 1.8, 2.3, 1.0 },
	{ 1.4, 1.9, 2.4, 1.0 },
	{ 1.5, 2.0, 2.5, 1.0 },
	{ 1.5, 2.1, 2.6, 1.0 },
	{ 2.0, 2.5, 3.0, 1.0 },
}

--#endregion

--#region Piece randomizer

-- Stripped version of the 35 bag randomizer from Cambridge
-- https://github.com/cambridge-stacker/cambridge/blob/main/tetris/randomizers/history_6rolls_35bag.lua

function JtemTGM.CreateRandomizer()
	local self = {}
	self.first = true
	self.history = { "Z", "S", "Z", "S" }
	self.pool = {
		"I", "I", "I", "I", "I",
		"T", "T", "T", "T", "T",
		"L", "L", "L", "L", "L",
		"J", "J", "J", "J", "J",
		"S", "S", "S", "S", "S",
		"Z", "Z", "Z", "Z", "Z",
		"O", "O", "O", "O", "O",
	}
	self.droughts = {
		I = 4,
		T = 4,
		L = 4,
		J = 4,
		S = 4,
		Z = 4,
		O = 4,
	}
	self.piece_index = {
		"I",
		"T",
		"L",
		"J",
		"S",
		"Z",
		"O",
	}
	return self
end

local function updateHistory(self, shape)
	table.remove(self.history, 1)
	table.insert(self.history, shape)
end

local function checkHighDroughtCount(self)
	local high_drought
	local high_drought_count = 0
	for k, v in pairs(self.piece_index) do
		if self.droughts[v] >= high_drought_count then
			high_drought = v
			high_drought_count = self.droughts[v]
		end
	end
	return high_drought_count
end

local function getMostDroughtedPiece(self)
	local high_drought
	local high_drought_count = 0
	for k, v in pairs(self.piece_index) do
		if self.droughts[v] >= high_drought_count then
			high_drought = v
			high_drought_count = self.droughts[v]
		end
	end
	return high_drought
end

local function updateHistogram(self, shape)
	for k, v in pairs(self.piece_index) do
		if v == shape then
			self.droughts[v] = 0
		else
			self.droughts[v] = self.droughts[v] + 1
		end
	end
end

local function inHistory(self, piece)
	for idx, entry in pairs(self.history) do
		if entry == piece then
			return true
		end
	end
	return false
end

function JtemTGM.GeneratePiece(self)
	local index, x, highscore, did_reroll, did_first
	did_reroll = false
	did_first = false
	if self.first then
		index = pseudorandom("tetris", 1, 20)
		x = self.pool[index]
		self.first = false
		did_first = true
	else
		for i = 1, 6 do
			index = pseudorandom("tetris", 1, #self.pool)
			x = self.pool[index]
			if not inHistory(self, x) then
				break
			end
			did_reroll = true -- checked laterer
			self.pool[index] = getMostDroughtedPiece(self)
			index = pseudorandom("tetris", 1, #self.pool)
			x = self.pool[index]
		end
	end

	highscore = checkHighDroughtCount(self)
	updateHistory(self, x)
	updateHistogram(self, x)

	-- replicate TI bug
	-- don't update for first piece, skip the other two tests. this is not the bug, as the first piece was not drawn from the bag.
	if did_first then return x end

	-- we should always update the bag here, but we only update it in two cases.
	if highscore < checkHighDroughtCount(self) then
		-- do update if the high drought count went up
		self.pool[index] = getMostDroughtedPiece(self)
	end
	if not did_reroll then
		-- do update if there is no reroll
		self.pool[index] = getMostDroughtedPiece(self)
	end

	-- if neither happened, the bag does NOT get updated now. to remove the bug, comment ouut both ifs and one of the updates above, so the bag always updates except for first piece
	return x
end

--#endregion

--#region Actual stuff

function JtemTGM.ResetPlayerState()
	local board = {}
	for y = BOARD_HCLEARANCE, BOARD_H - 1 do
		board[y] = {}
		for x = 0, BOARD_W - 1 do
			board[y][x] = 0
		end
	end
	local randomizer = JtemTGM.CreateRandomizer()
	local starting_piece = pseudorandom_element(JtemTGM.starting_pieces, "tetris_start")
	local next_pieces = {
		JtemTGM.GeneratePiece(randomizer),
		JtemTGM.GeneratePiece(randomizer),
		JtemTGM.GeneratePiece(randomizer),
		JtemTGM.GeneratePiece(randomizer),
	}
	local state = {
		state = STATE_NONE, -- Literal current state
		state_complete = false, -- Checks if the state is considered as complete or not
		state_timer = 0,    -- Current state timer

		level = 0,          -- Current level
		old_level = 0,      -- Last level
		score = 0,          -- Current score
		internal_grade = 0, -- Current grade
		visual_grade = "9", -- Visual grade
		combo = 0,          -- Current combo
		time = 0,           -- Current time spent wasting your life on Tetris

		fall_speed = GtoSpeed(4), -- Current fall speed

		lock_timer = 0,     -- Current lock time
		lock_delay = 30,    -- Current lock delay (in frames)

		clear_time = 0,     -- Current clear time
		clear_delay = 12,   -- Current clear delay

		entry_time = 0,     -- Current entry time (ARE)
		entry_delay = 18,   -- Current entry delay (ARE)
		entry_line_delay = 14, -- Current entry delay, after a line clear (ARE)

		das_time = 0,       -- Current DAS time
		das_delay = 12,     -- Current DAS

		cleared = 0,        -- All lines cleared
		clears = 0,         -- Line clears for one piece
		clear_cols = {},    -- Lines cleared (literal)

		start_delay = 1.25, -- Ready? Go!

		points = 0,         -- This game uses TA's hidden point system to award grades
		point_decay = 0,
		soft = 0,

		topped_out = false, -- Game over
		credits = false, -- In M roll

		credit_fadeout = 0,
		credit_time = 0,

		history = { starting_piece, "Z", "Z", "Z" },
		randomizer = randomizer,
		next_pieces = next_pieces,
		current_piece = {},
		ghost_piece = {},

		board = board,
		lightup = {},
	}
	return state
end

function JtemTGM.CreateCurrentPiece(x, y, piece, rot)
	return {
		x = x,
		y = y,
		piece = piece,
		rotation = rot,
	}
end

function JtemTGM.ChangeState(game, newstate)
	-- dumb hack to make sure we dont go to are before placing the piece
	if newstate == STATE_ARE and next(game.current_piece) then
		game.state = STATE_LOCKING
		newstate = STATE_LOCKED
	end

	if newstate == STATE_LOCKING then
		game.lock_timer = game.lock_delay
		game.clears = 0
	end

	if newstate == STATE_DROPPING then
		if game.state == STATE_ARE then
			if (game.level % 100) ~= 99 and game.level ~= MAX_LEVEL - 1 then
				game.level = game.level + 1
			end
		end
		if game.level >= MAX_LEVEL then
			game.level = MAX_LEVEL
			game.credits = true
		end

		if game.state == STATE_GO or game.state == STATE_ARE or game.state == STATE_INVISIBLETETRIS then
			-- change piece
			game.current_piece = JtemTGM.CreateCurrentPiece(3, -1, game.next_pieces[1], 1)
			-- IRS
			if love.keyboard.isDown("z") then

			end
			if love.keyboard.isDown("x") then

			end
			table.remove(game.next_pieces, 1)
			table.insert(game.next_pieces, JtemTGM.GeneratePiece(game.randomizer))
			-- TODO sound
		end
		game.clears = 0
		game.soft = game.state == STATE_ARE and 0 or game.soft
	end

	if newstate == STATE_LOCKED and game.state == STATE_LOCKING then
		game.clears = 0
		game.clear_cols = {}
		-- todo placepiece
		game.current_piece = {}
		game.ghost_piece = {}
		-- calculate lines to clear
		local line_count = 0
		for y = BOARD_H - 1, 0, -1 do
			local col = game.board[y]
			if col ~= nil then
				local add = true
				for x = 0, BOARD_W - 1 do
					local cell = col[x]
					if cell == 0 then add = false end
				end
				if add then
					line_count = line_count + 1
					game.clear_cols[y] = true
					for x = 0, BOARD_W - 1 do
						col[x] = 'C'
						if game.lightup[y] and game.lightup[y][x] then
							game.lightup[y][x] = nil
						end
					end
				end
			end
		end
		game.clears = line_count
		game.combo = game.combo + ((2 * line_count) - 2)
		if line_count == 0 then
			game.combo = 1
		end
		game.level = game.level + line_count
		if game.level >= MAX_LEVEL then
			game.level = MAX_LEVEL
			if not game.credits then
				newstate = STATE_INVISIBLETETRIS
			end
			game.credits = true
		end
		-- calculate score
		local lc = math.max(1, game.level) / 4.0
		if line_count > 0 then
			local add = (lc + game.soft) * line_count * game.combo
			game.score = game.score + add
			-- Award internal points
			local level_multiplier = math.floor(game.level / 250) + 1
			local c = math.min(10, game.combo)
			local mul = math.ceil(JtemTGM.GetLinePoints(game.grade, line_count) *
				(COMBO_MULTIPLIER[c] and COMBO_MULTIPLIER[c][line_count] or 1.0))
			game.points = game.points + (mul * level_multiplier)
			-- Increase internal grade if points exceeds or is 100
			if game.points >= 100 then
				game.points = 0
				game.grade = math.min(game.grade + 1, 31)
				game.point_decay = 0
			end
		end
	end
	game.old_level = game.level
	if newstate == STATE_READY or newstate == STATE_GO then
		game.state_timer = game.start_delay
	end
	if newstate == STATE_YOUR or newstate == STATE_AER then
		game.state_timer = 0
	end
	if newstate == STATE_GAMEOVER then
		game.credit_fadeout = 0
		game.state_timer = game.topped_out and 1.0 or 2.0
	end
	if newstate == STATE_DROPOUT then
		-- TODO
	end
	if newstate == STATE_CONGRATULATIONS or newstate == STATE_INVISIBLETETRIS then
		if next(game.current_piece) then
			game.current_piece = {}
		end
		game.ghost_piece = {}
		game.credit_fadeout = 0
		if newstate == STATE_CONGRATULATIONS then
			if game.topped_out then
				local board = p.etm_board
				for y = BOARD_HCLEARANCE, BOARD_H - 1 do
					board[y] = {}
					for x = 0, BOARD_W - 1 do
						board[y][x] = 0
					end
				end
			end
			game.credit_time = 0
		else
			game.state_timer = 2.0
		end
	end
	if newstate == STATE_ARE and game.clears > 0 then
		for i = 1, game.clears do

		end
	end
end

--#endregion
