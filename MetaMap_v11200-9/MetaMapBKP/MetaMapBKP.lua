-- MetaMapBKP (Backup & Restore module for MetaMap)
-- Written by MetaHawk - aka Urshurak

local info;

function MetaMapBKP_Init(mode)
	info = "";
	if(mode == "backup") then
		if(BKP_Check_NoteData:GetChecked()) then
			MetaMapBKP_BackupNotes();
		end
		if(BKP_Check_WKBdata:GetChecked()) then
			if(not IsAddOnLoaded("MetaMapWKB")) then
				LoadAddOn("MetaMapWKB");
			end
			if(IsAddOnLoaded("MetaMapWKB")) then
				MetaMapBKP_BackupWKB();
			else
				info = info.."\nMetaMapWKB: |cffff0000"..METAMAP_NOMODULE.."|r";
			end
		end
		if(BKP_Check_QSTdata:GetChecked()) then
			if(not IsAddOnLoaded("MetaMapQST")) then
				LoadAddOn("MetaMapQST");
			end
			if(IsAddOnLoaded("MetaMapQST")) then
				MetaMapBKP_BackupQST();
			else
				info = info.."\nMetaMapQST: |cffff0000"..METAMAP_NOMODULE.."|r";
			end
		end
	else
		if(BKP_Check_NoteData:GetChecked()) then
			MetaMapBKP_RestoreNotes();
		end
		if(BKP_Check_WKBdata:GetChecked()) then
			if(not IsAddOnLoaded("MetaMapWKB")) then
				LoadAddOn("MetaMapWKB");
			end
			if(IsAddOnLoaded("MetaMapWKB")) then
				MetaMapBKP_RestoreWKB();
			else
				info = info.."\nMetaMapWKB: |cffff0000"..METAMAP_NOMODULE.."|r";
			end
		end
		if(BKP_Check_QSTdata:GetChecked()) then
			if(not IsAddOnLoaded("MetaMapQST")) then
				LoadAddOn("MetaMapQST");
			end
			if(IsAddOnLoaded("MetaMapQST")) then
				MetaMapBKP_RestoreQST();
			else
				info = info.."\nMetaMapQST: |cffff0000"..METAMAP_NOMODULE.."|r";
			end
		end
	end
	MetaMap_OptionsInfo:SetText(info);
	BKP_Check_NoteData:SetChecked(0);
	BKP_Check_WKBdata:SetChecked(0);
	BKP_Check_QSTdata:SetChecked(0);
end

function MetaMapBKP_BackupNotes()
	BKP_MetaMapNotes_Data = {};
	BKP_MetaMapNotes_Lines = {};
	BKP_MetaMapNotes_Data = MetaMapNotes_Data;
	BKP_MetaMapNotes_Lines = MetaMapNotes_Lines;
	info = info.."\nMetaMap Notes: |cff00ff00"..METAMAPBKP_BACKUP_DONE.."|r";
end

function MetaMapBKP_BackupWKB()
	BKP_MetaKB_Data = {};
	BKP_MetaKB_Data = MetaKB_Data;
	info = info.."\nMetaMapWKB: |cff00ff00"..METAMAPBKP_BACKUP_DONE.."|r";
end

function MetaMapBKP_BackupQST()
	BKP_QST_QuestBase = {};
	BKP_QST_QuestBase = QST_QuestBase;
	info = info.."\nMetaMapQST: |cff00ff00"..METAMAPBKP_BACKUP_DONE.."|r";
end

function MetaMapBKP_RestoreNotes()
	if(BKP_MetaMapNotes_Data ~= nil) then
		MetaMapNotes_Data = {};
		MetaMapNotes_Data = BKP_MetaMapNotes_Data;
		info = "MetaMap Notes: |cff00ff00"..METAMAPBKP_RESTORE_DONE.."|r";
	else
		info = "MetaMap Notes: |cffff0000"..METAMAPBKP_RESTORE_FAIL.."|r";
	end
	if(BKP_MetaMapNotes_Lines ~= nil) then
		MetaMapNotes_Lines = {};
		MetaMapNotes_Lines = BKP_MetaMapNotes_Lines;
	end
end

function MetaMapBKP_RestoreWKB()
	if(BKP_MetaKB_Data[MetaKB_dbID] ~= nil) then
		MetaKB_Data = {};
		MetaKB_Data[MetaKB_dbID] = {};
		MetaKB_Data[MetaKB_dbID] = BKP_MetaKB_Data[MetaKB_dbID];
		info = info.."\nMetaMapWKB: |cff00ff00"..METAMAPBKP_RESTORE_DONE.."|r";
	else
		info = info.."\nMetaMapWKB: |cffff0000"..METAMAPBKP_RESTORE_FAIL.."|r";
	end
end

function MetaMapBKP_RestoreQST()
	if(BKP_QST_QuestBase ~= nil) then
		QST_QuestBase = {};
		QST_QuestBase = BKP_QST_QuestBase;
		info = info.."\nMetaMapQST: |cff00ff00"..METAMAPBKP_RESTORE_DONE.."|r";
	else
		info = info.."\nMetaMapQST: |cffff0000"..METAMAPBKP_RESTORE_FAIL.."|r";
	end
end
