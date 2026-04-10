ExtinctionEvent = {}

local video_cache_folder = "modded_video_cache"

local video
local volume = 1

local video_sprite
local is_playing = false

function ExtinctionEvent.get_video()
    return video
end

function ExtinctionEvent.set_video_volume(vol)
    volume = vol or 0
end

-- Make sure video file is placed in native LOVE2D directory
-- so we can load it with love.graphics.newVideo
local function cache_video(path, filename)
    local new_path = video_cache_folder.."/"..filename
    if NFS.getInfo(new_path) then
        return new_path
    end

    local old_path = path..filename
    local file_info = NFS.getInfo(old_path)
    assert(file_info, "Cannot load video")

    if not love.filesystem.getInfo(video_cache_folder) then
        love.filesystem.createDirectory(video_cache_folder)
    end
    love.filesystem.write(new_path, NFS.read(old_path))

    return new_path
end

function ExtinctionEvent.init_video()
    video = love.graphics.newVideo(cache_video(Wormhole.path.."assets/videos/BalatroStewniversity/", "extinction_event.ogv"))
    return video
end

local function init_sprite()
    if video_sprite and Object.is(video_sprite, Sprite) then
        video_sprite:remove()
        video_sprite = nil
    end

    video_sprite = Sprite(-2, -2, G.ROOM.T.w+4, G.ROOM.T.h+4, G.ASSET_ATLAS["ui_1"], {x = 0, y = 0})
    video_sprite.video = ExtinctionEvent.init_video()
end

function ExtinctionEvent.play_video(when_finished)
    if not video then
        ExtinctionEvent.init_video()
    end

    is_playing = true

    G.E_MANAGER:add_event(Event({
        func = function()
            video:play()
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        blocking = false, blockable = false,
        func = function()
            if video:isPlaying() then
                video:getSource():setVolume(volume)
                return
            end
            is_playing = false
            video:pause()
            video:seek(0)
            if type(when_finished) == "function" then
                when_finished()
            end
            return true
        end
    }))

    return video
end


-- Make sure to load video on game startup.
init_sprite()

--------------------------------------------
-- Hook draw to play video over entire screen
local game_draw = Game.draw
function Game:draw(...)
    game_draw(self, ...)

    if is_playing then
        love.graphics.push()
        video_sprite:translate_container()
        video_sprite:draw()
        love.graphics.pop()
    end
end
