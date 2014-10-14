--TrainerSkills made by Razzer (http://wow.pchjaelp.dk)

function TrainerSkillsConfig_CB_Notify_GetState()
	return TrainerSkillsVar.tsNotify;
end

function TrainerSkillsConfig_CB_Notify_SetState(value)
	TrainerSkillsVar.tsNotify = value;
end

function TrainerSkillsConfig_CB_MinimapButton_GetState()
	return TrainerSkillsVar.mmb;
end

function TrainerSkillsConfig_CB_MinimapButton_SetState(value)
	TrainerSkillsMinimapButton_Toggle();
end

function TrainerSkillsConfig_CB_MinimapButtonMoveable_GetState()
	return TrainerSkillsVar.mmbMov;
end

function TrainerSkillsConfig_CB_MinimapButtonMoveable_SetState(value)
	TrainerSkillsVar.mmbMov = value;
end

function TrainerSkillsConfig_CB_GrapToolTips_GetState()
	return TrainerSkillsVar.grabTooltips;
end

function TrainerSkillsConfig_CB_GrapToolTips_SetState(value)
	TrainerSkillsVar.grabTooltips = value;
end

function TrainerSkillsConfig_CB_GrapDescription_GetState()
	return TrainerSkillsVar.grabDescription;
end

function TrainerSkillsConfig_CB_GrapDescription_SetState(value)
	TrainerSkillsVar.grabDescription = value;
end

function TrainerSkillsConfig_CB_GrabNpcNamesAndLocations_GetState()
	return TrainerSkillsVar.grabNpcNamesAndLocations;
end

function TrainerSkillsConfig_CB_GrabNpcNamesAndLocations_SetState(value)
	TrainerSkillsVar.grabNpcNamesAndLocations = value;
end

function TrainerSkillsConfig_CB_SavePlayerSkills_GetState()
	return TrainerSkillsVar.savePlayerSkills;
end

function TrainerSkillsConfig_CB_SavePlayerSkills_SetState(value)
	TrainerSkillsVar.savePlayerSkills = value;
end

function TrainerSkillsConfig_CB_TrainerFilter_GetState()
	return TrainerSkillsVar.saveTrainerFilter;
end

function TrainerSkillsConfig_CB_TrainerFilter_SetState(value)
	TrainerSkillsVar.saveTrainerFilter = value;
end