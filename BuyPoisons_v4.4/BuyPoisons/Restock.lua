function BuyPoisons_RestockPoisons()

	BuyPoisonsRestock={};
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_FLASH_POWDER] = 0;
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_DEATHWEED] = 0;
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_DUST_OF_DECAY] = 0;
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_DUST_OF_DETERIORATION] = 0;
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_ESSENCE_OF_AGONY] = 0;
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_ESSENCE_OF_PAIN] = 0;
	BuyPoisonsRestock[BUYPOISONS_COMPONENT_LETHARGY_ROOT] = 0;
	BuyPoisonsRestock[BUYPOISONS_VIAL_EMPTY] = 0;
	BuyPoisonsRestock[BUYPOISONS_VIAL_CRYSTAL] = 0;
	BuyPoisonsRestock[BUYPOISONS_VIAL_LEADED] = 0;

	BuyPoisonsComponents = {};
	BuyPoisonsComponents[1]=BUYPOISONS_VIAL_EMPTY;
	BuyPoisonsComponents[2]=BUYPOISONS_VIAL_CRYSTAL;
	BuyPoisonsComponents[3]=BUYPOISONS_VIAL_LEADED;
	BuyPoisonsComponents[4]=BUYPOISONS_COMPONENT_FLASH_POWDER;
	BuyPoisonsComponents[5]=BUYPOISONS_COMPONENT_DEATHWEED;
	BuyPoisonsComponents[6]=BUYPOISONS_COMPONENT_DUST_OF_DECAY;
	BuyPoisonsComponents[7]=BUYPOISONS_COMPONENT_DUST_OF_DETERIORATION;
	BuyPoisonsComponents[8]=BUYPOISONS_COMPONENT_ESSENCE_OF_AGONY;
	BuyPoisonsComponents[9]=BUYPOISONS_COMPONENT_ESSENCE_OF_PAIN;
	BuyPoisonsComponents[10]=BUYPOISONS_COMPONENT_LETHARGY_ROOT;


	for i = 1, 21 do
			local VialType = BuyPoisonsItemInfo[i]["Vial_Type"];
			local RestockQuantity = BuyPoisonsData[Server][User][i];
			if (RestockQuantity > 0) then
				BuyPoisonsRestock[(BuyPoisonsItemInfo[i]["Components"][1]["Item"])]=BuyPoisonsRestock[(BuyPoisonsItemInfo[i]["Components"][1]["Item"])] + (BuyPoisonsItemInfo[i]["Components"][1]["Quantity"] * RestockQuantity);
				if (BuyPoisonsItemInfo[i]["Components"][2]["Item"]) then
					BuyPoisonsRestock[(BuyPoisonsItemInfo[i]["Components"][2]["Item"])]=BuyPoisonsRestock[(BuyPoisonsItemInfo[i]["Components"][2]["Item"])] + (BuyPoisonsItemInfo[i]["Components"][2]["Quantity"] * RestockQuantity);
				end
				BuyPoisonsRestock[VialType] = BuyPoisonsRestock[VialType] + RestockQuantity;
			end
	end
	
	for i = 1, 10 do
		BuyPoisons_RestockItem( BuyPoisonsComponents[i] , BuyPoisonsRestock[(BuyPoisonsComponents[i])]);
	end
	
end
