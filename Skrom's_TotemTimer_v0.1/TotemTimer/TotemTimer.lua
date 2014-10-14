function TotemTimer_OnLoad()
	OLD_UseAction = UseAction
	function UseAction(ID,num)
		TotemTimerTooltip:SetAction(ID)
		local name = getglobal("TotemTimerTooltipTextLeft1"):GetText()
		TotemTimer_CheckExistingTimer(name);
		return OLD_UseAction(ID,num)
  	end
TotemTimer_Totems = { --Name.Duration, Name.School, Name.?
	["Stoneskin Totem"]={120,"Earth"},
	["Earthbind Totem"]={45,"Earth"},
	["Stoneclaw Totem"]={15,"Earth"},
	["Strength of Earth Totem"]={120,"Earth"},
	["Searing Totem"]={55,"Fire"},
	["Fire Nova Totem"]={5,"Fire"},
	["Tremor Totem"]={120,"Earth"},
	["Poison Cleansing Totem"]={120,"Water"},
	["Healing Stream Totem"]={60,"Water"},
	["Frost Resistance Totem"]={120,"Fire"},
	["Magma Totem"]={20,"Fire"},
	["Mana Spring Totem"]={60,"Water"},
	["Fire Resistance Totem"]={120,"Water"},
	["Flametongue Totem"]={120,"Fire"},
	["Grounding Totem"]={45,"Air"},
	["Nature Resistance Totem"]={120,"Air"},
	["Windfury Totem"]={120,"Air"},
	["Sentry Totem"]={300,"Air"},
	["Windwall Totem"]={120,"Air"},
	["Disease Cleansing Totem"]={120,"Water"},
	["Grace of Air Totem"]={120,"Air"},
	["Mana Tide Totem"]={12,"Water"}}
TotemTimer_Colors={["Earth"]={.38,.70,.16},["Fire"]={1.0,.20,.0},["Water"]={0,.24,1.0},["Air"]={.79,.88,1.0}}
TotemTimer_Timers={}
end

function TotemTimer_OnEvent(event)
   if (event=="VARIABLES_LOADED") then
   	  if (not TotemTimer_UserVars) then TotemTimer_UserVars = {} end

	  if (not TotemTimer_UserVars.Position) then TotemTimer_UserVars.Position = {} end

	  if (not TotemTimer_UserVars.Position.OffsX) then TotemTimer_UserVars.Position.OffsX = 200 end

	  if (not TotemTimer_UserVars.Position.OffsY) then TotemTimer_UserVars.Position.OffsY = 200 end

	  if (TotemTimer_UserVars.Position.OffsX) and (TotemTimer_UserVars.Position.OffsY) then
			DEFAULT_CHAT_FRAME:AddMessage("This is inside the if")
			TotemTimerTimers:ClearAllPoints()
			TotemTimerTimers:SetPoint("CENTER","UIParent","CENTER",TotemTimer_UserVars.Position.OffsX,TotemTimer_UserVars.Position.OffsY)
	  end
   end
end

function TotemTimer_OnMouseDown()
    if (IsControlKeyDown()) then
	    if (arg1 == "RightButton" ) then

	    else
	        this.isMoving = true;
		end
    end
end

function TotemTimer_OnMouseUp()
  if (this.isMoving) then
	    this.isMoving = false
	    TotemTimer_UserVars.Position.OffsX = this.currentX
		TotemTimer_UserVars.Position.OffsY = this.currentY
	end
end

function TotemTimer_OnUpdate()
 if (this.isMoving) then
	    local mouseX, mouseY = GetCursorPosition();
	    local centerX, centerY = UIParent:GetCenter();
	    local scale = UIParent:GetEffectiveScale();
	    mouseX = mouseX / scale;
	    mouseY = mouseY / scale;

	    local x = (mouseX - centerX);
	    local y = (mouseY - centerY);

   		this.currentX =x;
	    this.currentY =y;
	    this:SetPoint("CENTER","UIParent", "CENTER", this.currentX, this.currentY);
 end
end



function TotemTimer_CheckSpell(name)
	for k,v in pairs(TotemTimer_Totems) do
		if (name == k) then
			local duration,school = TotemTimer_Totems[name][1],TotemTimer_Totems[name][2]
			return duration,school
        end
	end
end

function TotemTimer_CheckExistingTimer(name)
	local duration,school = TotemTimer_CheckSpell(name);
 	if TotemTimer_Timers[school] then
  		TotemTimer_RemoveTimer(school)
		TotemTimer_CreateTimer(duration,school,name)
	elseif (school) then
	    TotemTimer_CreateTimer(duration,school,name)
	else return
	end
end

function TotemTimer_CreateTimer(duration,school,spellName)
	local parent,name = "TotemTimerTimers_"..school,"TotemTimerTimers_"..school.."_Duration";
	parent = getglobal(parent)
    TotemTimer_Timers[school] = CreateFrame("StatusBar",name,parent,"TotemTimerDurationTemplate")
	TotemTimer_Timers[school]:SetStatusBarColor(unpack(TotemTimer_Colors[school]));
	TotemTimer_Timers[school]:SetScript("OnUpdate",function() TotemTimer_DurationOnUpdate() end)
	TotemTimer_Timers[school]:SetMinMaxValues(0,duration)
	TotemTimer_Timers[school]:SetValue(duration)
	TotemTimer_Timers[school].Start = GetTime() ;
	TotemTimer_Timers[school].Finish = TotemTimer_Timers[school].Start + duration;
	getglobal(parent:GetName().."_Description"):SetText(spellName)
	getglobal("TotemTimerTimers_"..school):Show()
    TotemTimer_Timers[school].duration = duration
end

function TotemTimer_RemoveTimer(school)
    TotemTimer_Timers[school]:Hide()
    TotemTimer_Timers[school]:SetScript("OnUpdate",nil)
	TotemTimer_Timers[school] = nil

	getglobal("TotemTimerTimers_"..school):Hide()
end

function TotemTimer_DurationOnUpdate()

	local _,duration = this:GetMinMaxValues()
 	local Current = GetTime()
	local elapsed = (this.Finish - Current)
	this:SetValue(elapsed)
	if (this:GetValue() == 0) then
		local school = this:GetParent():GetName()
		school = string.sub(school,(string.find(school,"_") +1),(string.find(school,"_Desc")))
  TotemTimer_RemoveTimer(school)
	end
end

function TotemTimer_Icon_OnShow()
  getglobal(this:GetName().."_Icon"):SetNormalTexture(TotemTimer_ScanSpellBook(getglobal(this:GetName().."_Description"):GetText()))
end

function TotemTimer_ScanSpellBook(testName)
	local spellIndex = 1

	while true do
		local spellName = GetSpellName(spellIndex,BOOKTYPE_SPELL)

		if spellName == testName then
	    	local spellId = spellIndex
			local texture = GetSpellTexture(spellIndex,BOOKTYPE_SPELL)

			return texture
    	end

		if not(spellName) then
	    	do break end
		end
	 	spellIndex = spellIndex+1
	end
end