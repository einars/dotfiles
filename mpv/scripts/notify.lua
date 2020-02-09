-- save-title.lua -- Save currently running song title to some file
-- Just put this file into your ~/.mpv/lua folder and mpv will find it.
--
-- Copyright (c) 2014 Roland Hieber
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-------------------------------------------------------------------------------
-- helper functions
-------------------------------------------------------------------------------

function print_debug(s)
	-- print("DEBUG: " .. s) -- comment out for no debug info
	return true
end


-- escape string for shell inclusion
function string.shellescape(str)
	return "'"..string.gsub(str, "'", "'\"'\"'").."'"
end


-------------------------------------------------------------------------------
-- here we go.
-------------------------------------------------------------------------------

last_text = ""

function notify_current_track()
	local data = mp.get_property_native("metadata")
	if not data then
		return
	end

	function get_metadata(data, keys)
		for _,v in pairs(keys) do
			if data[v] and string.len(data[v]) > 0 then
				return data[v]
			end
		end
		return ""
	end
	-- srsly MPV, why do we have to do this? :-(
	local artist = get_metadata(data, {"artist", "ARTIST"})
	local album = get_metadata(data, {"album", "ALBUM"})
	local title = get_metadata(data, {"title", "TITLE", "icy-title"})

	local body = ""

	if title ~= "" then
          print_debug("artist: " .. artist)
          print_debug("title: " .. title)

          if artist ~= "" then
            title = ("%s - %s"):format(artist, title)
          end

          body = ("♫ %s\n"):format(title)
        end

        if (body ~= last_text) then
          print_debug(body)
          last_text = body
          local f = io.open("/tmp/mpv.txt", "w")
          f:write(body)
          f:close()

          if (false) then
            local command = ("notify-send -a mpv --urgency=low -- %s"):format(string.shellescape(body))
            -- print_debug("command: " .. command)
            os.execute(command)
          end
        end


end

function disnotify(q)
  print_debug(q.reason)
  if q.reason == "quit" then
    local f = io.open("/tmp/mpv.txt", "w")
    f:write("\n")
    f:close()
  end
end

function notify_metadata_updated(name, data)
	notify_current_track()
end


-- insert main() here

-- mp.register_event("file-loaded", notify_current_track)
mp.register_event("end-file", disnotify)
mp.observe_property("metadata", nil, notify_metadata_updated)
