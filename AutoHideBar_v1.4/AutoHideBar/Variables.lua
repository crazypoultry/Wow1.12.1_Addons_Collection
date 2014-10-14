-- Variables

AHB_Save = {}

function AutoHideBar_Init()
	if (not AHB_Save.locked) then 
		AHB_Save.locked = false;
	end

	if (not AHB_Save.showincombat) then
		AHB_Save.showincombat = false;
	end

	if (not AHB_Save.incombat) then
		AHB_Save.incombat = false;
	end

	if (not AHB_Save.key) then
		AHB_Save.key = "empty";
	end

	if (not AHB_Save.bindingkey) then
		AHB_Save.bindingkey = "none";
	end
	
	if (not AHB_Save.scale) then
		AHB_Save.scale = 1;
	end
	
	if (not AHB_Save.bag) then
		AHB_Save.bag = "MEDIUM";
	end
	
	if (not AHB_Save.Close) then
		AHB_Save.Close = false
	end
		
	-- Default ButtonID settings	
	
	if (not AHB_Save.buttonid) then
		AHB_Save.buttonid = {
		85,86,87,88,89,
		90,91,92,93,94,
		95,96,97,98,99,
		100,101,102,103,104};
	end
	
	if (not AHB_Save.button) then
		AHB_Save.button = 1;
	end
end