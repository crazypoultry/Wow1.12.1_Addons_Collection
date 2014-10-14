---------------------------------------------------------------
-- OZ Raid sort function
-- The earlier stages have filled in 'OZ_Input' with the data
-- to display, and the sort routines set a weight for each entry.
--
-- This function then builds the [weight,index] data for the sort,
-- runs the sort, and then builds the bar data for this window
---------------------------------------------------------------
OZ_SortMap = {};

function OZ_InitSortTable(n)
	local i
	for i = 1,n do
		OZ_SortMap[i*2] = i
	end
end

function OZ_DoSort()
	local i
	for i = 1,OZ_Input.nBars do
		OZ_SortMap[i*2 - 1] = OZ_Input.bar[OZ_SortMap[i*2]].sortWeight
	end
	OZ_internalMergeSort2(OZ_Input.nBars * 2, OZ_SortMap)
end

function OZ_FinaliseSort(n)
	-- Now copy the input data to the output 'OZ_Bars' array
	local i,j
	for i = 1,OZ_Input.nBars do
		if(not OZ_Bars[n].bar[i])then
			OZ_Bars[n].bar[i] = {
									colour={},
									buffs={},
									buffNames={},
								}
		end
		local src,dest = OZ_Input.bar[ OZ_SortMap[i*2] ],OZ_Bars[n].bar[i]
		dest.roster		= src.roster
		dest.target		= src.target			
		dest.current	= src.current			
		dest.max		= src.max		
		dest.value		= src.value
		dest.class		= src.class
		if(dest.roster > 0)then
			dest.unit = OZ_RaidRoster.member[dest.roster].unit
		elseif(dest.target > 0)then
if(not OZ_RaidRoster.target[dest.target])then
	DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."  NULL Target, no. "..dest.target)
	dest.unit = nil
else
			dest.unit = OZ_RaidRoster.target[dest.target].unit
end
		else
			dest.unit = nil
		end
		for j=1,4 do
			dest.buffs[j]		= src.buffs[j]
			dest.buffNames[j]	= src.buffNames[j]
		end
		dest.debuff		= src.debuff
	end
	OZ_Bars[n].nBars = OZ_Input.nBars
end

function OZ_NoSort(n,scale)
	local i
	for i = 1,OZ_Input.nBars do
		local src,dest = OZ_Input.bar[i],OZ_Bars[n].bar[i]
		dest.roster		= src.roster
		dest.target		= src.target			
		dest.current	= src.current			
		dest.max		= src.max		
		dest.value		= src.value
		dest.class		= src.class
		if(dest.roster > 0)then
			dest.unit = OZ_RaidRoster.member[dest.roster].unit
		elseif(dest.target > 0)then
			dest.unit = OZ_RaidRoster.target[dest.target].unit
		else
			dest.unit = nil
		end

		for j=1,4 do
			dest.buffs[j]		= src.buffs[j]
			dest.buffNames[j]	= src.buffNames[j]
		end

		dest.debuff		= src.debuff
	end
	OZ_Bars[n].nBars = OZ_Input.nBars
end
------------------------------------------------------------
-- Sort function
--
-- This is a merge-sort, O(n log n), and should be marginally faster than a qsort
-- AND it is a stable sort, so entries with identical values preserve their order
-- Merge sorts are also generally better than heapsorts when dealing with arrays
-- so al in all this is the best sort for this type of mod.
--
-- It takes a single array with pairs of weights and 'source indices' that then let
-- you apply the sort to another array (its faster sorting with just 2 values per entry)
--   ..., weight, srcIndex, ...
-- It then sorts this array so the weights are ASCENDING
-- e.g:
-- input { 1.4, 1, -17.1, 2, 0.3, 3 } -> output { -17.1, 2, 0.3, 3, 1.4, 1 }
-- NOTE: The sort weights do not need to be in any particular range
------------------------------------------------------------
-- New SORT implemention - Stack based Merge Sort
--
--	Implements the sort using 'OZ_SortMap' as a FILO stack
--	Removes the need for creating any new arrays, and removes the need
--	for any array data to be copied around!
--	You dont even need to copy the result data as its done in place!
--	this WILL extend the original table by nearly 3x the original length,
-- but no more than that: n(input) + n + n/2 + n/4... etc.

function OZ_internalMergeSort2(n)
	-- Step 1 - split input array down the middle
	local lsize = math.floor(n*0.25)*2
	local rsize = n - lsize
	local i
	local left = n + 1
	local right = left + lsize
	local top = left + n

	for i = 1,n do
		OZ_SortMap[n+i] = OZ_SortMap[i]
	end



	-- Step 2 - if there is more than one entry on a 'branch' then recurse to sort it...
	if(lsize > 2) then
		left = OZ_internalMergeSort3( lsize, left, top )
	end
	if(rsize > 2) then
		right = OZ_internalMergeSort3( rsize, right, top + lsize )
	end

	-- Step 3

	local l,r,s = left,right,1
	local l_end = right - 1
	local r_end = top - 1
	while ( (l<l_end) and (r<r_end)  ) do
		if( OZ_SortMap[l] <= OZ_SortMap[r] ) then
			-- append 'left[l]' to 'sorted[s]'
			OZ_SortMap[s] = OZ_SortMap[l]
			OZ_SortMap[s+1] = OZ_SortMap[l+1]
			l = l + 2
		else
			-- append 'right[r] to 'sorted[s]'
			OZ_SortMap[s] = OZ_SortMap[r]
			OZ_SortMap[s+1] = OZ_SortMap[r+1]
			r = r + 2
		end
		s = s + 2
	end

	-- Now append any remaining items
	if( l<l_end ) then
		-- 'left' still has some in...
		for i = l,l_end do
			OZ_SortMap[s] = OZ_SortMap[i]
			s = s + 1
		end
	elseif( r<r_end ) then
		-- 'right' still has some in...
		for i = r,r_end do
			OZ_SortMap[s] = OZ_SortMap[i]
			s = s + 1
		end
	end
end

function OZ_internalMergeSort3(n, data, stackPos)
	-- Step 1 - split input array down the middle
	local lsize = math.floor(n*0.25)*2
	local rsize = n - lsize
	local i
	local left = stackPos
	local right = stackPos + lsize
	local top = stackPos + n
	local r_dest = top + lsize

	for i = 0,n-1 do
		OZ_SortMap[stackPos+i] = OZ_SortMap[data+i]
	end

	-- Step 2 - if there is more than one entry on a 'branch' then recurse to sort it...
	if(lsize > 2) then
		left = OZ_internalMergeSort3( lsize, left, top )
	end
	if(rsize > 2) then
		right = OZ_internalMergeSort3( rsize, right, r_dest )
	end

	-- Step 3
	local l,r,s = left,right,data
	local l_end = left + lsize - 1
	local r_end = right + rsize - 1
	while ( (l<l_end) and (r<r_end)  ) do
		if( OZ_SortMap[l] <= OZ_SortMap[r] ) then
			-- append 'left[l]' to 'sorted[s]'
			OZ_SortMap[s] = OZ_SortMap[l]
			OZ_SortMap[s+1] = OZ_SortMap[l+1]
			l = l + 2
		else
			-- append 'right[r] to 'sorted[s]'
			OZ_SortMap[s] = OZ_SortMap[r]
			OZ_SortMap[s+1] = OZ_SortMap[r+1]
			r = r + 2
		end
		s = s + 2
	end

	-- Now append any remaining items
	if( l<l_end ) then
		-- 'left' still has some in...
		for i = l,l_end do
			OZ_SortMap[s] = OZ_SortMap[i]
			s = s + 1
		end
	elseif( r<r_end ) then
		-- 'right' still has some in...
		for i = r,r_end do
			OZ_SortMap[s] = OZ_SortMap[i]
			s = s + 1
		end
	end
	return data
end
