interval = 500 -- 1/2 second press, gap, press limits
ignorepress = false

dofile([[.\LINDA\system\common.lua]])
dofile([[.\LINDA\libs\lib-msfs.lua]])
dofile([[.\LINDA\libs\lib-fsxcontrols.lua]])
dofile([[.\TripleUseAssignments.lua]])

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
			if timebutton(j, b, false) then  -- this was a double press, CS6
				assert(loadstring(btnFunc[i][4].."()"))()
			end
  	    else  -- This was a single press, send CS7
			assert(loadstring(btnFunc[i][3].."()"))()
            ignorepress = false
		end
	else  -- This was a single long press, send CS2
		assert(loadstring(btnFunc[i][5].."()"))()
  end
end


for i = 1, #btnFunc do
	event.button(btnFunc[i][1], btnFunc[i][2], i, "buttonpress")
end
