if (!hasInterface) exitWith {};

horde_jumpmf_var_jumping = false;
horde_jumpmf_fnc_detect_key_input = "Community_Scripts\JumpMF\detect_key_input.sqf" call mf_compile;

waitUntil {!isNull findDisplay 46};
(findDisplay 46) displayAddEventHandler ["KeyDown", horde_jumpmf_fnc_detect_key_input];
