interval = 500 -- 1/2 second press, gap, press limits
ignorepress = false

dofile([[.\LINDA\system\common.lua]])
dofile([[.\LINDA\libs\lib-fsxcontrols.lua]])
dofile([[.\TripleUseAssignments.lua]])
dofile([[.\LINDA\libs\lib-msfs.lua]])

function ignore ()
end

function timebutton(joy, btn, test)
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
---------------------------------------------------------
-- New function added below and called by funtion buttonpress()
-- Determine index into buttonpress() based on Joy# (j)and Button# (b)
-- and then call the FSX or MSFS control defined in "btnFunc" table
-- "typePress" is either single, double or long as press 
--  as determined in "function buttonpress"
-- 
--
function sendFSControl(j,b,typePress)
    --DspShow(j,b)
	for key, value in pairs(btnFunc) do
		if value[1] == j and value[2] == b then
			assert(loadstring(value[typePress].."()"))()
		end	
	end
end	

---------------------------------------------------------
function buttonpress(j, b, i)
--
-- note: the "i" parameter returned is "downup" state of the button
-- it is not an index pointing to which button was pressed
-- see FSUIPC Lua Library Document page 24 for details
--
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
			if timebutton(j, b, false) then
			    -- This was a double press, CS6
				-- replace original line: "assert(loadstring(btnFunc[i][4].."()"))()"
				-- with this new line
				-----------------------------------------
				sendFSControl(j,b,4)
				-----------------------------------------
			end
		else  -- This was a single press, send CS7
			  -- replace original line: "assert(loadstring(btnFunc[i][3].."()"))()"
			  -- with the following new line
			--------------------------------------------- 
			sendFSControl(j,b,3)
			--------------------------------------------- 	
			ignorepress = false
		end
	else  -- This was a single long press, send CS2
		  -- replace original line: "assert(loadstring(btnFunc[i][5].."()"))()"
		  -- with the following new new
		-------------------------------------------------  
		sendFSControl(j,b,5)
		-------------------------------------------------
	end
end



for i = 1, #btnFunc do
	-- replace original line "event.button(btnFunc[k][1], btnFunc[k][2], i, "buttonpress")"
	-- with the following new line
	-- the third parameter ("i") of event.button function is "downup" and can only be = 1,2,3 or ommitted.  
	-- it specifies whether to trigger on a press (=1 or omitted) , a release (=2) or either press or release (=3)
	-- so the new line set downup = 1 detect a button press
	-- see FSUIPC Lua Library document, page 24 for details
	
    -- ipc.log(" +-+-+- index " .. i .. " btn " .. btnFunc[i][1])
	-----------------------------------------------------
	event.button(btnFunc[i][1], btnFunc[i][2], 1, "buttonpress")
	-----------------------------------------------------
end
