local ActionButton_OnUpdate_Old = ActionButton_OnUpdate;

function ActionButton_OnUpdate(elapsed) 
   local changeRange = false;
   if (this.rangeTimer) then
      -- Handle range indicator red out
      if ( this.rangeTimer <= elapsed ) then
	 local newRange = nil;
	 if ( IsActionInRange( ActionButton_GetPagedID(this) ) == 0) then
	    newRange = true;
	 end
	 if (this.redRangeFlag ~= newRange) then
	    this.redRangeFlag = newRange;
	    changeRange = true;
	 end
      end
   end

   ActionButton_OnUpdate_Old(elapsed);

   if (changeRange) then
      ActionButton_UpdateUsable();
   end
end

local ActionButton_UpdateUsable_Old = ActionButton_UpdateUsable;

function ActionButton_UpdateUsable()
   ActionButton_UpdateUsable_Old();

   local id = ActionButton_GetPagedID(this);
   local isUsable, notEnoughMana = IsUsableAction(id)
   if (IsActionInRange(id) == 0) then
      if (isUsable) then
	 local name = this:GetName();
	 local icon = getglobal(name.."Icon");
	 local normalTexture = getglobal(name.."NormalTexture");

	 icon:SetVertexColor(0.8, 0.1, 0.1);
	 normalTexture:SetVertexColor(0.8, 0.1, 0.1);
	 return;
      end
   end

   if ((not isUsable) and notEnoughMana) then
      local name = this:GetName();
      local icon = getglobal(name.."Icon");
      local normalTexture = getglobal(name.."NormalTexture");
      
      icon:SetVertexColor(0.1, 0.3, 1.0);
      normalTexture:SetVertexColor(0.1, 0.3, 1.0);
      return;
   end

end
