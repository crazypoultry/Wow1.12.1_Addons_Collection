function EDB_Frame_Options_OnLoad()

end

function EDB_Frame_Options_Scan()

	EDB_RunInEnchantFrame(EDB_CSI_Formula_Build);

end

function EDB_Frame_Options_ValueUpdate()

	EDB_CSI_ReagentValue_Build();
	EDB_Frame_Enchant_EnchantList_CostUpdate();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_ReagentList_Update();
	EDB_Frame_Reagent_ReagentList_Update();

end
