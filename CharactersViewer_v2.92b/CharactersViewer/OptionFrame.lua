CHARACTERSVIEWER_OPTION_ORDER = { "Scaling", "MovableBankFrame", "MovableMainFrame" };


CHARACTERSVIEWER_OPTIONS.Scaling.PARAM			= "Scaling";
CHARACTERSVIEWER_OPTIONS.Scaling.DEFAULT = true;
CHARACTERSVIEWER_OPTIONS.Scaling.CALLBACK	= nil;

CHARACTERSVIEWER_OPTIONS.MovableBankFrame.PARAM		= "MovableBankFrame";
CHARACTERSVIEWER_OPTIONS.MovableBankFrame.DEFAULT = true;
CHARACTERSVIEWER_OPTIONS.MovableBankFrame.CALLBACK	= "CharactersViewer_BankFrame_isMovable";

CHARACTERSVIEWER_OPTIONS.MovableMainFrame.PARAM		= "MovableMainFrame";
CHARACTERSVIEWER_OPTIONS.MovableMainFrame.DEFAULT = true;
CHARACTERSVIEWER_OPTIONS.MovableMainFrame.CALLBACK	= "CharactersViewer_CharacterFrame_isMovable";




if ( CharactersViewer.OptionFrame == nil ) then
	CharactersViewer.OptionFrame = {};
end

CharactersViewer.OptionFrame.CheckButton = {};

function CharactersViewer.OptionFrame.CheckButton.OnClick(button)
	local checked;
	if ( button:GetChecked() == nil ) then
		checked = false;
	else
		checked = true;
	end
	CharactersViewer.Api.SetConfig( CharactersViewer.OptionFrame.GetOption( button:GetID(), "PARAM"), checked );
	if ( CharactersViewer.OptionFrame.GetOption( button:GetID(), "CALLBACK") ~= nil ) then
		getglobal (CharactersViewer.OptionFrame.GetOption( button:GetID(), "CALLBACK"))();
	end
end

function CharactersViewer.OptionFrame.GetOption(id, param, full)
	if ( tonumber(id) == id ) then
		-- number
		id = CHARACTERSVIEWER_OPTION_ORDER[id]
	else
		-- param is already a string
	end
	
	if ( full ~= nil and full == true ) then
		return CHARACTERSVIEWER_OPTIONS[id];
	else
		return CHARACTERSVIEWER_OPTIONS[id][param];
	end
end

function CharactersViewer.OptionFrame.ReDraw()
	for id in CHARACTERSVIEWER_OPTION_ORDER do
		getglobal("CVCheckOption" .. id):SetChecked(  CharactersViewer.Api.GetConfig( CharactersViewer.OptionFrame.GetOption(id, "PARAM" )) );
	end
end

function CharactersViewer.OptionFrame.Default()
	for id in CHARACTERSVIEWER_OPTION_ORDER do
		if (CharactersViewer.Api.GetConfig( CharactersViewer.OptionFrame.GetOption(id, "PARAM" )) == nil ) then
			CharactersViewer.Api.SetConfig( CharactersViewer.OptionFrame.GetOption(id, "PARAM" ), CharactersViewer.OptionFrame.GetOption(id, "DEFAULT" ));
		end
	end
end

function CharactersViewer.OptionFrame.Apply()
	for id in CHARACTERSVIEWER_OPTION_ORDER do
		if (CharactersViewer.Api.GetConfig( CharactersViewer.OptionFrame.GetOption(id, "PARAM" )) == nil ) then
			getglobal (CharactersViewer.OptionFrame.GetOption( id, "CALLBACK"))();
		end
	end
end
