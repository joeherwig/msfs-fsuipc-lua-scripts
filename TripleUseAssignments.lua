--[[
    1=BU0836A Interface
    2=MFG Crosswind V2
    3=FCU / Lights
    5=Joystick - HOTAS Warthog
    6=3Dconnexion KMJ Emulator
    7=Controller (GAME FOR WINDOWS >)

    btnFunc is an multi-dimensional array (lua:table) containing data in the format
    { joy, button, singlePressFunctionName, doublePressFunctionName, longPressFunctionName }

    use function name "ignore" to mark an status as unused.
]]


btnFunc = {
    { 3, 7, "DeIce_PITOT_on", "ignore", "DeIce_PITOT_off"},
    { 5, 3, "G1000_MFD_SOFTKEY12", "ignore", "G1000_MFD_SOFTKEY11"},
    { 3, 9, "MasterCaution_reset", "ignore", "MasterWarning_reset"} 
}