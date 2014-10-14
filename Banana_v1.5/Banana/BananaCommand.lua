BananaConfig = 
{
	OnCommand = function(command)
		if not BananaConfigFrame:IsVisible() then
			BananaConfigFrame:Show();
		end
	end
}