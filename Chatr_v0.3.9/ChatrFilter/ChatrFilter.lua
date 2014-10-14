ChatrFilter_HelpText="Lines not starting with I or O are disregarded.\nThe line format is as follows:\n<Direction>:<Type>:<Match>:<Action>\nDirection may be I (inbound) or O (outbound). Note that this is purely visual.\nType may be M (message), ML (message, lowercased) or N (name). If type begins with =, the string must match exactly (instead of substring).\nMatch is a Lua pattern to match against. Remember that you can use ^ and $ for start and end.\nAction may be\n  i (ignore)\n  s <pattern> (substitute with <pattern>)\n  r <text> (replaces the entire message/name with text)\n  l <lua> (run lua)\n  e <reply> (reply to whisper)\nExamples\nFilter \"OMG\" to \"Oh gosh!\": I:M:OMG:s Oh gosh!\nNever show anything with \"DKP\" that is whispered to you: I:M:DKP:i";
ChatrFilter_List="# No filters set. Check below for help.";
function ChatrFilter_Init()

end

function ChatrFilter_DoChain(mode,name,msg)
	local cnt,lst,line,lcnt,parts,st,mst,match,action,g;
	cnt,lst=Chatr_Split("\n",ChatrFilter_List,0);
	for _,line in lst do
		if strlower(strsub(line,1,1))==mode then
			Chatr_Debug("Match line ("..line..")");
			lcnt,parts=Chatr_Split(":",strsub(line,3),0);
			if parts[1]==nil or parts[2]==nil or parts[3]==nil then
				Chatr_Print("Filter: Possible syntax error in the line <"..line..">");
			end
			st=nil;
			mst=strlower(parts[1]);
			match=parts[2];
			action=parts[3];
			exact=0;
			if strsub(mst,1,1)=="=" then
				mst=strsub(mst,2)
				exact=1
			end
			if mst=="m" then st=msg; end
			if mst=="ml" then st=strlower(msg); end
			if mst=="n" then st=name; end
			Chatr_Debug("Matching ("..match..") against ("..st..")");
			if st~=nil then
				if (exact==0 and strfind(st,match)~=nil) or (exact==1 and st==match) then
					Chatr_Debug("Match success");
					if action=="i" then return nil,nil; end
					if strsub(action,1,1)=="s" then
						g=strsub(action,3);
						if mst=="m" or mst=="ml" then msg=gsub(st,match,g); end
						if mst=="n" then name=gsub(name,match,g); end
					end
					if strsub(action,1,1)=="r" then
						g=strsub(action,3);
						if mst=="m" or mst=="ml" then msg=g; end
						if mst=="n" then name=g; end
					end
					if strsub(action,1,1)=="l" then
						RunScript(strsub(action,3));
					end
					if strsub(action,1,1)=="e" then
						SendChatMessage(strsub(action,3),"WHISPER",nil,name);
					end
					
				else
					Chatr_Debug("No Match");
				end
			end
		end
	end
	return name,msg;
end

function ChatrFilter_In(name,msg)
	name,msg=ChatrFilter_DoChain("i",name,msg);
	return name,msg;
end

function ChatrFilter_Out(name,msg)
	name,msg=ChatrFilter_DoChain("o",name,msg);
	return name,msg;
end
