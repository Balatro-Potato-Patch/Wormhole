-- It's fucking tetris

-- This is still ridiculously incomplete, will work more on this later
if true then
	-- return
end

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
local BLOCK_W, BLOCK_H = 4, 4
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
		grade = 0,          -- Current grade
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

		justPressedLeftRot = false,
		justPressedRightRot = false,
		olddir = 0,
		oldvdir = 0,

		dt = 0,
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

	if newstate == STATE_LOCKING and game.state ~= STATE_LOCKING then
		game.lock_timer = game.lock_delay
		game.clears = 0
		JtemTGM.PlaySound("land")
	end

	if newstate == STATE_DROPPING then
		if game.state == STATE_ARE then
			if (game.level % 100) ~= 99 and game.level ~= MAX_LEVEL - 1 then
				game.level = game.level + 1
				if (game.level % 100) == 99 or game.level == MAX_LEVEL - 1 then
					JtemTGM.PlaySound("bell")
				end
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
				JtemTGM.PlaySound("irs")
				JtemTGM.CheckRotation(game.current_piece, -1, game.board)
			end
			if love.keyboard.isDown("x") then
				JtemTGM.PlaySound("irs")
				JtemTGM.CheckRotation(game.current_piece, 1, game.board)
			end
			table.remove(game.next_pieces, 1)
			table.insert(game.next_pieces, JtemTGM.GeneratePiece(game.randomizer))
			JtemTGM.PlaySound("piece_" .. game.next_pieces[1])
		end
		game.clears = 0
		game.soft = game.state == STATE_ARE and 0 or game.soft
	end

	if newstate == STATE_LOCKED and game.state == STATE_LOCKING then
		game.clear_time = game.clear_delay
		game.clears = 0
		game.clear_cols = {}
		-- place le piece
		JtemTGM.PlacePiece(game.current_piece, game.board, game.lightup)
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
		if line_count > 0 then
			JtemTGM.PlaySound("line_clear")
			if line_count >= 4 then
				JtemTGM.PlaySound("cheer")
			end
		else
			JtemTGM.PlaySound("lock")
		end
		game.combo = game.combo + ((2 * line_count) - 2)
		if line_count == 0 then
			game.clear_time = 1
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
			if math.max(0, math.floor(game.old_level / 100)) ~= math.max(0, math.floor(game.level / 100)) then
				JtemTGM.PlaySound("level_up")
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
			JtemTGM.PlacePiece(game.current_piece, game.board)
			game.current_piece = {}
		end
		game.ghost_piece = {}
		game.credit_fadeout = 0
		if newstate == STATE_CONGRATULATIONS then
			if game.topped_out then
				local board = game.board
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
			for y = BOARD_H - 1, 0, -1 do
				local zeros = 0
				local col = game.board[y]
				for x = 0, BOARD_W - 1 do
					local cell = col[x]
					if cell ~= nil and cell == 0 then
						zeros = zeros + 1
					end
				end
				if zeros == 0 then
					for y1 = y, 0, -1 do
						for x = 0, BOARD_W - 1 do
							if game.board[y1] ~= nil and game.board[y1][x] ~= nil and game.board[y1 - 1] ~= nil and game.board[y1 - 1][x] ~= nil then
								game.board[y1][x] = game.board[y1 - 1][x]
							end
						end
					end
				end
			end
		end
		JtemTGM.PlaySound("thud")
	end

	game.state = newstate
end

--#endregion

--#region Piece placing and such

function JtemTGM.ValidPiece(cell)
	return tonumber(cell) == nil
end

function JtemTGM.PieceOccupied(board, x, y)
	x = math.floor(x); y = math.floor(y)

	local col = board[y]
	if col == nil then return false end
	local cell = col[x]
	if cell == nil then return false end
	local piece = JtemTGM.pieces[cell]

	return not (not (tonumber(cell) == nil and piece))
end

function JtemTGM.ValidMove(board, x, y, piece)
	x = math.floor(x); y = math.floor(y);

	if JtemTGM.ValidPiece(piece) and JtemTGM.PieceOccupied(board, x, y) then return false end

	if x > BOARD_W - 1 and JtemTGM.ValidPiece(piece) then return false end
	if y > BOARD_H - 1 and JtemTGM.ValidPiece(piece) then
		return false
	end
	if x < 0 and JtemTGM.ValidPiece(piece) then return false end
	if y < BOARD_HCLEARANCE and JtemTGM.ValidPiece(piece) then return false end

	return true
end

function JtemTGM.CreatePieceWithOffset(current, offs)
	local t = {}
	t.rotation = current.rotation
	t.piece = current.piece
	t.x = math.floor(current.x + offs.x)
	t.y = math.floor(current.y + offs.y)
	return t
end

function JtemTGM.CanPlacePiece(current, board)
	if next(current) == nil then return true end
	-- check if we can move
	-- check for its position on the board
	local piece = JtemTGM.pieces[current.piece][current.rotation]
	if not piece then return false end

	-- check the piece if we can collide with the board
	for y = 1, 4 do
		local col = piece[y]
		if col == nil then goto continue end
		for x = 1, 4 do
			local cell = piece[y][x]
			if cell == nil then goto xcontinue end
			if cell == 0 then goto xcontinue end -- nope!
			if not JtemTGM.ValidMove(board, math.floor(current.x + (x - 1)), math.floor(current.y + (y - 1)), current.piece) then
				-- NOPE!
				return false
			end
			::xcontinue::
		end
		::continue::
	end
	return true
end

-- Returns true if the movement was successful
-- Taken from https://github.com/cambridge-stacker/cambridge/blob/main/tetris/components/piece.lua
function JtemTGM.MoveInGrid(current, step, squares, board, instant)
	if next(current) == nil then return true end
	local moved = false
	for i = 1, squares do
		if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, step), board) then
			moved = true
			current.x = current.x + step.x
			current.y = current.y + step.y
			if instant then
				current.x = math.floor(current.x)
				current.y = math.floor(current.y)
				JtemTGM.MoveInGrid(current, { x = 0, y = 1 }, BOARD_H * 2, board)
			end
		else
			break
		end
	end
	return moved
end

function JtemTGM.IsMoveBlocked(current, offset, board)
	local moved_piece = JtemTGM.CreatePieceWithOffset(current, offset)
	return not JtemTGM.CanPlacePiece(moved_piece, board)
end

function JtemTGM.IsDropBlocked(current, board)
	return JtemTGM.IsMoveBlocked(current, { x = 0, y = 1 }, board)
end

function JtemTGM.CheckMoveX(current, inc, board)
	local dir = inc < 0 and -1 or 1
	return JtemTGM.MoveInGrid(current, { x = dir, y = 0 }, math.abs(inc), board)
end

function JtemTGM.CheckMoveY(current, inc, board, nomove)
	local dir = inc < 0 and -1 or 1
	return JtemTGM.MoveInGrid(current, { x = 0, y = dir }, math.abs(inc), board)
end

function JtemTGM.CheckTopout(current, board)
	if next(current) == nil then return true end
	-- check if we can move
	-- check for its position on the board
	local piece = JtemTGM.pieces[current.piece][current.rotation]
	if not piece then return false end

	-- check the piece if we can collide with the board
	for y = 1, 4 do
		local col = piece[y]
		if col == nil then return false end
		for x = 1, 4 do
			local cell = piece[y][x]
			if cell == nil then return false end
			if cell == 0 then goto xcontinue end -- nope!
			if not JtemTGM.ValidMove(board, current.x + (x - 1), current.y + (y - 1), current.piece) then
				-- NOPE!
				return false
			end
			::xcontinue::
		end
		::continue::
	end
	return true
end

function JtemTGM.CheckRotation(current, inc, board)
	if next(current) == nil then return true end
	local newrot = current.rotation + inc
	if newrot < 1 then newrot = 4 end
	if newrot > 4 then newrot = 1 end

	-- O never kicks
	if current.piece == "O" then return end

	-- check if we can rotate
	-- check for its position on the board
	local piece = JtemTGM.pieces[current.piece][newrot]
	if not piece then return false end

	local first = false
	local center_check = (current.piece == "L" or current.piece == "J" or current.piece == "T") and
		(current.rotation == 1 or current.rotation == 3)

	-- check the piece if we can collide with the board
	for y = 1, 4 do
		local col = piece[y]
		if col == nil then return false end
		for x = 1, 4 do
			local cell = piece[y][x]
			if cell == nil then return false end
			if cell == 0 then goto continue end -- nope!
			local px = current.x + (x - 1)
			local py = current.y + (y - 1)
			if not first and JtemTGM.PieceOccupied(board, px, py) then first = true end
			-- center column rule (needs testing)
			if center_check and x == 2 and JtemTGM.PieceOccupied(board, px, py) and first then return false end
			if not JtemTGM.ValidMove(board, px, py, current.piece) then
				local oldrot = current.rotation
				current.rotation = newrot
				-- special kick rules for I
				if current.piece == "I" then
					-- wallkick if horizontal
					if (current.rotation == 1 or current.rotation == 3)
						and (JtemTGM.IsMoveBlocked(current, { x = -1, y = 0 }, board) or JtemTGM.IsMoveBlocked(current, { x = 1, y = 0 }, board)) then
						-- Try again, this time 1 unit to the right
						if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = 1, y = 0 }), board) then
							current.x = current.x + 1
							return true
						end
						-- Try AGAIN gain, 2 more units to the right
						if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = 2, y = 0 }), board) then
							current.x = current.x + 2
							return true
						end
						-- Try again, this time 1 unit to the left
						if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = -1, y = 0 }), board) then
							current.x = current.x - 1
							return true
						end
						-- floorkick if vertical
					elseif (current.rotation == 2 or current.rotation == 4) and not current.floorkick then
						if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = 0, y = -1 }), board) then
							current.y = math.floor(current.y) - 1
							current.floorkick = 1
							return true
						end
						if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = 0, y = -2 }), board) then
							current.y = math.floor(current.y) - 2
							current.floorkick = 1
							return true
						end
					end
				else
					-- Try again, this time 1 unit to the right
					if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = 1, y = 0 }), board) then
						current.x = current.x + 1
						return true
					end
					-- Try again, this time 1 unit to the left
					if JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = -1, y = 0 }), board) then
						current.x = current.x - 1
						return true
					end
					-- T piece specifics
					if current.piece == "T" and current.rotation == 1 and not current.floorkick and JtemTGM.CanPlacePiece(JtemTGM.CreatePieceWithOffset(current, { x = 0, y = -1 }), board) then
						current.y = math.floor(current.y) - 1
						current.floorkick = 1
						return true
					end
				end
				current.rotation = oldrot
				return false
			end
			::continue::
		end
	end

	current.rotation = newrot
	return true
end

function JtemTGM.PlacePiece(current, board, lightup)
	local piece = JtemTGM.pieces[current.piece][current.rotation]
	if not piece then return false end

	for y = 1, 4 do
		local col = piece[y]
		if col == nil then goto continue end
		for x = 1, 4 do
			local cell = piece[y][x]
			if cell == nil then goto ycontinue end
			if cell == 0 then goto ycontinue end -- nope!
			board[math.floor(current.y) + (y - 1)][math.floor(current.x) + (x - 1)] = current.piece
			if lightup then
				lightup[math.floor(current.y) + (y - 1)] = lightup[math.floor(current.y) + (y - 1)] or {}
				lightup[math.floor(current.y) + (y - 1)][math.floor(current.x) + (x - 1)] = true
			end
			::ycontinue::
		end
		::continue::
	end
end

--#endregion

--#region Sounds

---@type love.filesystem
local nativefs = SMODS.NFS
local files = nativefs.getDirectoryItems(Wormhole.path .. "/assets/sounds/Jtem 2/tetris")
for k, file in ipairs(files) do
	local basename = file:gsub("%.%w+$", "")
	SMODS.Sound {
		key = "jtem2_tetris_" .. basename,
		path = "Jtem 2/tetris/" .. file
	}
end

function JtemTGM.PlaySound(id)
	play_sound("worm_jtem2_tetris_" .. id, 1.0, 0.7)
end

--#endregion

--#region Actual logic

function JtemTGM.GetDirectionalInput()
	-- Unfortunately for now I'll hardcode the keybinds
	-- I don't want to deal with controllers right now.
	local left = love.keyboard.isDown("left") and -1 or 0
	local right = love.keyboard.isDown("right") and 1 or 0
	local dir = left + right
	local up = love.keyboard.isDown("up") and -1 or 0
	local down = love.keyboard.isDown("down") and 1 or 0
	local vdir = up + down

	return dir, vdir
end

function JtemTGM.HandleMove(game)
	if game.state == STATE_ARE then return end
	if game.state == STATE_LOCKED then return end

	local dir, vdir = JtemTGM.GetDirectionalInput()

	-- Annoyingly, Love2D has no concept of dedicated "just" pressed buttons, so do that myself
	if love.keyboard.isDown("z") and not game.justPressedLeftRot then
		JtemTGM.CheckRotation(game.current_piece, -1, game.board)
	end
	if love.keyboard.isDown("x") and not game.justPressedRightRot then
		JtemTGM.CheckRotation(game.current_piece, 1, game.board)
	end

	if dir > 0 then
		if (not (game.olddir > 0)) or game.das_time > game.das_delay then
			JtemTGM.CheckMoveX(game.current_piece, 1, game.board)
		end
	elseif dir < 0 then
		if (not (game.olddir < 0)) or game.das_time > game.das_delay then
			JtemTGM.CheckMoveX(game.current_piece, -1, game.board)
		end
	else
		game.das_time = 0
	end

	if vdir > 0 then
		game.current_piece.y = math.floor(game.current_piece.y)
		local ret = JtemTGM.MoveInGrid(game.current_piece, { x = 0, y = 1 }, 1, game.board)
		if not ret then
			if game.state < STATE_LOCKING then
				JtemTGM.ChangeState(game, STATE_LOCKING)
			else
				game.lock_timer = 1
			end
		end
		game.soft = game.soft + 1
	end

	-- Sonic Drop > Hard Drop btw
	if vdir < 0 and game.oldvdir >= 0 then
		game.current_piece.y = math.floor(game.current_piece.y)
		JtemTGM.MoveInGrid(game.current_piece, { x = 0, y = 1 }, 1, game.board, true)
		if game.state < STATE_LOCKING then
			JtemTGM.ChangeState(game, STATE_LOCKING)
		end
	end

	if vdir == 0 and game.state == STATE_DROPPING then
		JtemTGM.MoveInGrid(game.current_piece, { x = 0, y = game.fall_speed }, 1, game.board)
		if JtemTGM.IsDropBlocked(game.current_piece, game.board) then
			JtemTGM.ChangeState(game, STATE_LOCKING)
		end
	end

	game.olddir = dir
	game.oldvdir = vdir
	game.justPressedLeftRot = love.keyboard.isDown("z")
	game.justPressedRightRot = love.keyboard.isDown("x")
end

function JtemTGM.HandleGame(game)
	if not game.board then return end

	local dir, vdir = JtemTGM.GetDirectionalInput()

	if dir > 0 then
		game.das_time = game.das_time + 1
	elseif dir < 0 then
		game.das_time = game.das_time + 1
	end

	if game.state == STATE_DROPPING or game.state == STATE_LOCKING then
		JtemTGM.HandleMove(game)
	end

	if game.state == STATE_LOCKING then
		if not JtemTGM.IsDropBlocked(game.current_piece, game.board) then
			JtemTGM.ChangeState(game, STATE_DROPPING)
		end

		game.lock_timer = math.max(0, game.lock_timer - 1)
		if game.lock_timer <= 0 then
			JtemTGM.ChangeState(game, STATE_LOCKED)
		end
	end

	if game.state == STATE_LOCKED then
		if game.clear_time == game.clear_delay - 2 then
			for y, col in pairs(game.lightup) do
				for x, cell in pairs(col) do
					game.lightup[y][x] = nil
				end
			end
		end
		game.clear_time = math.max(0, game.clear_time - 1)
		if game.clear_time <= 0 then
			game.entry_time = game.entry_delay
			JtemTGM.ChangeState(game, STATE_ARE)
		end
	end

	if game.state == STATE_ARE then
		game.clear_cols = {}

		game.entry_time = math.max(0, game.entry_time - 1)
		if game.entry_time == math.max(0, game.entry_delay - 2) then
			for y, col in pairs(game.lightup) do
				for x, cell in pairs(col) do
					game.lightup[y][x] = nil
				end
			end
		end
		if game.entry_time <= 0 then
			JtemTGM.ChangeState(game, STATE_DROPPING)
		end
	end

	if game.state == STATE_READY or game.state == STATE_GO then
		game.state_timer = math.max(0, game.state_timer - 1)
		if game.state_timer <= 0 then
			JtemTGM.ChangeState(game, game.state == STATE_READY and STATE_GO or STATE_DROPPING)
		end
	end
end

JtemTGM.targetTPS = 1.0 / 60
function JtemTGM.UpdateGame(game, dt)
	if dt == 0 then return end
	game.dt = game.dt + dt
	if game.dt >= JtemTGM.targetTPS then
		JtemTGM.HandleGame(game)
		game.dt = game.dt - JtemTGM.targetTPS
	end
end

local BOARD_XOFFSET = 5
local BOARD_YOFFSET = 9

function JtemTGM.DrawPiece(piece, x, y, piece_w, piece_h, rotation, dark)
	love.graphics.push()
	love.graphics.translate(x * piece_w, y * piece_h)
	local p = JtemTGM.pieces[piece][rotation]
	love.graphics.setColor(JtemTGM.pieces[piece].color)
	if dark and dark > 0 then
		love.graphics.setColor(darken(JtemTGM.pieces[piece].color, dark))
	end
	for fy = 0, 3 do
		for fx = 0, 3 do
			if p[fy + 1][fx + 1] == 1 then
				love.graphics.rectangle("fill", fx * piece_w, fy * piece_h, piece_w, piece_h)
			end
		end
	end
	love.graphics.pop()
end

function JtemTGM.BoardStencil()
	love.graphics.rectangle("fill", 0, 0, BOARD_W * BLOCK_W, BOARD_H * BLOCK_H)
end

---@param canvas love.Canvas|table
---@param game table
function JtemTGM.HandleDraw(canvas, game)
	local oldcanvas = love.graphics.getCanvas()
	love.graphics.push()
	love.graphics.origin()
	love.graphics.setCanvas({ canvas, stencil = true })

	love.graphics.translate(BOARD_XOFFSET, BOARD_YOFFSET)
	love.graphics.clear()

	love.graphics.stencil(JtemTGM.BoardStencil, "replace", 1)
	love.graphics.setStencilTest("greater", 0)

	-- draw the current board first
	for y = BOARD_HCLEARANCE, BOARD_H - 1 do
		local col = game.board[y]
		if col == nil then goto continue end
		local py = y * BLOCK_H
		for x = 0, BOARD_W - 1 do
			local cell = game.board[y][x]
			if cell == nil then goto xcontinue end
			local px = x * BLOCK_W

			local p = JtemTGM.pieces[cell]
			if not p then goto xcontinue end
			local piece = p[1]

			if JtemTGM.ValidPiece(cell) and piece then
				love.graphics.setColor(G.C.WHITE)
				love.graphics.rectangle("fill", px - 1, py - 1, BLOCK_W + 2, BLOCK_H + 2)
			end
			::xcontinue::
		end
		::continue::
	end

	for y = BOARD_HCLEARANCE, BOARD_H - 1 do
		local col = game.board[y]
		if col == nil then goto continue end
		local py = y * BLOCK_H
		for x = 0, BOARD_W - 1 do
			local cell = game.board[y][x]
			if cell == nil then goto xcontinue end
			local px = x * BLOCK_W

			local p = JtemTGM.pieces[cell]
			if not p then goto xcontinue end
			local piece = p[1]

			if JtemTGM.ValidPiece(cell) and piece then
				love.graphics.setColor(darken(p.color, 0.2))
				love.graphics.rectangle("fill", px, py, BLOCK_W, BLOCK_H)
			end
			::xcontinue::
		end
		::continue::
	end

	love.graphics.setStencilTest()

	-- draw the piece being dealt
	local current = game.current_piece
	if current and current.piece then
		local darken = game.lock_delay - game.lock_timer
		local t = (darken / game.lock_delay) * 0.2
		if game.state ~= STATE_LOCKING then t = 0 end
		JtemTGM.DrawPiece(current.piece, current.x, current.y, BLOCK_W, BLOCK_H,
			current.rotation, t)
	end

	-- draw next piece
	local next = game.next_pieces[1]
	if next then
		JtemTGM.DrawPiece(next, 11, 0, BLOCK_W, BLOCK_H, 1, 0)
	end

	love.graphics.pop()
	love.graphics.setCanvas({ oldcanvas, stencil = true })
end

--#endregion

--#region SMODS Joker definition

SMODS.Atlas({
	key = "jtem2_tetris",
	path = "Jtem 2/jokers/tetris.png",
	px = 71,
	py = 95,
})

-- Here's the actual Joker definition
SMODS.Joker {
	key = "jtem2_tetris",

	ppu_team = { "jtem2" },
	ppu_coder = { "haya" },
	-- ppu_artist = { "missingnumber" },

	rarity = 2,
	cost = 8,

	atlas = "jtem2_tetris",
	pos = { x = 0, y = 0 },

	attributes = {
		'xmult',
		'scaling',
	},

	config = { extra = { game_state = {} } },

	update = function(self, card, dt)
		if next(card.ability.extra.game_state) then
			JtemTGM.UpdateGame(card.ability.extra.game_state, dt)
		end
	end,

	loc_vars = function(self, info_queue, card)
		return {
			vars = { ((card.ability.extra.game_state.level or 0) / 100) + 1 }
		}
	end,

	set_sprites = function(self, card, front)
		card.children.jtem2_tetris_canvas = SMODS.CanvasSprite { canvasScale = 1 }
		card.children.jtem2_tetris_canvas.role.draw_major = card
		card.children.jtem2_tetris_canvas.states.hover.can = false
		card.children.jtem2_tetris_canvas.states.click.can = false
	end,

	add_to_deck = function(self, card, from_debuff)
		if from_debuff then return end
		card.ability.extra.game_state = JtemTGM.ResetPlayerState()
		card.ability.extra.game_state.state = STATE_READY
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = ((card.ability.extra.game_state.level or 0) / 100) + 1
			}
		end
	end
}

SMODS.DrawStep {
	key = "jtem2_tetris_draw",
	order = 9,
	func = function(card, layer)
		if card.config.center_key == "j_worm_jtem2_tetris" and card.children.jtem2_tetris_canvas and next(card.ability.extra.game_state or {}) then
			JtemTGM.HandleDraw(card.children.jtem2_tetris_canvas.canvas, card.ability.extra.game_state)
			---@type balatro.Sprite
			local spr = card.children.jtem2_tetris_canvas
			spr:draw_shader('dissolve', nil, nil, nil, card.children.center)
		end
	end,
	conditions = { vortex = false, facing = 'front' },
}
SMODS.draw_ignore_keys.jtem2_tetris_canvas = true

--#endregion
