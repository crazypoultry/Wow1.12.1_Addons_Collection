ChatrCrayons_HelpText="Lines starting with # are ignored.\nLine format: <ident>:<mode>:<color>\nIdent:\n nname\n gguild\n zmatch (zone equals yours)\n zzone\n friend (requires Buddies)\nMode: bo(rder) / bg (background) / boa (border alpha) / bga (background alpha)\nColor: RRGGBB hex triplet (or named) or 0.0 to 1.0 for alpha values\nExample: everyone from 'MyGuild' border orange:\ngmyguild:bo:orange";
Chatr_CrayonsList="# No Crayons set. Check below for help.";
function ChatrCrayons_Init()
	Chatr_SaveThis("CrayonsList");
	Chatr_CallMe("ShowSettings",ChatrCrayons_ShowSettings);
	Chatr_CallMe("SettingsLoaded",ChatrCrayons_PostInit);
	Chatr_CallMe("ChatrUpdated",ChatrCrayons_SetColorWrapper);
end

function ChatrCrayons_PostInit()
	ChatrCrayonsList:SetText(Chatr_CrayonsList);
	Chatr_Print(GetAddOnMetadata("ChatrCrayons","Title").." loaded.");
	ChatrCrayonsOptionsTitle:SetText(GetAddOnMetadata("ChatrCrayons","Title"));
	ChatrCrayonsHelpText:SetText(ChatrCrayons_HelpText);
	ChatrCrayonsHelpText:SetFont("Fonts\\ARIALN.TTF",12);
	Chatr_AddPlugin("ChatrCrayons");
end

function ChatrCrayons_HexToInt(h)
  return tonumber(strupper(h),16)
end

function ChatrCrayons_HexTripletEx(v,dr,dg,db)
	local vl,r,g,b
	vl=strlower(v)
	if vl=="red" then return 1,0,0
	elseif vl=="green" then return 0,1,0
	elseif vl=="blue" then return 0,0,1
	elseif vl=="gray" then return 0.5,0.5,0.5
	elseif vl=="white" then return 1,1,1
	elseif vl=="yellow" then return 1,1,0
	elseif vl=="orange" then return 1,0.66,0
	elseif vl=="magenta" then return 1,0,1
	elseif vl=="cyan" then return 0,1,1
	elseif vl=="purple" then return 0.5,0,0.7
	elseif vl=="black" then return 0,0,0
	elseif vl=="pink" then return 1,0.75,0.792
	end
	
	r=ChatrCrayons_HexToInt(strsub(v,1,2))
	g=ChatrCrayons_HexToInt(strsub(v,3,4))
	b=ChatrCrayons_HexToInt(strsub(v,5,6))
	if r==nil or g==nil or b==nil then
		return dr,dg,db
	end
	return r/255.0,g/255.0,b/255.0
end

function ChatrCrayons_HexTriplet(v,dr,dg,db)
	local r,g,b,darken
	darken=0
	if strsub(v,1,4)=="dark" then darken=1; v=strsub(v,5); end
	r,g,b=ChatrCrayons_HexTripletEx(v,dr,dg,db)
	if darken==1 then r=r*0.5; g=g*0.5; b=b*0.5; end
	return r,g,b
end


function ChatrCrayons_ColorFunc()
	if not ColorPickerFrame:IsShown() then
		local r,g,b = ColorPickerFrame:GetColorRGB();
		ChatrCrayonsList:Insert(format("%02X%02X%02X",r*255,g*255,b*255));
	end
end

function ChatrCrayons_ColorCancelFunc(prevvals)
end


function ChatrCrayons_PickColor()
	ColorPickerFrame.func = ChatrCrayons_ColorFunc;
	ColorPickerFrame.cancelFunc = ChatrCrayons_ColorCancelFunc;
	ColorPickerFrame:Show();
	ColorPickerFrame:SetColorRGB(1, 1, 1);
end

function ChatrCrayons_SetColor(chatr)
	local cnt,lst,line,lcnt,parts,match,name,outcolor,bor,bog,bob,bgr,bgg,bgb,change,bga,boa;
	cnt,lst=Chatr_Split("\n",Chatr_CrayonsList,0);
	bgr,bgg,bgb,bga=unpack(Chatr_BGColor);
	bor,bog,bob,boa=unpack(Chatr_BorderColor);
	change=nil;
	name=chatr.target;
	for _,line in lst do
		if strsub(line,1,1)~="#" then
			
			lcnt,parts=Chatr_Split(":",line,0);
			match=nil;
			Chatr_Debug("chk line ("..line.."): p: "..lcnt);
			if lcnt==3 then
				if parts[1]=="n"..strlower(name) then match=1; end
				if Chatr_WhoInfo[name]~=nil then
					if parts[1]=="g"..strlower(Chatr_WhoInfo[name][2]) then match=1; end
					if parts[1]=="zmatch" and Chatr_WhoInfo[name][6]==GetRealZoneText() then match=1; end
					if parts[1]=="z"..strlower(Chatr_WhoInfo[name][6]) then match=1; end
				end
				if parts[1]=="friend" and ChatrBuddies_Info~=nil and ChatrBuddies_Info[name]~=nil then match=1; end
				if match~=nil then	
					change=1;
					Chatr_Debug(name.." match line ("..line..")");
					if parts[2]=="bo" then bor,bog,bob=ChatrCrayons_HexTriplet(parts[3],bor,bog,bob); end
					if parts[2]=="bg" then bgr,bgg,bgb=ChatrCrayons_HexTriplet(parts[3],bgr,bgg,bgb); end
					if parts[2]=="boa" then if tonumber(parts[3])~=nil then boa=tonumber(parts[3]); end end
					if parts[2]=="bga" then if tonumber(parts[3])~=nil then bga=tonumber(parts[3]); end end
				end			
			end
		end
	end
	if change==1 then
		chatr:SetBackdropColor(bgr,bgg,bgb,bga);
		chatr:SetBackdropBorderColor(bor,bog,bob,boa);
	end
end

function ChatrCrayons_SetColorWrapper(tab)
	ChatrCrayons_SetColor(tab[2]);
end