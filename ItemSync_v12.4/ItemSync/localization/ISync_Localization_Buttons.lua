--[[--------------------------------------------------------------------------------
  ItemSync Localization GUI Buttons

  Author:  Derkyle
  Website: http://www.manaflux.com
  
-----------------------------------------------------------------------------------]]


--[[--------------------------------------------------------------------------------

		EXAMPLES:
		
		You can call the button or object by name like this
		
			ISyncMainFrame_ButtonFrameRefreshButton:GetWidth();
		
		or you can globally call it like this:
		
			(NOTE: It's best you do it this way to prevent nil errors!!)

			getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):GetWidth();
		
		
		HOW TO SET WIDTH:
		
			local getButtonWidth = getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):GetWidth();

			You can do this:

				getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetWidth(getButtonWidth);

			or you can do this:

				getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetWidth(getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):GetWidth());


		HOW TO SET HEIGHT:
		
			local getButtonHeight = getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):GetHeight();

			You can do this:

				getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetHeight(getButtonHeight);

			or you can do this:

				getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetHeight(getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):GetHeight());



		
		HOW TO SET A POSITION
			
			Remember to ClearAllPoints first before you do this!
		
			getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):ClearAllPoints();
			getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetPoint("LEFT", ISyncMainFrame_ButtonFrame, "LEFT", x, y);
					
				
			Lets break it down:
				SetPoint(arg1, arg2, arg3, arg4, arg5);
			
				First you need to know what position you can use:
				
				"LEFT", "RIGHT", "CENTER", "BOTTOM", "TOPRIGHT", "TOPLEFT", "BOTTOMRIGHT", "BOTTOMLEFT"
				(There are other ones but I recommend you use those that are listed above).
			
				
				The arguements:
				
				arg1 = Position from the top most layer, you can set this to any of the above methods. Remember to put it in quotes like this "TOP"
				
				arg2 = The frame your going to use to set the object in.  It's always best to use the frame the object is located in.
				
				arg3 = Position from the bottom most layer, you can set this to any of the above methods. Remember to put it in quotes like this "TOP"
				
				arg4 = The X position for the layers you have set, example "LEFT", "TOP", etc..
				
				arg5 = The Y position for the layers you have set, example "LEFT", "TOP", etc..
				
				
				NOTE: For X and Y you CAN use negative numbers if you want.  Your going to have to play around with them till you get what you want :)
				
				
				
			Here is a final example:
			
			getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetPoint("LEFT", ISyncMainFrame_ButtonFrame, "LEFT", 0, -40);
			
			
			
			
		HOW TO SHOW/HIDE AN OBJECT:
		
			getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):Show();
			getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):Hide();
			
			
		
		FINALLY!!! WARNING!!
		
		Don't forget to end every line with ; or else you will generate an error!
		Don't forget to open and close ()!
		Don't forget to use : !
		Don't forget to ClearAllPoints (IF YOUR ARE MOVING SOMETHING ONLY!!!)
			
				
-----------------------------------------------------------------------------------]]







---------------------------------------------------
-- ISync_AlterGUI
---------------------------------------------------
function ISync_AlterGUI()


	--french
	if ( GetLocale() == "frFR" ) then


		--Example:

		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetHeight(12);
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetWidth(14);

		
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):ClearAllPoints();
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetPoint("LEFT", ISyncMainFrame_ButtonFrame, "LEFT", 0, -40);
			
			

	--german
	elseif ( GetLocale() == "deDE" ) then

		--Example:

		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetHeight(12);
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetWidth(14);

		
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):ClearAllPoints();
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetPoint("LEFT", ISyncMainFrame_ButtonFrame, "LEFT", 0, -40);
					
				

	--english
	else



		--Example:

		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetHeight(12);
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetWidth(14);

		
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):ClearAllPoints();
		--getglobal("ISyncMainFrame_ButtonFrameRefreshButton"):SetPoint("LEFT", ISyncMainFrame_ButtonFrame, "LEFT", 0, -40);
			

	end



end