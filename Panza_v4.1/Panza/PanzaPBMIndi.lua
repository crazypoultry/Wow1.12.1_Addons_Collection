--[[

PanzaPBMIndi.lua
Panza PBMIndi (Panza Buff Module, individual buffs) Dialog
Revision 4.1

]]

local SelectedEntry = 1;

function PA:PBMIndi_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
	scrollBarPanzaPBMIndi:Show()
end

function PA:PBMIndi_OnShow()
	PA:Reposition(PanzaPBMIndiFrame, "UIParent", true);
	PanzaPBMIndiFrame:SetAlpha(PASettings.Alpha);
	PA:PBMIndi_SetValues();
end

function PA:PBMIndi_SetValues()
	SelectedEntry = 1;
	Panza_IndiScrollBar_Update();
end

function PA:PBMIndi_OnHide()
	-- place holder
end

function PA:PBMIndi_btnDone_OnClick()
	PA:FrameToggle(PanzaPBMIndiFrame);
end

function PA:PBMIndi_btnDelete_OnClick()
	local IndiTable = PA:GetIndiSavedListIndexed();
	local Name = IndiTable[SelectedEntry];
	--PA:ShowText("Deleting Id=", SelectedEntry, " Name=", Name);
	if (Name~=nil) then
		PASettings.BlessList[Name] = nil;
		PA:PBMIndi_SetValues();
	end
end

function PA:PBMIndi_btnClearAll_OnClick()
	PA:BlessList("clearall");
	PA:PBMIndi_SetValues();
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PBMIndi_ShowTooltip(item)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine(PA.PBMIndi_Tooltips[item:GetName()].tooltip1);
	GameTooltip:AddLine(PA.PBMIndi_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1);
	GameTooltip:Show();
end

function Panza_IndiScrollBar_Update()
	if (PA:TableSize(PASettings.BlessList)<2) then
		FauxScrollFrame_Update(scrollBarPanzaPBMIndi, 16, 16, 1);
		PanzaIndiEntry1ButtonTextName:SetText("None Set");
		PanzaIndiEntry1ButtonTextClass:SetText("");
		PanzaIndiEntry1ButtonTextBuff:SetText("");
		PanzaIndiEntry1:Show();
		for Entry = 2, 16 do
			getglobal("PanzaIndiEntry"..Entry):Hide();
		end
		PanzaIndiEntry1:Disable();
		btnPanzaPBMIndiDelete:Disable();
		btnPanzaPBMIndiClearAll:Disable();
		return;
	end
	PanzaIndiEntry1:Enable();
	btnPanzaPBMIndiDelete:Enable();
	btnPanzaPBMIndiClearAll:Enable();
	local IndiTable = PA:GetIndiSavedListIndexed();
	local IndiCount = getn(IndiTable);
	--PA:ShowText("IndiCount = ", IndiCount);
	txtPanzaPBMIndiCount:SetText("Saved Individual Buff Count: "..IndiCount);
	FauxScrollFrame_Update(scrollBarPanzaPBMIndi, math.max(IndiCount, 16), 16, 16);
	local Offset = FauxScrollFrame_GetOffset(scrollBarPanzaPBMIndi);
	-- If selected is off screen then reset to top
	if (SelectedEntry<=Offset or SelectedEntry>Offset+16) then
		SelectedEntry = Offset + 1;
	end
	for Entry = 1, 16 do
		local Button = getglobal("PanzaIndiEntry"..Entry);
		local Index = Entry + Offset;
		--PA:ShowText("Entry=", Entry, " Index=", Index);
		if Index <= IndiCount then
			local Name = IndiTable[Index];
			getglobal("PanzaIndiEntry"..Entry.."ButtonTextName"):SetText(Name);
			local ClassText = getglobal("PanzaIndiEntry"..Entry.."ButtonTextClass"); 
			local ClassLoc = PASettings.BlessList[Name].ClassLoc;
			if (ClassLoc==nil) then
				ClassLoc = "";
			else
				ClassText:SetTextColor(.4, .4, .8);
			end
			ClassText:SetText(ClassLoc);
			local Buff = PA:GetSpellProperty(PASettings.BlessList[Name].Spell, "Name");
			if (Buff==nil) then
				Buff = "";
			end
			getglobal("PanzaIndiEntry"..Entry.."ButtonTextBuff"):SetText(Buff);
			if (Index==SelectedEntry) then
				Button:LockHighlight();
			else
				Button:UnlockHighlight();
			end
			Button:Show();
		else
			Button:Hide();
		end
	end
	
	function PanzaIndiEntry_OnClick()
		SelectedEntry = this:GetID() + FauxScrollFrame_GetOffset(scrollBarPanzaPBMIndi);
		Panza_IndiScrollBar_Update();
	end
	
end