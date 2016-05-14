
				number = number.."\nکشور: جمهوری اسلامی ایران"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\nنوع سیمکارت: همراه اول"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\nنوع سیمکارت: تالیا"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\nنوع سیمکارت: رایتل"
				else
					number = number.."\nنوع سیمکارت: سایر"
				end
			else
				number = number.."\nکشور: خارج\nنوع سیمکارت: متفرقه"
			end
		else
			number = "-----"
		end
	elseif access == 0 then
		if result.from.phone then
			number = "شما مجاز نیستید"
			if string.sub(result.from.phone, 0,2) == '98' then
				number = number.."\nکشور: جمهوری اسلامی ایران"
				if string.sub(result.from.phone, 0,4) == '9891' then
					number = number.."\nنوع سیمکارت: همراه اول"
				elseif string.sub(result.from.phone, 0,5) == '98932' then
					number = number.."\nنوع سیمکارت: تالیا"
				elseif string.sub(result.from.phone, 0,4) == '9893' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.from.phone, 0,4) == '9890' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.from.phone, 0,4) == '9892' then
					number = number.."\nنوع سیمکارت: رایتل"
				else
					number = number.."\nنوع سیمکارت: سایر"
				end
			else
				number = number.."\nکشور: خارج\nنوع سیمکارت: متفرقه"
			end
		else
			number = "-----"
		end
	end
	--info ------------------------------------------------------------------------------------------------
	info = "نام کامل: "..string.gsub(result.from.print_name, "_", " ").."\n"
	.."نام کوچک: "..(result.from.first_name or "-----").."\n"
	.."نام خانوادگی: "..(result.from.last_name or "-----").."\n\n"
	.."شماره موبایل: "..number.."\n"
	.."یوزرنیم: @"..(result.from.username or "-----").."\n"
	.."آی دی: "..result.from.id.."\n\n"
	.."مقام: "..usertype.."\n"
	.."جایگاه: "..userrank.."\n\n"
	.."رابط کاربری: "..hardware.."\n"
	.."تعداد پیامها: "..user_info.msgs.."\n"
	.."نوع پیام: "..msg_type.."\n\n"
	.."نام گروه: "..string.gsub(result.to.print_name, "_", " ").."\n"
	.."آی دی گروه: "..result.to.id
	send_large_msg(org_chat_id, info)
end

local function callback_res(extra, success, result)
	if success == 0 then
		return send_large_msg(org_chat_id, "یوزرنیم وارد شده اشتباه است")
	end
	--icon & rank ------------------------------------------------------------------------------------------------
	if tonumber(result.id) == 139693972 then
		userrank = "Master ⭐⭐⭐⭐"
		send_document(org_chat_id,"./icons/7.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo ⭐⭐⭐⭐⭐"
		send_document(org_chat_id,"./icons/8.webp", ok_cb, false)
	elseif is_admin(result) then
		userrank = "Admin ⭐⭐⭐"
		send_document(org_chat_id,"./icons/3.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(gp_leader) then
		userrank = "Leader ⭐⭐"
		send_document(org_chat_id,"./icons/6.webp", ok_cb, false)
	elseif is_momod(result) then
		userrank = "Moderator ⭐"
		send_document(org_chat_id,"./icons/4.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(our_id) then
		userrank = "Umbrella ⭐⭐⭐⭐⭐⭐"
		send_document(org_chat_id,"./icons/9.webp", ok_cb, false)
	elseif string.sub(result.username:lower(), -3) == 'bot' then
		userrank = "API Bot"
		send_document(org_chat_id,"./icons/5.webp", ok_cb, false)
	else
		userrank = "Member"
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = "-----"
	end
	--phone ------------------------------------------------------------------------------------------------
	if access == 1 then
		if result.phone then
			number = "0"..string.sub(result.phone, 3)
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\nکشور: جمهوری اسلامی ایران"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\nنوع سیمکارت: همراه اول"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\nنوع سیمکارت: تالیا"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\nنوع سیمکارت: رایتل"
				else
					number = number.."\nنوع سیمکارت: سایر"
				end
			else
				number = number.."\nکشور: خارج\nنوع سیمکارت: متفرقه"
			end
		else
			number = "-----"
		end
	elseif access == 0 then
		if result.phone then
			number = "شما مجاز نیستید"
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\nکشور: جمهوری اسلامی ایران"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\nنوع سیمکارت: همراه اول"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\nنوع سیمکارت: تالیا"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\nنوع سیمکارت: رایتل"
				else
					number = number.."\nنوع سیمکارت: سایر"
				end
			else
				number = number.."\nکشور: خارج\nنوع سیمکارت: متفرقه"
			end
		else
			number = "-----"
		end
	end
	--info ------------------------------------------------------------------------------------------------
	info = "نام کامل: "..string.gsub(result.print_name, "_", " ").."\n"
	.."نام کوچک: "..(result.first_name or "-----").."\n"
	.."نام خانوادگی: "..(result.last_name or "-----").."\n\n"
	.."شماره موبایل: "..number.."\n"
	.."یوزرنیم: @"..(result.username or "-----").."\n"
	.."آی دی: "..result.id.."\n\n"
	.."مقام: "..usertype.."\n"
	.."جایگاه: "..userrank.."\n\n"
	send_large_msg(org_chat_id, info)
end

local function callback_info(extra, success, result)
	if success == 0 then
		return send_large_msg(org_chat_id, "آی دی وارد شده اشتباه است")
	end
	--icon & rank ------------------------------------------------------------------------------------------------
	if tonumber(result.id) == 139693972 then
		userrank = "Master ⭐⭐⭐⭐"
		send_document(org_chat_id,"./icons/7.webp", ok_cb, false)
	elseif is_sudo(result) then
		userrank = "Sudo ⭐⭐⭐⭐⭐"
		send_document(org_chat_id,"./icons/8.webp", ok_cb, false)
	elseif is_admin(result) then
		userrank = "Admin ⭐⭐⭐"
		send_document(org_chat_id,"./icons/3.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(gp_leader) then
		userrank = "Leader ⭐⭐"
		send_document(org_chat_id,"./icons/6.webp", ok_cb, false)
	elseif is_momod(result) then
		userrank = "Moderator ⭐"
		send_document(org_chat_id,"./icons/4.webp", ok_cb, false)
	elseif tonumber(result.id) == tonumber(our_id) then
		userrank = "Umbrella ⭐⭐⭐⭐⭐⭐"
		send_document(org_chat_id,"./icons/9.webp", ok_cb, false)
	elseif string.sub(result.username:lower(), -3) == 'bot' then
		userrank = "API Bot"
		send_document(org_chat_id,"./icons/5.webp", ok_cb, false)
	else
		userrank = "Member"
	end
	--custom rank ------------------------------------------------------------------------------------------------
	local file = io.open("./info/"..result.id..".txt", "r")
	if file ~= nil then
		usertype = file:read("*all")
	else
		usertype = "-----"
	end
	--phone ------------------------------------------------------------------------------------------------
	if access == 1 then
		if result.phone then
			number = "0"..string.sub(result.phone, 3)
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\nکشور: جمهوری اسلامی ایران"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\nنوع سیمکارت: همراه اول"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\nنوع سیمکارت: تالیا"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\nنوع سیمکارت: رایتل"
				else
					number = number.."\nنوع سیمکارت: سایر"
				end
			else
				number = number.."\nکشور: خارج\nنوع سیمکارت: متفرقه"
			end
		else
			number = "-----"
		end
	elseif access == 0 then
		if result.phone then
			number = "شما مجاز نیستید"
			if string.sub(result.phone, 0,2) == '98' then
				number = number.."\nکشور: جمهوری اسلامی ایران"
				if string.sub(result.phone, 0,4) == '9891' then
					number = number.."\nنوع سیمکارت: همراه اول"
				elseif string.sub(result.phone, 0,5) == '98932' then
					number = number.."\nنوع سیمکارت: تالیا"
				elseif string.sub(result.phone, 0,4) == '9893' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9890' then
					number = number.."\nنوع سیمکارت: ایرانسل"
				elseif string.sub(result.phone, 0,4) == '9892' then
					number = number.."\nنوع سیمکارت: رایتل"
				else
					number = number.."\nنوع سیمکارت: سایر"
				end
			else
				number = number.."\nکشور: خارج\nنوع سیمکارت: متفرقه"
			end
		else
			number = "-----"
		end
	end
	--name ------------------------------------------------------------------------------------------------
	if string.len(result.print_name) > 15 then
		fullname = string.sub(result.print_name, 0,15).."..."
	else
		fullname = result.print_name
	end
	if result.first_name then
		if string.len(result.first_name) > 15 then
			firstname = string.sub(result.first_name, 0,15).."..."
		else
			firstname = result.first_name
		end
	else
		firstname = "-----"
	end
	if result.last_name then
		if string.len(result.last_name) > 15 then
			lastname = string.sub(result.last_name, 0,15).."..."
		else
			lastname = result.last_name
		end
	else
		lastname = "-----"
	end
	--info ------------------------------------------------------------------------------------------------
	info = "نام کامل: "..string.gsub(result.print_name, "_", " ").."\n"
	.."نام کوچک: "..(result.first_name or "-----").."\n"
	.."نام خانوادگی: "..(result.last_name or "-----").."\n\n"
	.."شماره موبایل: "..number.."\n"
	.."یوزرنیم: @"..(result.username or "-----").."\n"
	.."آی دی: "..result.id.."\n\n"
	.."مقام: "..usertype.."\n"
	.."جایگاه: "..userrank.."\n\n"
	send_large_msg(org_chat_id, info)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
	gp_leader = data[tostring(msg.to.id)]['settings']['gp_leader']
	org_chat_id = "chat#id"..msg.to.id
	if is_sudo(msg) then
		access = 1
	else
		access = 0
	end
	if matches[1] == '/infodel' and is_sudo(msg) then
		azlemagham = io.popen('rm ./info/'..matches[2]..'.txt'):read('*all')
		return 'از مقام خود عزل شد'
	elseif matches[1] == '/info' and is_sudo(msg) then
		local name = string.sub(matches[2], 1, 50)
		local text = string.sub(matches[3], 1, 10000000000)
		local file = io.open("./info/"..name..".txt", "w")
		file:write(text)
		file:flush()
		file:close() 
		return "مقام ثبت شد"
	elseif #matches == 2 then
		local cbres_extra = {chatid = msg.to.id}
		if string.match(matches[2], '^%d+$') then
			return user_info('user#id'..matches[2], callback_info, cbres_extra)
		else
			return res_user(matches[2]:gsub("@",""), callback_res, cbres_extra)
		end
	else
		--custom rank ------------------------------------------------------------------------------------------------
		local file = io.open("./info/"..msg.from.id..".txt", "r")
		if file ~= nil then
			usertype = file:read("*all")
		else
			usertype = "-----"
		end
		--hardware ------------------------------------------------------------------------------------------------
		if matches[1] == "info" then
			hardware = "کامپیوتر"
		else
			hardware = "موبایل"
		end
		if not msg.reply_id then
			--contor ------------------------------------------------------------------------------------------------
			local user_info = {}
			local uhash = 'user:'..msg.from.id
			local user = redis:hgetall(uhash)
			local um_hash = 'msgs:'..
