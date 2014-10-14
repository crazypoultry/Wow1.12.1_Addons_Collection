--[[

FilterKnown v1.2 Rev

by Zyph

All Copyrights to Merrem.

--]]

FILTERKNOWN_VERSION = "1.2";

AlreadyKnown_ORIG_AuctionFrameBrowse_Update = nil;

SLASH_FILTERKNOWN1 = "/fk";
SLASH_FILTERKNOWN2 = "/filterknown";
SlashCmdList["FILTERKNOWN"] = function(msg)
FilterKnown_SlashCommand(msg);
end

function FilterKnown_Update()

	-- Do original update.
	if ( AlreadyKnown_ORIG_AuctionFrameBrowse_Update ) then
		AlreadyKnown_ORIG_AuctionFrameBrowse_Update();
	end

	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
	local index;
	local line;

	for i=1, NUM_BROWSE_TO_DISPLAY do
		index = offset + i;

		FilterKnownTooltip:SetAuctionItem("list", index);

		if ( FilterKnownTooltip:NumLines() > 2 and string.find(FilterKnownTooltipTextLeft3:GetText(), ITEM_SPELL_KNOWN) ) then
			line = FilterKnownTooltipTextLeft3:GetText();
		elseif ( FilterKnownTooltip:NumLines() > 2 ) then
			line = FilterKnownTooltipTextLeft4:GetText();
		else
			line = nil;
		end

		if line and string.find(line, ITEM_SPELL_KNOWN) then

			iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");

			if FilterKnown.color == "green" then
				iconTexture:SetVertexColor(0.1, 1.0, 0.1);
					        	 -- r,   g,   b 
			elseif FilterKnown.color == "blue" then
				iconTexture:SetVertexColor(0.1, 0.1, 1.0);
					        	 -- r,   g,   b 
			elseif FilterKnown.color == "red" then
				iconTexture:SetVertexColor(1.0, 0.1, 0.1);
					        	 -- r,   g,   b 
			elseif FilterKnown.color == "gray" then
				iconTexture:SetVertexColor(0.4, 0.4, 0.4);

			elseif FilterKnown.color == "black" then
				iconTexture:SetVertexColor(0, 0, 0);

			else
				iconTexture:SetVertexColor(0.1, 1.0, 0.1);
					        	 -- r,   g,   b 
			end
		end
			
	end
end

function FilterKnown_OnLoad()
	AlreadyKnown_ORIG_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
	AuctionFrameBrowse_Update = FilterKnown_Update;

	if (FilterKnown == nil) then
    		FilterKnown = {};
  	end 

	if (FilterKnown.color == nil) then
   		FilterKnown.color = "green";
  	end
end

function FilterKnown_SlashCommand(msg)
	if msg == "green" then
		FilterKnown.color = "green";
		DEFAULT_CHAT_FRAME:AddMessage(FILTERKNOWN_SETGREEN);
	elseif msg == "red" then
		FilterKnown.color = "red";
		DEFAULT_CHAT_FRAME:AddMessage(FILTERKNOWN_SETRED);
	elseif msg == "blue" then
		FilterKnown.color = "blue";
		DEFAULT_CHAT_FRAME:AddMessage(FILTERKNOWN_SETBLUE);
	elseif msg == "gray" then
		FilterKnown.color = "gray";
		DEFAULT_CHAT_FRAME:AddMessage(FILTERKNOWN_SETGRAY);
	elseif msg == "black" then
		FilterKnown.color = "black";
		DEFAULT_CHAT_FRAME:AddMessage(FILTERKNOWN_SETBLACK);
	else
		DEFAULT_CHAT_FRAME:AddMessage(FILTERKNOWN_HELPMSG);
	end
end