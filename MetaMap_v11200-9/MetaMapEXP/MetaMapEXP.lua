-- MetaMap Export Module
-- Written by MetaHawk aka Urshurak

MMEXP_USERKB = "UserKB";
MMEXP_USERNOTES = "UserNotes";
MMEXP_USERQST = "UserQST";

local KBcount = 0;
local Notecount = 0;
local QSTcount = 0;

function MetaMapEXP_CheckData()
	MetaMap_OptionsInfo:SetText("MetaMap Exports module loaded");
	MetaMap_ConfirmationHeader:SetText(METAMAPBLT_CONFIRM_EXPORT);
	MetaMap_SelectionButton1:SetText(MMEXP_USERKB);
	MetaMap_SelectionButton2:SetText(MMEXP_USERNOTES);
	MetaMap_SelectionButton3:SetText(MMEXP_USERQST);
	if(not IsAddOnLoaded("MetaMapWKB")) then
		LoadAddOn("MetaMapWKB");
	end
	if(not IsAddOnLoaded("MetaMapWKB")) then
		MetaMap_SelectionButton1:Disable();
	end
	if(not IsAddOnLoaded("MetaMapQST")) then
		LoadAddOn("MetaMapQST");
	end
	if(not IsAddOnLoaded("MetaMapQST")) then
		MetaMap_SelectionButton3:Disable();
	end
	MetaMap_ConfirmationDialog:Show();
end

function MetaMap_SelectedExport(mode)
	local msg = ""; KBcount = 0; Notecount = 0;
	if(mode == MMEXP_USERKB) then
		MyNotes_Data = nil;
		MyLines_Data = nil;
		MetaMap_ExportQST = nil;
		MetaMap_ExportKB();
		msg = format(METAMAPEXP_KB_EXPORTED, KBcount);		
	elseif(mode == MMEXP_USERNOTES) then
		MyKB_Data = nil;
		MetaMap_ExportQST = nil;
		MetaMap_ExportMetaNotes();
		msg = format(METAMAPEXP_NOTES_EXPORTED, Notecount);		
	elseif(mode == MMEXP_USERQST) then
		MyNotes_Data = nil;
		MyLines_Data = nil;
		MyKB_Data = nil;
		MetaMap_ExportQST();
		msg = format(METAMAPEXP_QST_EXPORTED, QSTcount);		
	end
	MetaMap_ConfirmationDialog:Hide();
	MetaMap_OptionsInfo:SetText(msg);
end

function MetaMap_ExportKB()
	MyKB_Data = {};
	MyKB_Data[MetaKB_dbID] = {};
	for name, zone in pairs(MetaKB_Data[MetaKB_dbID]) do
		MyKB_Data[MetaKB_dbID][name] = MetaKB_Data[MetaKB_dbID][name];
		KBcount = KBcount +1;
	end
end

function MetaMap_ExportMetaNotes()
	MyNotes_Data = {};
	MyLines_Data = {};
	for continent=1, MetaMap_TableSize(MetaMap_Continents)-1, 1 do
		MyNotes_Data[continent] = {};
		for zone, zoneTable in pairs(MetaMapNotes_Data[continent]) do
			MyNotes_Data[continent][zone] = {};
			for i, value in pairs(MetaMapNotes_Data[continent][zone]) do
				MyNotes_Data[continent][zone][i] = MetaMapNotes_Data[continent][zone][i];
				Notecount = Notecount +1;
			end
		end
	end
	for continent=1, MetaMap_TableSize(MetaMap_Continents)-1, 1 do
		MyLines_Data[continent] = {};
		for zone, zoneTable in pairs(MetaMapNotes_Lines[continent]) do
			MyLines_Data[continent][zone] = {};
			for i, value in pairs(MetaMapNotes_Lines[continent][zone]) do
				MyLines_Data[continent][zone][i] = MetaMapNotes_Lines[continent][zone][i];
			end
		end
	end
end

function MetaMap_ExportQST()
	MyQST_QuestBase = {};
	for index, quest in pairs(QST_QuestBase) do
		MyQST_QuestBase[index] = QST_QuestBase[index];
		QSTcount = QSTcount +1;
	end
end

