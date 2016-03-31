do


Â Â -- Base search URL

Â Â local BASE_URL = 'http://pleer.com/mobile/search?q='


Â Â -- Base download URL

Â Â local BASE_DL_URL = 'http://pleer.com/mobile/files_mobile/'


Â Â local htmlparser = require 'htmlparser'


Â Â -- Provide download link

Â Â local function getDownloadLink(id)

Â Â Â Â return BASE_DL_URL .. id .. '.mp3'

Â Â end


Â Â local function getLyrics(q)

Â Â Â Â local b, c = http.request(BASE_URL .. URL.escape(q))

Â Â Â Â if c ~= 200 then

Â Â Â Â Â return "Oops! Network errors! Try again later."

Â Â Â Â end


Â Â Â Â local root = htmlparser.parse(b)

Â Â Â Â local tracks = root('.track')

Â Â Â Â local output = 'Ø¨Ø±Ø§ÛŒ Ø¯Ø§Ù†Ù„ÙˆØ¯ Ù„ÛŒÙ†Ú© Ø¯Ø§Ù†Ù„ÙˆØ¯ Ø±Ùˆ Ø¨Ù‡ ØµÙˆØ±Øª \n/getmusic [URL]\n Ù†ÙˆÛŒØ³ÛŒØ¯.\n'


Â Â Â Â -- If no tracks found

Â Â Â Â if #tracks < 1 then

Â Â Â Â Â Â Â Â return 'Ø§Ù‡Ù†Ú¯ Ù…ÙˆØ±Ø¯ Ù†Ø¸Ø± Ù¾ÛŒØ¯Ø§ Ù†Ø´Ø¯ :( Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ API ØªØºÛŒÛŒØ± Ù…ÛŒÚ©Ù†Ø¯.'

Â Â Â Â end


Â Â Â Â for i, track in pairs(tracks) do


Â Â Â Â Â Â Â Â -- Track id

Â Â Â Â Â Â Â Â local trackId = track.id


	-- Remove that starting 't' in the id of element

Â Â Â Â Â Â Â Â trackId = trackId:sub(2)


Â Â Â Â Â Â Â Â -- Parse track

Â Â Â Â Â Â Â Â track = track:getcontent()

Â Â Â Â Â Â Â Â track = htmlparser.parse(track)


Â Â Â Â Â Â Â Â -- Track artist

Â Â Â Â Â Â Â Â local artist = track:select('.artist')[1]

Â Â Â Â Â Â Â Â artist = unescape_html(artist:getcontent())


Â Â Â Â Â Â Â Â -- Track title 

Â Â Â Â Â Â Â Â local title = track:select('.title')[1]

Â Â Â Â Â Â Â Â title = unescape_html(title:getcontent())


Â Â Â Â Â Â Â Â -- Track time

Â Â Â Â Â Â Â Â local time = track:select('.time')[1]

Â Â Â Â Â Â Â Â time = time:getcontent()

Â Â Â Â Â Â Â Â time = time:sub(-5)


Â Â Â Â Â Â Â Â -- Track specs

Â Â Â Â Â Â Â Â local specs = track:select('.specs')[1]

Â Â Â Â Â Â Â Â specs = specs:getcontent()

Â Â Â Â Â Â Â Â specs = specs:split(',')

	-- Size

Â Â Â Â Â Â Â Â local size = specs[1]:trim()

	-- Bitrate

Â Â Â Â Â Â Â Â local bitrate = specs[2]:trim()



	-- Generate an awesome, well formated output

Â Â Â Â Â Â Â Â output = output .. i .. '. ' .. artist ..'\n'

Â Â Â Â Â Â Â Â .. 'ðŸ•š ' .. time .. ' | ' .. ' ðŸŽ§ ' .. bitrate .. ' | ' .. ' ðŸ“Ž ' .. size .. '\n'

Â Â Â Â Â Â Â Â .. 'ðŸ’¾ : ' .. getDownloadLink(trackId) .. '\n\n '


Â Â Â Â end

Â Â Â Â 

Â Â Â Â return output

Â Â end


Â Â local function run(msg, matches)

Â Â Â Â return getLyrics(matches[1])

Â Â end


Â Â return {

Â Â Â Â description = 'Search and get music from pleer',

Â Â Â Â usage = '!music [track name or artist and track name]: Search and get the music',

Â Â Â Â patterns = {

Â Â Â Â '^!music (.*)$'

Â Â Â Â },

Â Â Â Â run = run

}


end
