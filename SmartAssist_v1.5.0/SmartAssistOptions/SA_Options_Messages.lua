function SA_Options_Messages_OnShow()
	SAVerboseAssistCB:SetChecked(SA_OPTIONS.VerboseAssist);
	SAVerboseIncomingCB:SetChecked(SA_OPTIONS.VerboseIncoming);
	SAVerboseNearestCB:SetChecked(SA_OPTIONS.VerboseNearest);
	SAVerboseUnableToAssistCB:SetChecked(SA_OPTIONS.VerboseUnableToAssist);
	
	SAAudioWarningCB:SetChecked(SA_OPTIONS.AudioWarning);
	SALostAudioWarningCB:SetChecked(SA_OPTIONS.LostAudioWarning);
	SAIncomingWBAudioWarningCB:SetChecked(SA_OPTIONS.IncomingWBAudioWarning);
	
	SAVerboseAcquiredAggroCB:SetChecked(SA_OPTIONS.VerboseAcquiredAggro);
	SAVerboseLostAggroCB:SetChecked(SA_OPTIONS.VerboseLostAggro);
	SAVerboseIncomingWBCB:SetChecked(SA_OPTIONS.VerboseIncomingWB);
end