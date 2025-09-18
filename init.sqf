/*
enableSaving [false, false];
enableSentences false;

//[] execVM "outlw_magRepack\MagRepack_init_sv.sqf";

DK_MIS_fnc_flipVeh = compileFinal preprocessFileLineNumbers "DK_Functions\missions\DK_MIS_fnc_flipVehicle.sqf";
DK_MIS_fnc_liftFlipVeh = compileFinal preprocessFileLineNumbers "DK_Functions\missions\DK_MIS_fnc_liftFlipVehicle.sqf";

if !(hasInterface) exitWith {};

0 spawn {
	waitUntil {!isNull player};
	[player, didJIP] remoteExecCall ["DK_fnc_initPlayerServer", 2];
};

//if (isServer) then {
	//call compile preprocessFileLineNumbers "\arma_gta\scripts\fn_obj.sqf";
	//call compile preprocessFileLineNumbers "\arma_gta\scripts\fn_mark.sqf";
	//call compile preprocessFileLineNumbers "\arma_gta\scripts\fn_trafficMainRoad.sqf";
//};
*/