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

-- A board is a 2D array of values, a character (corresponding to the piece type it came from) means its occupied
-- if it is 0 then it is not occupied
local BOARD_W, BOARD_H = 10, 20 -- Additional 5 blocks out of view, all pieces start at the 20th cell
local BLOCK_W, BLOCK_H = 8, 8
-- Clearance
local BOARD_HCLEARANCE = -5

local function GtoSpeed(g)
	return g / 256
end

local function ResetPlayerState()
	return {
		state = 0,          -- Literal current state
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

		clears = 0,         -- Line clears
		clear_cols = {},    -- Lines cleared (literal)

		start_delay = 1.25, -- Ready? Go!

		points = 0,         -- This game uses TA's hidden point system to award grades
		point_decay = 0,

		topped_out = false, -- Game over
		credits = false, -- In M roll

		credit_fadeout = 0,
		credit_time = 0,
	}
end

-- Current state
JtemTGM.PlayerState = ResetPlayerState()
