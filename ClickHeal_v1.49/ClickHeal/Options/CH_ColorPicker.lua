--=============================================================================
-- File:	CH_ColorPicker.lua
-- Author:	rudy
-- Description:	Named Colors
--=============================================================================

function CH_ColorPickerOnLoad()

  local color;

  for color,_ in CH_COLOR do
    if ( getglobal('CH_ColorPicker'..color) ) then
      getglobal('CH_ColorPicker'..color..'Label'):SetText( CH_COLOR[color].name );
      getglobal('CH_ColorPicker'..color..'Background'):SetTexture( CH_COLOR[color].r, CH_COLOR[color].g, CH_COLOR[color].b );
      getglobal('CH_ColorPicker'..color).colorPickerColor = color;
    end
  end

end

function CH_ColorPickerColorClicked( color )

  ColorPickerFrame:SetColorRGB( CH_COLOR[color].r, CH_COLOR[color].g, CH_COLOR[color].b );

end
