# msfs-fsuipc-lua-scripts
Some LUA scripts for FSUIPC in Microsoft Flight Simulator FS2020

## [TripleUse.lua](https://github.com/joeherwig/msfs-fsuipc-lua-scripts/blob/main/TripleUse.lua)

is the file that contains the core logic to be able to assign to a single input (usually push-buttons) up to three functions:

- single press
- double press
- long press

That allows for instance to use a single push-button to explicitly switch on/off Autopilot, Pitot-heating, APU etc. without the need of either wasting multiple inputs or having rocker-buttons that are not in sync with the virtual aircraft.

### [TripleUseAssignments.lua](https://github.com/joeherwig/msfs-fsuipc-lua-scripts/blob/main/TripleUseAssignments.lua)

To avoid that the **assignment** of functions and the corresponding **code** are mixed up, i split the assignment config into this seperate file.

# Thanks

to 

- Pete and John Dowson for their phantastic FSUIPC and great support.
- Andrew Gransden - doing great LINDA support.

