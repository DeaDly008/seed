ult.to.id) then

		 text = text..'جایگاه : مدیر گروه (Moderator) \n\n'

		 else

		 text = text..'جایگاه : کاربر (Member) \n\n'

			end

		 local hash = 'rank:'..result.to.id..':variables'

		local value = redis:hget(hash, result.from.id)

		 text = text..'مقام : '..(value or '----')..'\n\n'

         local user_info = {}

  local uhash = 'user:'..result.from.id

  local user = redis:hgetall(uhash)

  local um_hash = 'msgs:'..result.from.id..':'..result.to.id

  user_info_msgs = tonumber(redis:get(um_hash) or 0)

  text = text..'تعداد پیام های فرستاده شده : '..user_info_msgs..'\n\n'

  text = text..'@CopierTeam'

  send_msg(extra.receiver, text, ok_cb, true)

end


local function action_by_reply2(extra, success, result)

local value = extra.value

setrank(result, result.from.id, value)

end


local function run(msg, matches)

 if matches[1]:lower() == 'setrank' then

  local hash = 'usecommands:'..msg.from.id..':'..msg.to.id

  redis:incr(hash)

  if not is_sudo(msg) then

    return "Only for Sudo"

  end

  local receiver = get_receiver(msg)

  local Reply = msg.reply_id

  if msg.reply_id then

  local value = string.sub(matches[2], 1, 1000)

    msgr = get_message(msg.reply_id, action_by_reply2, {receiver=receiver, Reply=Reply, value=value})

  else

  local name = string.sub(matches[2], 1, 50)

  local value = string.sub(matches[3], 1, 1000)

  local text = setrank(msg, name, value)


  return text

  end

  end

 if matches[1]:lower() == 'info' and not matches[2] then

  local receiver = get_receiver(msg)

  local Reply = msg.reply_id

  if msg.reply_id then

    msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver, Reply=Reply})

  else

  if msg.from.username then

   Username = '@'..msg.from.username

   else

   Username = 'ندارد'

   end

   local text = 'نام : '..(msg.from.first_name or 'ندارد')..'\n'

   local text = text..'فامیل : '..(msg.from.last_name or 'ندارد')..'\n'	

   local text = text..'یوزر : '..Username..'\n'

   local text = text..'ایدی کاربری : '..msg.from.id..'\n\n'

		if msg.from.id == tonumber(Arian) then

		 text = text..'جایگاه : مدیر کل ربات (Executive Admin) \n\n'

		elseif is_sudo(msg) then

		 text = text..'جایگاه : ادمین ربات (Admin) \n\n'

		elseif is_owner(msg) then

		 text = text..'جایگاه : مدیر کل گروه (Owner) \n\n'

		elseif is_momod(msg) then

		 text = text..'جایگاه : مدیر گروه (Moderator) \n\n'

		else

		 text = text..'جایگاه : کاربر (Member) \n\n'

		end

	 end

local hash = 'rank:'..msg.to.id..':variables'

	if hash then

	 local value = redis:hget(hash, msg.from.id)

	 text = text..'مقام : '..(value or '----')..'\n'

	end

    

	 local uhash = 'user:'..msg.from.id

 	 local user = redis:hgetall(uhash)

  	 local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id

	 user_info_msgs = tonumber(redis:get(um_hash) or 0)

	 text = text..'تعداد پیام های فرستاده شده : '..user_info_msgs..'\n\n'

	 if msg.to.type == 'chat' then

	 text = text..'نام گروه : '..msg.to.title..'\n'

     text = text..'ایدی گروه : '..msg.to.id

    end

	text = text..'\n\n@CopierTeam project'

    return send_msg(receiver, text, ok_cb, true)

    end

  end

  if matches[1]:lower() == 'info' and matches[2] then

   local user = matches[2]

   local chat2 = msg.to.id

   local receiver = get_receiver(msg)

   if string.match(user, '^%d+$') then

	 user_info('user#id'..user, action_by_id, {receiver=receiver, user=user, text=text, chat2=chat2})

    elseif string.match(user, '^@.+$') then

      username = string.gsub(user, '@', '')

      msgr = res_user(username, res_user_callback, {receiver=receiver, user=user, text=text, chat2=chat2})

   end

  end

end

return {

description = "گرفتن اطلاعت دیگران",

usage = {

"Info : گرفتن اطلاعت خود",

"Info (Username or ID) : گرفتن اطلاعت دیگران",

"Setrank (username or ID) (rank) : گذاشتن مقام دلخواه برای دیگران",


},

patterns = {

   "^([Ii][Nn][Ff][Oo])$",

   "^([Ii][Nn]Ff][Oo]) (.*)$",

   "^([Ss][Ee][Tt][Rr][Aa][Nn][Kk] (%d+) (.*)$",

   "^([Ss][Ee][Tt][Rr][Aa][Nn][Kk] (.*)$"

},

run = run

}
