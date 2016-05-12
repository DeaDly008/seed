eader) then 
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
            if string.sub(result.phone, 0,4) == '9
