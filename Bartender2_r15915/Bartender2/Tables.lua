local _G = getfenv(0)

AllActionButtons = {}
for ii=1,12 do for i=1,5 do table.insert(AllActionButtons, _G["Bar"..i.."Button"..ii]) end end

AllButtons = {}
for ii=1,12 do for i=1,5 do table.insert(AllButtons, _G["Bar"..i.."Button"..ii]) end end
for ii=1,10 do for i=6,7 do table.insert(AllButtons, _G["Bar"..i.."Button"..ii]) end end
for i=1,5  do table.insert(AllButtons, _G["Bar8Button"..i]) end
for i=1,8  do table.insert(AllButtons, _G["Bar9Button"..i]) end

AllIcons = {}
for ii=1,12 do for i=1,5 do table.insert(AllIcons, _G["Bar"..i.."Button"..ii.."Icon"]) end end
for ii=1,10 do for i=6,7 do table.insert(AllIcons, _G["Bar"..i.."Button"..ii.."Icon"]) end end
for i=1,5  do table.insert(AllIcons, _G["Bar8Button"..i.."Icon"]) end

AllNormalTextures = {}
for ii=1,12 do for i=1,5 do table.insert(AllNormalTextures, _G["Bar"..i.."Button"..ii.."NT"]) end end
for ii=1,10 do for i=6,7 do table.insert(AllNormalTextures, _G["Bar"..i.."Button"..ii.."NT"]) end end
for i=1, 5 do table.insert(AllNormalTextures, _G["Bar8Button"..i.."NT"]) end

AllBars = {}
for i=1,9 do table.insert(AllBars, _G["Bar"..i]) end