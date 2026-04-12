ExtinctionEvent = {}

local video_cache_folder = "modded_video_cache"

local video
local video_sprite

local is_playing = false
local target_hue = 121/360


-- Make sure video file is placed in native LOVE2D directory
-- so we can load it with love.graphics.newVideo
local function cache_video(path, filename)
    local new_path = video_cache_folder.."/"..filename
    if NFS.getInfo(new_path) then
        return new_path
    end

    local old_path = path..filename
    local file_info = NFS.getInfo(old_path)
    assert(file_info, "Cannot load video ("..filename..") from specified path")

    if not love.filesystem.getInfo(video_cache_folder) then
        love.filesystem.createDirectory(video_cache_folder)
    end
    love.filesystem.write(new_path, NFS.read(old_path))

    return new_path
end

local function init_sprite()
    if video_sprite and Object.is(video_sprite, Sprite) then
        video_sprite:remove()
        video_sprite = nil
    end

    video_sprite = Sprite(-1, -1, G.ROOM.T.w+4, G.ROOM.T.h+4, G.ASSET_ATLAS["ui_1"], {x = 0, y = 0})
    video_sprite.video = video
end

function ExtinctionEvent.init_video()
    local path = cache_video(Wormhole.path.."assets/videos/BalatroStewniversity/", "extinction_event.ogv")
    video = love.graphics.newVideo(path)
    init_sprite()

    return video
end

function ExtinctionEvent.play_video(when_finished)
    if is_playing then
        return
    end

    ExtinctionEvent.init_video()
    is_playing = true

    video:play()

    G.E_MANAGER:add_event(Event({
        blocking = false, blockable = false,
        func = function()
            if video:isPlaying() then
                local new_vol = (G.SETTINGS.SOUND.game_sounds_volume * G.SETTINGS.SOUND.volume / 100) / 100
                video:getSource():setVolume(new_vol)
                return
            end

            is_playing = false
            video_sprite:remove()
            video_sprite = nil
            video = nil
            if type(when_finished) == "function" then
                when_finished()
            end
            return true
        end
    }))

    return video
end

local canvas
local quad

--------------------------------------------
-- Hook draw to play video over entire screen
local game_draw = Game.draw
function Game:draw(...)
    game_draw(self, ...)

    if is_playing then
        --------------------------------------------------------------------------------
        -- Render video on canvas, then draw canvas to main screen with chromakey shader
        -- (otherwise shader won't work)

        local width, height = video_sprite.T.w * G.TILESCALE*G.TILESIZE, video_sprite.T.h * G.TILESCALE*G.TILESIZE

        if not canvas then
            canvas = love.graphics.newCanvas(width, height)

            quad = love.graphics.newQuad( 0, 0, width, height, width, height )
        end

        love.graphics.push()

        canvas:renderTo(function ()
            love.graphics.clear()
            video_sprite:draw()
        end)

        G.SHADERS['worm_stew_chromakey']:send("target_hue", target_hue)
        love.graphics.setShader( G.SHADERS['worm_stew_chromakey'] )
        love.graphics.draw(canvas, quad, 0, 0, 0, 1, 1)

        love.graphics.pop()
    elseif canvas then
        canvas:release()
        canvas = nil
        quad:release()
        quad = nil
    end
end
