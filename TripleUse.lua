interval = 500 -- 1/2 second press, gap, press limits
ignorepress = false

--[[ 
	The following files are included using "dofile" to ensure that the functions you want to assign / call within the TripleUseAssignments.lua are available. 
	The Examples listed in here refer to teh new MSFS2020 where LINDA (https://www.avsim.com/forums/forum/427-linda-downloads/) is used.
	LINDA (Lua Integrated Non complex Device Assignments) brings LUA scripts that map FSUIPC Offsets and even more logic to nice and 
	self descriptive function names, which makes it much easier to assign them and even at a later point simply understand the assignments.
	In Case you want to get it running for other Simulators like P3D, FSX etc. you have to refer the related Function lists here.
	Of course TripleUse does not require to run LINDA to refer to those script files. You can also write and add your own.
	For me it was simply convenient to use the already made ones which saved me a lot of time.
]]--

-- Common functions needed, when you want to refer to the lib-msfs and lim-fsxcontrols functions.
dofile([[.\LINDA\system\common.lua]])
-- The function definitions as provided with LINDA. 
dofile([[.\LINDA\libs\lib-msfs.lua]])
dofile([[.\LINDA\libs\lib-fsxcontrols.lua]])
-- The assignments of functions to your game device buttons itself
dofile([[.\TripleUseAssignments.lua]])

-- Used to have a placeholder in case you do not want to assign something in the TripleUseAssignments.lua for some function. In that case just assign "ignore". As an "ignore" function did not exist in the above Function libs, i just added it here.
function ignore ()	
end

local function timebutton(joy, btn, test)
  ignorepress = true
  while true do
		time2 = ipc.elapsedtime()
		if (time2 - time1) > interval then
		  ignorepress = false
			return false
		end
	 	if ipc.testbutton(joy, btn) == test then
			time1 = time2
			return true
		end
	 	ipc.sleep(20)
	end
end

function buttonpress(j, b, i)
	if ignorepress then
		ignorepress = false
		return
	end
	time1 = ipc.elapsedtime()
	time2 = 0
	if timebutton(j, b, false) then
		-- First press / release counts: see if there's another
		if timebutton(j, b, true) then
			-- got another press in time, look for release
			if timebutton(j, b, false) then  -- this was a double press
				assert(loadstring(btnFunc[i][4].."()"))()
			end
  	    else  -- This was a single press
			assert(loadstring(btnFunc[i][3].."()"))()
            ignorepress = false
		end
	else  -- This was a single long press
		assert(loadstring(btnFunc[i][5].."()"))()
  end
end


for i = 1, #btnFunc do
	event.button(btnFunc[i][1], btnFunc[i][2], i, "buttonpress")
end
