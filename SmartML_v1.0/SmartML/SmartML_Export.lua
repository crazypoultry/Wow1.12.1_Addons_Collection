function SL_GenerateExportData()
	local text = "";
	for _,entry in SL_LOG[SL_LOG_VIEW] do
		local pool = "N/A";
		local bid = 0;
		if (entry.pool) then
			pool = entry.pool;
		end
		if (entry.bid) then
			bid = entry.bid;
		end
		local s = entry.item.name..";"..entry.player..";"..pool..";"..bid..";\n";
		text = text .. s;
	end
	SL_ExportEditBox:SetText(text);
end