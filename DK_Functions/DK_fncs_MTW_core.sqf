if !(isserver) exitWith {};

//#define PlaceOK(P,R1,R2) ((nearestObjects [P,["AllVehicles"],R1]) + (P nearEntities [["Man"], R2])) isEqualTo []

DK_blackListWP = [
	"mkr_spwnPrtct_0","mkr_spwnPrtct_1","mkr_spwnPrtct_2","mkr_spwnPrtct_3",
	"mkr_spwnPrtct_4","mkr_spwnPrtct_5","mkr_spwnPrtct_6","mkr_spwnPrtct_7",
	"DK_mkr_CLAG_blackList01","DK_mkr_CLAG_blackList03","DK_mkr_CLAG_blackList04",
	"DK_mkr_CLAG_blackList05","DK_mkr_CLAG_blackList06","DK_mkr_CLAG_blackList07",
	"DK_mkr_CLAG_blackList08","DK_mkr_CLAG_blackList09","DK_mkr_CLAG_blackList10",
	"DK_mkr_CLAG_blackList11","DK_mkr_CLAG_blackList12","DK_mkr_CLAG_blackList13",
	"DK_mkr_CLAG_blackList14","DK_mkr_CLAG_blackList15","DK_mkr_CLAG_blackList16", 
	"DK_mkr_CLAG_blackList17","DK_MTW_mkr_limitMap_1"
];

DK_mkrs_centerCity = [
	"DK_mkr_cityAreaCenter_1", "DK_mkr_cityAreaCenter_2", "DK_mkr_cityAreaCenter_3", 
	"DK_mkr_cityAreaCenter_4", "DK_mkr_cityAreaCenter_5", "DK_mkr_cityAreaCenter_6", 
	"DK_mkr_cityAreaCenter_7", "DK_mkr_cityAreaCenter_8", "DK_mkr_cityAreaCenter_9", 
	"DK_mkr_cityAreaCenter_10", "DK_mkr_cityAreaCenter_11", "DK_mkr_cityAreaCenter_12"
];


// Params
DK_RESPAWN_COST = compileFinal "150";


#define DelInCUM(TODEL) private _nul = DK_cleanUpMap_Array deleteAt (DK_cleanUpMap_Array find TODEL)
#define DelInEmpV(TODEL) private _nul = DK_emptyVeh deleteAt (DK_emptyVeh find TODEL)

#define voiceThugsADel(VO) private _nul = DK_voiceThugsA deleteAt (DK_voiceThugsA find VO)
#define voiceThugsA ["thugs01a", "thugs02a", "thugs03a"]

#define voiceThugsBDel(VO) private _nul = DK_voiceThugsB deleteAt (DK_voiceThugsB find VO)
#define voiceThugsB ["thugs01b", "thugs02b", "thugs03b", "thugs04b", "thugs05b"]

DK_voiceThugsA = +voiceThugsA;
DK_voiceThugsB = +voiceThugsB;
DK_actuThugsVO = 0;


#define voiceLootersADel(VO) private _nul = DK_voiceLootersA deleteAt (DK_voiceLootersA find VO)
#define voiceLootersA ["Looters01a", "Looters02a", "Looters03a", "Looters04a", "Looters05a"]

#define voiceLootersBDel(VO) private _nul = DK_voiceLootersB deleteAt (DK_voiceLootersB find VO)
#define voiceLootersB ["Looters01b", "Looters02b", "Looters03b", "Looters04b", "Looters05b", "Looters06b"]

DK_voiceLootersA = +voiceLootersA;
DK_voiceLootersB = +voiceLootersB;
DK_actuLootersVO = 0;


#define voiceBallasADel(VO) private _nul = DK_voiceBallasA deleteAt (DK_voiceBallasA find VO)
#define voiceBallasA ["Ballas01a", "Ballas02a", "Ballas03a", "Ballas04a", "Ballas05a", "Ballas06a"]

#define voiceBallasBDel(VO) private _nul = DK_voiceBallasB deleteAt (DK_voiceBallasB find VO)
#define voiceBallasB ["Ballas01b", "Ballas02b", "Ballas03b", "Ballas04b"]

DK_voiceBallasA = +voiceBallasA;
DK_voiceBallasB = +voiceBallasB;
DK_actuBallasVO = 0;


#define voiceTriadsADel(VO) private _nul = DK_voiceTriadsA deleteAt (DK_voiceTriadsA find VO)
#define voiceTriadsA ["Triads01a", "Triads02a", "Triads03a"]

#define voiceTriadsBDel(VO) private _nul = DK_voiceTriadsB deleteAt (DK_voiceTriadsB find VO)
#define voiceTriadsB ["Triads01b", "Triads02b", "Triads03b", "Triads04b", "Triads05b", "Triads06b"]

DK_voiceTriadsA = +voiceTriadsA;
DK_voiceTriadsB = +voiceTriadsB;
DK_actuTriadsVO = 0;


#define voiceDomiADel(VO) private _nul = DK_voiceDomiA deleteAt (DK_voiceDomiA find VO)
#define voiceDomiA ["Domi01a", "Domi02a", "Domi03a", "Domi04a", "Domi05a"]

#define voiceDomiBDel(VO) private _nul = DK_voiceDomiB deleteAt (DK_voiceDomiB find VO)
#define voiceDomiB ["Domi01b", "Domi02b", "Domi03b"]

DK_voiceDomiA = +voiceDomiA;
DK_voiceDomiB = +voiceDomiB;
DK_actuDomiVO = 0;


#define voiceAlbanADel(VO) private _nul = DK_voiceAlbanA deleteAt (DK_voiceAlbanA find VO)
#define voiceAlbanA ["Alban01a", "Alban02a", "Alban03a", "Alban04a", "Alban05a", "Alban06a", "Alban07a"]

#define voiceAlbanBDel(VO) private _nul = DK_voiceAlbanB deleteAt (DK_voiceAlbanB find VO)
#define voiceAlbanB ["Alban01b", "Alban02b", "Alban03b", "Alban04b", "Alban05b", "Alban06b", "Alban07b", "Alban08b"]

DK_voiceAlbanA = +voiceAlbanA;
DK_voiceAlbanB = +voiceAlbanB;
DK_actuAlbanVO = 0;



// Functions
DK_fnc_placeOK = {
	params ["_pos", "_rad1", "_rad2"];
	((nearestObjects [_pos, ["AllVehicles"], _rad1]) + (_pos nearEntities [["Man"], _rad2])) isEqualTo []
};

DK_fnc_MTW_searchSpawnVeh_OnRoad = {
	params [
		"_player", 
		["_disMin", 400], 
		["_disMax", 700], 
		["_duration", 12], 
		["_condLoop", 1], 
		["_checkVis", false], 
		["_disCond4", 250]
	];
	
	private ["_fnc_condSSVOR", "_goodPos", "_goodPosASL", "_road"];

	switch (_condLoop) do{
		case 1 :{
			_fnc_condSSVOR = {
				(!isNil "_player") && { (!isNull _player) && { (alive _player) } }
			};
		};
		case 2 :{
			_fnc_condSSVOR = {
				(!isNil "_player") && { (!isNull _player) && { (lifeState _player) isEqualTo "INCAPACITATED" } }
			};
		};
		case 3 :{
			_fnc_condSSVOR = {
				(!isNil "_player") && {(!isNull _player) && {(alive _player) && {!((lifeState _player) isEqualTo "INCAPACITATED") && {!({alive _x} count (_player getVariable ["wantedLvl", []]) isEqualTo 0)}}}}
			};
		};
		case 4 :{
			_fnc_condSSVOR = {
				!(playableUnits findIf { _x distance2D _player < _disCond4 } isEqualTo -1)
			};
		};
		case 5 :{
			_fnc_condSSVOR = {
				(!isNil "_player") && { (!isNull _player) && { (alive _player) && { !((lifeState _player) isEqualTo "INCAPACITATED") } } }
			};
		};
		case 6 :{
			_fnc_condSSVOR = {
				(!isNil "_player") && {(!isNull _player) && {(alive _player) && {!((lifeState _player) isEqualTo "INCAPACITATED") && {!((_player getVariable ["wantedLvl", []]) findIf {alive _x} isEqualTo -1)}}}}
			};
		};
	};

	// Secure for have only one search in same time, for prevent vehcile explose, spawn at same place, and friendly perf ;)
	waitUntil { uiSleep 0.2; !(DK_nbSearchSpawnRoad_inProg) OR !(call _fnc_condSSVOR) };

	if !(call _fnc_condSSVOR) exitWith{
		[0,0]
	};

	DK_nbSearchSpawnRoad_inProg = true;


	private _actualDis = _disMin;
	private _disToAdd = -10;
	private _directions = [0,11.25,22.5,33.75,45,56.25,67.5,78.75,90,101.25,112.5,123.75,135,146.25,157.5,168.75,180,191.25,202.5,213.75,225,236.25,247.5,258.75,270,281.25,292.5,303.75,315,326.25,337.5,348.75,360] call KK_fnc_arrayShuffle;
	private _dirStep = -1;
	private _time = time + _duration;
	private _timeMid = time + (_duration / 2);
	private _radius = 29.5;

	private "_roads";
	private _exit = false;

	while { call _fnc_condSSVOR } do{
		_dirStep = _dirStep + 1;
		if (_dirStep > 32) then{
			_dirStep = 0;
			_directions call KK_fnc_arrayShuffle;
			_actualDis = _actualDis + (_disToAdd + 50);
			if (_actualDis > _disMax) then{
				_actualDis = _disMin;
				_radius = 29.5;
			};
			_radius = _radius + 4;
		};

		_roads = (_player getPos [_actualDis,_directions # _dirStep]) nearRoads _radius;

		if !(_roads isEqualTo []) then{
			_road = selectRandom _roads;
			_goodPos = getPosATL _road;

			if ((DK_mkrs_spawnProtect findIf {_goodPos inArea _x;} isEqualTo -1) && {(DK_mkrs_noSpawnVeh findIf {_goodPos inArea _x;} isEqualTo -1) && {([_goodPos,35,25] call DK_fnc_placeOK) && {((nearestTerrainObjects [_goodPos, [], 10, false, false]) findIf {typeOf _x in ["Land_Bridge_01_PathLod_F", "Land_Bridge_HighWay_PathLod_F", "Land_Bridge_Asphalt_PathLod_F"]} isEqualTo -1) && {(playableUnits findIf { _x distance2D _goodPos < 150} isEqualTo -1)}}}}) then{
				if (_checkVis) then{
					if (time < _timeMid) then{
						_goodPosASL = getPosASL _road;
						_goodPosASL set [2, (_goodPosASL # 2) + 1];

						//if ( playableUnits findIf { [vehicle _x, "IFIRE"] checkVisibility [eyePos _x, _goodPosASL] > 0 } isEqualTo -1 ) then
						if (playableUnits findIf {!(lineIntersects [_x call DK_fnc_eyePlace, _goodPosASL])} isEqualTo -1) then{
							_exit = true;
						};
					}else{
						_exit = true;
					};
				}else{
					_exit = true;
				};
			};
		};

				// DEBUG MKR
				/*
				private _mkrNzme4 = "1" + (str (random 1000));
				private _markerstr4 = createMarker [_mkrNzme4, _player getPos [_actualDis,_directions # _dirStep]];
				_markerstr4 setMarkerShape "ICON";
				_markerstr4 setMarkerType "mil_dot";
				_markerstr4 setMarkerColor "ColorYellow";
				_markerstr4 setMarkerSize [0.6, 0.6];

				private _mkrNzme5 = "2" + (str (random 1000));
				private _markerstr5 = createMarker [_mkrNzme5, getMarkerPos _markerstr4];
				_markerstr5 setMarkerShape "ELLIPSE";
				_markerstr5 setMarkerBrush "Border";
				_markerstr5 setMarkerColor "ColorRed";
				_markerstr5 setMarkerSize [_radius, _radius];

				if !(_roads isEqualTo []) then
				{
					private _mkrNzme6 = "3" + (str (random 1000));
					private _markerstr6 = createMarker [_mkrNzme6, _goodPos];
					_markerstr6 setMarkerShape "ICON";
					_markerstr6 setMarkerType "mil_dot";
					_markerstr6 setMarkerColor "ColorGreen";
					_markerstr6 setMarkerSize [0.6, 0.6];
				};
				*/		
				// DEBUG MKR END

		if ((_exit) OR (time > _time)) exitWith {};
		uiSleep 0.04;
	};

	private _dir = 0;
	if (_exit) then{
		private _roadsCo = roadsConnectedTo _road;
		private _disAry = [];
		private _cnt = (count _roadsCo) - 1;
		for "_i" from 0 to _cnt step 1 do{
			_disAry pushBack ((_roadsCo # _i) distance2D _player);
		};

		private _goodDis = _disAry findIf { (selectMin _disAry) isEqualTo _x };
		if !(_goodDis isEqualTo -1) then{
			_dir = ((_roadsCo # _goodDis) getRelDir _goodPos) - 180;
		}else{
			_dir = _road getRelDir _player;
		};
		if (isNil "_dir") then{
			_dir = 0;
		};
	}else{
		_goodPos = 0;
	};
	[_goodPos,_dir]
};

DK_fnc_AddWaypointState = {
	params ["_grp", "_pos", "_script", ["_condition", "true"], ["_type", "MOVE"], "_form", ["_speed", "UNCHANGED"], ["_behavior", "UNCHANGED"], "_radius"];

	if (isNil "_grp") exitWith {};

	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointStatements [_condition, _script];
	_wp setWaypointType _type;

	if !(isNil "_form") then{
		_wp setWaypointFormation _form;
	};

	_wp setWaypointSpeed "UNCHANGED";
	_wp setWaypointBehaviour _behavior;

	if !(isNil "_radius") then{
		_wp setWaypointCompletionRadius _radius;
	};
	_wp
};

DK_fnc_AddWaypoint = {
	params ["_grp", ["_pos", [worldSize /2, worldSize / 2, 0]], ["_type", "MOVE"], "_form", "_speed", ["_behavior", "UNCHANGED"], "_radius"];

	if ((isNil "_grp") OR (_grp isEqualTo grpNull)) exitWith {};

	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType _type;

	if !(isNil "_form") then{
		_wp setWaypointFormation _form;
	};
	if !(isNil "_speed") then{
		_wp setWaypointSpeed _speed;
	};

	_wp setWaypointBehaviour _behavior;

	if !(isNil "_radius") then{
		_wp setWaypointCompletionRadius _radius;
	};
	_wp
};

DK_fnc_delAllWp = {
	while { (count (waypoints _this)) > 0} do{
		deleteWaypoint ((waypoints _this) # 0);
	};
};

DK_fnc_checkIfNight = {
	_daytime = daytime;
	((_daytime < 5) OR (_daytime > 19))
};

DK_fnc_cntMaxPlyrsByFam = {
	params [["_checkIfPvP", false]];

	if (allPlayers isEqualTo []) exitWith{
		[0, false];
	};

	private ["_nbUnits", "_nil"];
	private	_isPvP = false;
	private _nbPlayersBygrp = [];
	{
		if (((side _x) isEqualTo west) && {!((str _x) isEqualTo "B PETROVIC")}) then{
			_nbUnits = count (units _x);
			if !(_nbUnits isEqualTo 0) then{
				_nil = _nbPlayersBygrp pushBackUnique _nbUnits;
			};
		};
	} count allGroups;

	_nbMaxPlayerInTeam = selectMax _nbPlayersBygrp;

	if (isNil "_nbMaxPlayerInTeam") exitWith {};
	if ((_checkIfPvP) && {(count _nbPlayersBygrp > 1)}) then{
		_isPvP = true;
	};
	[_nbMaxPlayerInTeam, _isPvP]
};


DK_fnc_allPlayersHaveDLC_apex = {
	private _allPlayersHaveDLC = false;
	if (allPlayers findIf { !("Apex" in (_x getVariable ["listDLCs", []])) } isEqualTo -1) then{
		_allPlayersHaveDLC = true;
	};
	_allPlayersHaveDLC
};

DK_fnc_allPlayersHaveDLC_marksmen = {
	private _allPlayersHaveDLC = false;
	if (allPlayers findIf { !("Marksmen" in (_x getVariable ["listDLCs", []])) } isEqualTo -1) then{
		_allPlayersHaveDLC = true;
	};
	_allPlayersHaveDLC
};

DK_fnc_allPlayersHaveDLC_tanks = {
	private _allPlayersHaveDLC = false;
	if (allPlayers findIf { !("Tanks" in (_x getVariable ["listDLCs", []])) } isEqualTo -1) then{
		_allPlayersHaveDLC = true;
	};
	_allPlayersHaveDLC
};

DK_fnc_allPlayersHaveDLC_contact = {
	private _allPlayersHaveDLC = false;
	if (allPlayers findIf { !("Contact" in (_x getVariable ["listDLCs", []])) } isEqualTo -1) then{
		_allPlayersHaveDLC = true;
	};
	_allPlayersHaveDLC
};

DK_fnc_activateDynSim = {
	if ((!isNil "_this") && {(!isNull _this) && {!(_this getVariable ["MngDynSim", false]) && {(alive _this) && {!(_this getVariable ["smoked", false]) && {!(dynamicSimulationEnabled _this) && {(crew _this findIf {alive _x} isEqualTo -1)}}}}}}) then{
		_this setVariable ["MngDynSim", true];
		_this spawn{
			waitUntil {
				uiSleep 1; 
				(isNil "_this") OR 
				(isNull _this) OR 
				(!alive _this) OR 
				(speed _this isEqualTo 0) OR 
				!(crew _this findIf {alive _x} isEqualTo -1)
			};

			_this setVariable ["MngDynSim", false];

			if ((!isNil "_this") && {(!isNull _this) && {!(dynamicSimulationEnabled _this) && {(alive _this) && {(crew _this findIf {alive _x} isEqualTo -1)}}}}) then{
				_this enableDynamicSimulation true;
			};
		};
	};
};

DK_fnc_addEH_getInMan_dynSim = {
	private _idEh = _this addEventHandler ["GetInMan",
	{
		params ["_unit", "", "_vehicle"];
		//systemChat str (dynamicSimulationEnabled _vehicle);
		private _exit = false;
		if (typeName _vehicle isEqualTo "SCALAR") then{
			if (!isNull (objectParent _unit)) then{
				_vehicle = objectParent _unit;
			}else{
				_exit = true;
				//systemChat ((str _vehicle) + " ; Veh is Scalar");
			};
		};
		if _exit exitWith {};
		if (dynamicSimulationEnabled _vehicle) then{
			_vehicle enableDynamicSimulation false;
			//systemChat str (dynamicSimulationEnabled _vehicle);
		};
	}];
};

DK_fnc_activateVeh = {
	{
		_x enableSimulationGlobal true;
	} count _this;
	uiSleep 2;
	{
		_x allowDamage true;
		//_x enableDynamicSimulation true;
	} count _this;
};

DK_fnc_shuffleDiviseArray = {
	params [["_arrayStart", []], ["_divis", 2], "_nul", "_elem", "_newArray"];
	_newArray = [];
	call{
		if (_arrayStart isEqualTo []) exitWith {};
		private _cnt = count _arrayStart;
		if (_cnt > 1) exitWith{
			_cnt = (round (_cnt / _divis )) - 1;
			if (_cnt > 0) exitWith{
				for "_i" from 0 to _cnt do{
					_elem = selectRandom _arrayStart;
					_newArray pushBackUnique _elem;
					_nul = _arrayStart deleteAt (_newArray find _elem);
				};
			};
			_newArray = _arrayStart;
		};
		_newArray = _arrayStart;
	};
	_newArray
};

DK_fnc_smokeHeObjct = {
	params ["_objct", ["_timeM", 30], ["_attachPos", [0,0,0]], ["_smokeType", "SmokeShellRed"]];
	if ((isNil "_objct") OR (isNull _objct) OR ((typename _timeM isEqualTo "SCALAR") && {(_timeM < 0)}) OR (!(typename _timeM isEqualTo "SCALAR") && { (_objct call _timeM)})) exitWith {};

	private ["_smoke", "_time", "_timeMax", "_oldSMoke"];
	call{
		if !(typename _timeM isEqualTo "SCALAR") exitWith{
			while {(!isNil "_objct") && {(!isNull _objct) && {(alive _objct) && {!([_objct] call _timeM) && {!(_objct getVariable ["smokeStop", false])}}}}} do{
				_smoke = createVehicle [_smokeType, _objct, [], 0, "CAN_COLLIDE"];
				_smoke hideObjectGlobal true;
				//uiSleep 3;

				if (
					(isNil "_objct") OR 
					(isNull _objct) OR 
					(isNil "_smoke") OR 
					(isNull _smoke) OR 
					!(alive _objct) OR 
					(_objct getVariable ["smokeStop", false])
				) exitWith {};
				_smoke attachto [_objct, _attachPos];
				if ((!isNil "_oldSMoke") && {(!isNull _oldSMoke)}) then{
					deleteVehicle _oldSMoke;
				};

				_time = time + 20;

				waitUntil {
					uiSleep 1; 
					(time > _time) OR 
					(isNil "_objct") OR 
					(isNull _objct) OR 
					!(alive _objct) OR 
					(isNil "_smoke") OR 
					(isNull _smoke) OR 
					([_objct] call _timeM) OR 
					(_objct getVariable ["smokeStop", false])
				};

				if ((!isNil "_smoke") && {(!isNull _smoke)}) then{
					_oldSMoke = _smoke;
				};
			};
		};

		if (_timeM isEqualTo 0) exitWith{
			while {(!isNil "_objct") && {(!isNull _objct) && {(alive _objct) && {!(_objct getVariable ["smokeStop", false])}}}} do{
				_smoke = createVehicle [_smokeType, _objct, [], 0, "CAN_COLLIDE"];
				_smoke hideObjectGlobal true;
				//uiSleep 3;

				if (
					(isNil "_objct") OR 
					(isNull _objct) OR 
					(isNil "_smoke") OR 
					(isNull _smoke) OR 
					!(alive _objct) OR 
					(_objct getVariable ["smokeStop", false])
				) exitWith {};
				
				_smoke attachto [_objct, _attachPos];

				if ((!isNil "_oldSMoke") && {(!isNull _oldSMoke)}) then{
					deleteVehicle _oldSMoke;
				};

				_time = time + 20;

				waitUntil {
					uiSleep 1; 
					(time > _time) OR 
					(isNil "_objct") OR 
					(isNull _objct) OR 
					(isNil "_smoke") OR 
					!(alive _objct) OR 
					(isNull _smoke) OR 
					(_objct getVariable ["smokeStop", false])
				};

				if ((!isNil "_smoke") && {(!isNull _smoke)}) then {
					_oldSMoke = _smoke;
				};
			};
		};

		_timeMax = time + _timeM;

		while {
			(time < _timeMax) && {
				(!isNil "_objct") && {
					(!isNull _objct) && {
						(alive _objct) && {
							!(_objct getVariable ["smokeStop", false])
		} } } } } do {
			_smoke = createVehicle [_smokeType, _objct, [], 0, "CAN_COLLIDE"];
			_smoke hideObjectGlobal true;
			//uiSleep 3;

			if (
				(isNil "_objct") OR 
				(isNull _objct) OR 
				(isNil "_smoke") OR 
				(isNull _smoke) OR 
				!(alive _objct) OR 
				(_objct getVariable ["smokeStop", false])
			) exitWith {};
			
			_smoke attachto [_objct, _attachPos];

			if ((!isNil "_oldSMoke") && {(!isNull _oldSMoke)}) then{
				deleteVehicle _oldSMoke;
			};

			call{
				if (_timeM < 20) exitWith{
					_time = time + _timeM + 1;
				};
				_time = time + 20;
			};

			waitUntil {
				uiSleep 1; 
				(time > _time) OR 
				(time > _timeMax) OR 
				(isNil "_objct") OR 
				!(alive _objct) OR 
				(isNull _objct) OR 
				(isNil "_smoke") OR 
				(isNull _smoke) OR 
				(_objct getVariable ["smokeStop", false])
			};

			if ((!isNil "_smoke") && {(!isNull _smoke)}) then{
				_oldSMoke = _smoke;
			};
		};
	};

	if ((!isNil "_smoke") && {(!isNull _smoke)}) then {
		deleteVehicle _smoke;
	};
};

DK_fnc_getNopenPara = {

//	params ["_unit", "_heli", ["_alt", 75]];
	params ["_unit", "_heli", ["_alt", 100]];


	if ( ((getPosATL _unit) # 2 > 50) && {(alive _unit)} ) then
	{
		waitUntil { uiSleep 0.05; ( ((_unit distance _heli) > 10) && {((getPosATL _unit) # 2 < _alt)} ) OR (!alive _unit) };

		if ( (alive _unit) && { !(isTouchingGround _unit) } ) then
		{
			if (isAgent teamMember _unit) exitWith
			{
				_unit call DK_fnc_crtParaAgent;
			};

			_unit addBackpack "B_Parachute";
			_unit action ["OpenParachute", _unit];
		};
	};
};

DK_fnc_crtParaAgent = {

	private _para = createVehicle ["B_Parachute_02_F", [0,0,100], [], 0, ""];
	_para setPosATL (_this modelToWorld [0, 0, 0]);

	private _vel = velocityModelSpace _this;
	_para setVelocityModelSpace [((_vel # 0) / 2), ((_vel # 1) / 2), (_vel # 2)];

	_this attachTo [_para, [0,0, -0.8]]; 
	[_this, "Para_Pilot"] remoteExecCall ["DK_fnc_AnimSwitch", 0];

	// Land safely
	WaitUntil { uiSleep 0.1; (isNil "_para") OR (isNil "_this") OR (isNull _para) OR (isNull _this) OR (((position _this) # 2) < 1) };

	if ( (isNil "_this") OR (isNull _this) ) exitWith {};

	[_this, ""] remoteExecCall ["DK_fnc_AnimSwitch", 0];

	uiSleep 0.3;

	if ( (isNil "_para") OR (isNull _para) ) exitWith {};

	detach _this;

	deleteVehicle _para;
};


DK_fnc_forceSingleFire = {

	_this addEventHandler ["FiredMan",
	{
		params ["_unit", "", "", "_mode"];

		if !(_mode isEqualTo "Single") then
		{
			_unit action ["SWITCHMAGAZINE", _unit, _unit, 0];
		};
	}];

};


DK_fnc_createMoneyObj = {

	params ["_objects", ["_gain", 50]];


	if ( (isNil "_objects") OR (_objects isEqualTo []) ) exitWith {};

	private _money = createVehicle ["Land_Money_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	_money attachTo [selectRandom _objects, [0,0,0.8]];
	uiSleep 1;
	detach _money;
	_money setVariable ["gain", _gain, true];
	_money remoteExecCall ["DK_fnc_moneyAddAct", DK_isDedi];


	_money
};


DK_fnc_eyePlace = {

	if ((isNil "_this") OR (isNull _this)) exitWith
	{
		[0,0,0]
	};

	((eyePos _this) vectorAdd (eyeDirection _this vectorMultiply 0))
};

DK_corpsPlace = {

	if ((isNil "_this") OR (isNull _this)) exitWith
	{
		[0,0,0]
	};

	(getPosASLVisual _this) vectorAdd [0,0,0.5]
};


DK_fnc_checkDlcAir = {

	private _dlc = getObjectDLC _this;

	if (isNil "_dlc") exitWith {};

	switch (_dlc) do
	{
		case 395180 :
		{
			{
				if !("Apex" in (_x getVariable ["listDLCs", []])) then
				{
					_this remoteExecCall ["DK_addAction_dlc_cl", _x];
				};

				uiSleep 0.1;

			} count allPlayers;
		};

		case 601670 :
		{
			{
				if !("Jet" in (_x getVariable ["listDLCs", []])) then
				{
					_this remoteExecCall ["DK_addAction_dlc_cl", _x];
				};

				uiSleep 0.1;

			} count allPlayers;
		};

		case 304380 :
		{
			{
				if !("Heli" in (_x getVariable ["listDLCs", []])) then
				{
					_this remoteExecCall ["DK_addAction_dlc_cl", _x];
				};

				uiSleep 0.1;

			} count allPlayers;
		};
	};
};


// Added EH Respawn for controle dead corps
DK_addMpEH_respawn = {

	_this addMPEventHandler ["MPRespawn",
	{
		params ["_unit", "_corps"];


		[_corps, 180, 150, true] spawn DK_fnc_addAllTo_CUM;


		nil
	}];
};


DK_fnc_slctMinPlayerScr = {

	private "_playerMin";

	call
	{
		private "_nil";

		private _famsScore = [];
		{
			if ( ((side _x) isEqualTo west) && { !(units _x isEqualTo []) } ) then
			{
				_nil = _famsScore pushBack [_x getVariable ["DK_familyScore", 0], _x];
			};

			uiSleep 0.02;

		} count allGroups;

		if (_famsScore isEqualTo []) exitWith {};


		_famsScore sort true;
//		private _grpMin = (_famsScore # 0) # 1;
		private _units = units ((_famsScore # 0) # 1);


		private _playersScore = [];
		{
			_nil = _playersScore pushBack [(getPlayerScores _x) # 5, _x];

			uiSleep 0.02;

		} count _units;

		if (_playersScore isEqualTo []) exitWith {};


		_playersScore sort true;
		_playerMin = (_playersScore # 0) # 1;
	};

	if (isNil "_playerMin") then
	{
//		hint "player with minimum score not found";
		diag_log "player with minimum score not found";

		waitUntil { !(playableUnits isEqualTo []) };

		_playerMin = selectRandom playableUnits;
	};


	_playerMin
};

// Custom channel for Petrovic, Маленький Джейкоб etc
DK_fnc_customChat = {

	params ["_sender", "_theme", ["_target", DK_isDedi]];


	switch (_sender) do
	{
		case "Кенни Петрович" :
		{
			private _chan = missionNamespace getVariable ["chanPetro", "fuck"];

			[_chan, _theme] remoteExecCall ["DK_fnc_customChat_cl", _target];
		};

		case "Маленький Джейкоб" :
		{
			private _chan = missionNamespace getVariable ["chanLJ", "fuck"];

			[_chan, _theme] remoteExecCall ["DK_fnc_customChat_cl", _target];
		};
	};
};


DK_fnc_crtBoostSmoke = {
	params ["_pos", "_veh", "_params"];

	private	_src1 = "#particlesource" createVehicle _pos;
	private	_src2 = "#particlesource" createVehicle _pos;
	[_veh, _src1, _src2, _params] remoteExecCall ["DK_fnc_setParticle_cl", DK_isDedi];

	[_src1, _src2] spawn
	{
		params ["_src1", "_src2"];
		uiSleep 0.17;
		deletevehicle _src1;
		deletevehicle _src2;
	};
};

DK_fnc_hideGlob = {
	params ["_object", ["_hide", true]];
	_object hideObjectGlobal _hide;
};



/// Voice gangs sounds
// land vehicle & foot
DK_fnc_voiceThugsA = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceThugsA;
	voiceThugsADel(_voice);

	if (DK_voiceThugsA isEqualTo []) then
	{
		DK_voiceThugsA = +voiceThugsA;
		voiceThugsADel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_fnc_voiceThugsB = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceThugsB;
	voiceThugsBDel(_voice);

	if (DK_voiceThugsB isEqualTo []) then
	{
		DK_voiceThugsB = +voiceThugsB;
		voiceThugsBDel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_loop_voiceThugs = {

	if (leader _this getVariable ["vocalOn", false]) exitWith {};

	call
	{
		if (DK_actuThugsVO isEqualTo 0) exitWith
		{
			DK_actuThugsVO = 1;

			uiSleep (0.5 + (DK_actuThugsVO / (random 0.4)));

			(units _this) apply
			{
				_x call DK_fnc_EHvoiceThugsB;
			};

			while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
			{
				_leader = leader _this;

				if !(_leader getVariable ["vocalOn", false]) then
				{
					_leader setVariable ["vocalOn", true];
				};

				if (isNull (objectParent _leader)) then
				{
					_leader call DK_fnc_voiceThugsB;
				};

				sleep (20 + (random 15));
			};
		};


		DK_actuThugsVO = 0;

		uiSleep (0.5 + (DK_actuThugsVO / (random 0.4)));

		(units _this) apply
		{
			_x call DK_fnc_EHvoiceThugsA;
		};

		while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
		{
			_leader = leader _this;

			if !(_leader getVariable ["vocalOn", false]) then
			{
				_leader setVariable ["vocalOn", true];
			};

			if (isNull (objectParent _leader)) then
			{
				_leader call DK_fnc_voiceThugsA;
			};

			sleep (20 + (random 15));
		};
	};
};

DK_fnc_EHvoiceThugsA = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceThugsA;
		};
	}];
};

DK_fnc_EHvoiceThugsB = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceThugsB;
		};
	}];
};


DK_fnc_voiceLootersA = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceLootersA;
	voiceLootersADel(_voice);

	if (DK_voiceLootersA isEqualTo []) then
	{
		DK_voiceLootersA = +voiceLootersA;
		voiceLootersADel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_fnc_voiceLootersB = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceLootersB;
	voiceLootersBDel(_voice);

	if (DK_voiceLootersB isEqualTo []) then
	{
		DK_voiceLootersB = +voiceLootersB;
		voiceLootersBDel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_loop_voiceLooters = {

	if (leader _this getVariable ["vocalOn", false]) exitWith {};

	call
	{
		if (DK_actuLootersVO isEqualTo 0) exitWith
		{
			DK_actuLootersVO = 1;

			uiSleep (0.5 + (DK_actuLootersVO / (random 0.4)));

			(units _this) apply
			{
				_x call DK_fnc_EHvoiceLootersB;
			};

			while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
			{
				_leader = leader _this;

				if !(_leader getVariable ["vocalOn", false]) then
				{
					_leader setVariable ["vocalOn", true];
				};

				if (isNull (objectParent _leader)) then
				{
					_leader call DK_fnc_voiceLootersB;
				};

				sleep (20 + (random 15));
			};
		};


		DK_actuLootersVO = 0;

		uiSleep (0.5 + (DK_actuLootersVO / (random 0.4)));

		(units _this) apply
		{
			_x call DK_fnc_EHvoiceLootersA;
		};

		while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
		{
			_leader = leader _this;

			if !(_leader getVariable ["vocalOn", false]) then
			{
				_leader setVariable ["vocalOn", true];
			};

			if (isNull (objectParent _leader)) then
			{
				_leader call DK_fnc_voiceLootersA;
			};

			sleep (20 + (random 15));
		};
	};
};

DK_fnc_EHvoiceLootersA = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceLootersA;
		};
	}];
};

DK_fnc_EHvoiceLootersB = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceLootersB;
		};
	}];
};


DK_fnc_voiceBallasA = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceBallasA;
	voiceBallasADel(_voice);

	if (DK_voiceBallasA isEqualTo []) then
	{
		DK_voiceBallasA = +voiceBallasA;
		voiceBallasADel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_fnc_voiceBallasB = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceBallasB;
	voiceBallasBDel(_voice);

	if (DK_voiceBallasB isEqualTo []) then
	{
		DK_voiceBallasB = +voiceBallasB;
		voiceBallasBDel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_loop_voiceBallas = {

	if (leader _this getVariable ["vocalOn", false]) exitWith {};

	call
	{
		if (DK_actuBallasVO isEqualTo 0) exitWith
		{
			DK_actuBallasVO = 1;

			uiSleep (0.5 + (DK_actuBallasVO / (random 0.4)));

			(units _this) apply
			{
				_x call DK_fnc_EHvoiceBallasB;
			};

			while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
			{
				_leader = leader _this;

				if !(_leader getVariable ["vocalOn", false]) then
				{
					_leader setVariable ["vocalOn", true];
				};

				if (isNull (objectParent _leader)) then
				{
					_leader call DK_fnc_voiceBallasB;
				};

				sleep (20 + (random 15));
			};
		};


		DK_actuBallasVO = 0;

		uiSleep (0.5 + (DK_actuBallasVO / (random 0.4)));

		(units _this) apply
		{
			_x call DK_fnc_EHvoiceBallasA;
		};

		while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
		{
			_leader = leader _this;

			if !(_leader getVariable ["vocalOn", false]) then
			{
				_leader setVariable ["vocalOn", true];
			};

			if (isNull (objectParent _leader)) then
			{
				_leader call DK_fnc_voiceBallasA;
			};

			sleep (20 + (random 15));
		};
	};
};

DK_fnc_EHvoiceBallasA = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceBallasA;
		};
	}];
};

DK_fnc_EHvoiceBallasB = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceBallasB;
		};
	}];
};


DK_fnc_voiceTriadsA = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceTriadsA;
	voiceTriadsADel(_voice);

	if (DK_voiceTriadsA isEqualTo []) then
	{
		DK_voiceTriadsA = +voiceTriadsA;
		voiceTriadsADel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_fnc_voiceTriadsB = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceTriadsB;
	voiceTriadsBDel(_voice);

	if (DK_voiceTriadsB isEqualTo []) then
	{
		DK_voiceTriadsB = +voiceTriadsB;
		voiceTriadsBDel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_loop_voiceTriads = {

	if (leader _this getVariable ["vocalOn", false]) exitWith {};

	call
	{
		if (DK_actuTriadsVO isEqualTo 0) exitWith
		{
			DK_actuTriadsVO = 1;

			uiSleep (0.5 + (DK_actuTriadsVO / (random 0.4)));

			(units _this) apply
			{
				_x call DK_fnc_EHvoiceTriadsB;
			};

			while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
			{
				_leader = leader _this;

				if !(_leader getVariable ["vocalOn", false]) then
				{
					_leader setVariable ["vocalOn", true];
				};

				if (isNull (objectParent _leader)) then
				{
					_leader call DK_fnc_voiceTriadsB;
				};

				sleep (20 + (random 15));
			};
		};


		DK_actuTriadsVO = 0;

		uiSleep (0.5 + (DK_actuTriadsVO / (random 0.4)));

		(units _this) apply
		{
			_x call DK_fnc_EHvoiceTriadsA;
		};

		while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
		{
			_leader = leader _this;

			if !(_leader getVariable ["vocalOn", false]) then
			{
				_leader setVariable ["vocalOn", true];
			};

			if (isNull (objectParent _leader)) then
			{
				_leader call DK_fnc_voiceTriadsA;
			};

			sleep (20 + (random 15));
		};
	};
};

DK_fnc_EHvoiceTriadsA = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceTriadsA;
		};
	}];
};

DK_fnc_EHvoiceTriadsB = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceTriadsB;
		};
	}];
};


DK_fnc_voiceDomiA = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceDomiA;
	voiceDomiADel(_voice);

	if (DK_voiceDomiA isEqualTo []) then
	{
		DK_voiceDomiA = +voiceDomiA;
		voiceDomiADel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_fnc_voiceDomiB = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceDomiB;
	voiceDomiBDel(_voice);

	if (DK_voiceDomiB isEqualTo []) then
	{
		DK_voiceDomiB = +voiceDomiB;
		voiceDomiBDel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_loop_voiceDomi = {

	if (leader _this getVariable ["vocalOn", false]) exitWith {};

	call
	{
		if (DK_actuDomiVO isEqualTo 0) exitWith
		{
			DK_actuDomiVO = 1;

			uiSleep (0.5 + (DK_actuDomiVO / (random 0.4)));

			(units _this) apply
			{
				_x call DK_fnc_EHvoiceDomiB;
			};

			while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
			{
				_leader = leader _this;

				if !(_leader getVariable ["vocalOn", false]) then
				{
					_leader setVariable ["vocalOn", true];
				};

				if (isNull (objectParent _leader)) then
				{
					_leader call DK_fnc_voiceDomiB;
				};

				sleep (20 + (random 15));
			};
		};


		DK_actuDomiVO = 0;

		uiSleep (0.5 + (DK_actuDomiVO / (random 0.4)));

		(units _this) apply
		{
			_x call DK_fnc_EHvoiceDomiA;
		};

		while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
		{
			_leader = leader _this;

			if !(_leader getVariable ["vocalOn", false]) then
			{
				_leader setVariable ["vocalOn", true];
			};

			if (isNull (objectParent _leader)) then
			{
				_leader call DK_fnc_voiceDomiA;
			};

			sleep (20 + (random 15));
		};
	};
};

DK_fnc_EHvoiceDomiA = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceDomiA;
		};
	}];
};

DK_fnc_EHvoiceDomiB = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceDomiB;
		};
	}];
};


DK_fnc_voiceAlbanA = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceAlbanA;
	voiceAlbanADel(_voice);

	if (DK_voiceAlbanA isEqualTo []) then
	{
		DK_voiceAlbanA = +voiceAlbanA;
		voiceAlbanADel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_fnc_voiceAlbanB = {

	if (!alive _this) exitWith {};

	private _voice = selectRandom DK_voiceAlbanB;
	voiceAlbanBDel(_voice);

	if (DK_voiceAlbanB isEqualTo []) then
	{
		DK_voiceAlbanB = +voiceAlbanB;
		voiceAlbanBDel(_voice);
	};

	[_this, _voice, 150, (_this getVariable ["pitch", 1]), true] call DK_fnc_say3D;
	[_this, 2] spawn DK_fnc_randomLip;
};

DK_loop_voiceAlban = {

	if (leader _this getVariable ["vocalOn", false]) exitWith {};

	call
	{
		if (DK_actuAlbanVO isEqualTo 0) exitWith
		{
			DK_actuAlbanVO = 1;

			uiSleep (0.5 + (DK_actuAlbanVO / (random 0.4)));

			(units _this) apply
			{
				_x call DK_fnc_EHvoiceAlbanB;
			};

			while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
			{
				_leader = leader _this;

				if !(_leader getVariable ["vocalOn", false]) then
				{
					_leader setVariable ["vocalOn", true];
				};

				if (isNull (objectParent _leader)) then
				{
					_leader call DK_fnc_voiceAlbanB;
				};

				sleep (20 + (random 15));
			};
		};


		DK_actuAlbanVO = 0;

		uiSleep (0.5 + (DK_actuAlbanVO / (random 0.4)));

		(units _this) apply
		{
			_x call DK_fnc_EHvoiceAlbanA;
		};

		while { !((units _this) findIf {alive _x} isEqualTo -1) && {(leader _this getVariable ["DK_behaviour", "chase"] isEqualTo "chase")} } do
		{
			_leader = leader _this;

			if !(_leader getVariable ["vocalOn", false]) then
			{
				_leader setVariable ["vocalOn", true];
			};

			if (isNull (objectParent _leader)) then
			{
				_leader call DK_fnc_voiceAlbanA;
			};

			sleep (20 + (random 15));
		};
	};
};

DK_fnc_EHvoiceAlbanA = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceAlbanA;
		};
	}];
};

DK_fnc_EHvoiceAlbanB = {

	if (!alive _this) exitWith {};

	private _id = _this addEventHandler ["GetOutMan",
	{
		params ["_unit"];


		if (!alive _unit) exitWith
		{
			_unit removeEventHandler ["GetOutMan", _thisEventHandler];
		};

		if ((leader group _unit) isEqualTo _unit) then
		{
			_unit call DK_fnc_voiceAlbanB;
		};
	}];
};


DK_fnc_selectLoopVoice = {

	switch ((leader _this) getVariable ["DK_side", ""]) do
	{
		case "mis_thug" :
		{
			_this call DK_loop_voiceThugs;
		};

		case "mis_thug2" :
		{
			_this call DK_loop_voiceThugs;
		};

		case "mis_Looter" :
		{
			_this call DK_loop_voiceLooters;
		};

		case "mis_ballas" :
		{
			_this call DK_loop_voiceBallas;
		};

		case "mis_ballas2" :
		{
			_this call DK_loop_voiceBallas;
		};

		case "mis_triads" :
		{
			_this call DK_loop_voiceTriads;
		};

		case "mis_triads2" :
		{
			_this call DK_loop_voiceTriads;
		};

		case "mis_domi" :
		{
			_this call DK_loop_voiceDomi;
		};

		case "mis_alban" :
		{
			_this call DK_loop_voiceAlban;
		};

		case "cops" :
		{
			_this call DK_loop_voicePoliceLand;
		};

		case "fbi" :
		{
			_this call DK_loop_voiceFBILand;
		};

		case "army" :
		{
			_this call DK_loop_voiceArmyLand;
		};
	};
};

DK_fnc_selectLoopVoiceHeli = {

//	params ["_driverH", "_target"];
	params ["_driverH"];


	private _side = _driverH getVariable ["DK_side", ""];
	if (_side isEqualTo "cops") then
	{
//		[_driverH, _target] spawn DK_loop_voicePoliceHeli;
		[_driverH] spawn DK_loop_voicePoliceHeli;
	};

/*	if (_side isEqualTo "fbi") exitWith
	{
		_heli spawn DK_loop_voiceFBILand;
	};

	if (_side isEqualTo "army") then
	{
		_heli spawn DK_loop_voiceArmyLand;
	};
*/
};


// Manage player score
DK_fnc_tabScr = {

	params ["_unit", ["_infantry", 0], ["_soft", 0], ["_armor", 0], ["_air", 0], ["_killed", 0]];


	if (isNil "_unit") exitWith {};

	_unit addPlayerScores [_infantry, _soft, _armor, _air, _killed];
};


/// // Unit safely behaviour

// Sitting
DK_fnc_2_sitting = {

	params ["_unit01","_unit02"];

	_unit02 attachTo [_unit01,[0,2.6,0]];
	_unit01 setDir (random 360);
	_unit02 setDir 180;
};

DK_fnc_4_sitting = {

	params ["_unit01","_unit02","_unit03","_unit04","_pos"];

	_unit02 attachTo [_unit01,[0,2.4,0]];
	_unit01 setDir (random 360);
	_unit02 setDir 180;

	_unit03 attachTo [_unit01,[1.4,1.4,0]];
	_unit03 setDir (_unit03 getRelDir _pos);

	_unit04 attachTo [_unit01,[-1.4,1.4,0]];
	_unit04 setDir (_unit04 getRelDir _pos);

};

DK_fnc_6_sitting = {

	params ["_unit01","_unit02","_unit03","_unit04","_unit05","_unit06","_pos"];

	_unit02 attachTo [_unit01,[0,2.4,0]];
	_unit01 setDir (random 360);
	_unit02 setDir 180;

	_unit03 attachTo [_unit01,[1.2,1.1,0]];
	_unit03 setDir (_unit03 getRelDir _pos);

	_unit04 attachTo [_unit01,[-1.2,1.1,0]];
	_unit04 setDir (_unit04 getRelDir _pos);

	_unit05 attachTo [_unit01,[1.2,2,0]];
	_unit05 setDir (_unit05 getRelDir _pos);

	_unit06 attachTo [_unit01,[-1.2,2,0]];
	_unit06 setDir (_unit06 getRelDir _pos);
};

// Up chatting
DK_fnc_2_chatting = {

	params ["_unit01","_unit02"];

	_unit02 attachTo [_unit01,[0,1.54,0]];
	_unit02 setDir 180;
	_unit01 setDir (random 360);

};

DK_fnc_3_chatting = {

	params ["_unit01","_unit02","_unit03"];

	_unit02 attachTo [_unit01,[-0.6,1.54,0]];
	_unit03 attachTo [_unit01,[0.6,1.54,0]];
	_unit01 setDir (random 360);
	_unit02 setDir 150;
	_unit03 setDir 200;
};

DK_fnc_4_chatting = {

	params ["_unit01","_unit02","_unit03","_unit04"];

	_unit02 attachTo [_unit01, [1.4 + (random 0.8) - 0.4,0,0]];
	_unit03 attachTo [_unit01, [0 + (random 0.8) - 0.4,1.4,0]];
	_unit04 attachTo [_unit01, [1.4 + (random 0.8) - 0.4,1.4,0]];

	_unit01 setDir ((_unit01 getRelDir _unit03) + (random 20));
	_unit02 setDir ((_unit02 getRelDir _unit04) - (random 20));
	_unit03 setDir ((_unit03 getRelDir _unit01) - (random 20));
	_unit04 setDir ((_unit04 getRelDir _unit02) + (random 20));
};


// Ending
DK_fnc_endSelectWinner = {
	private "_nil";
	private _famsScore = [];
	{
		if ( ((side _x) isEqualTo west) OR (isPlayer (leader _x)) ) then{
			_nil = _famsScore pushBack [_x getVariable ["DK_familyScore", 0],	roleDescription ((units _x) # 0)];
		};
	} count allGroups;
	_famsScore sort false;
	_famsScore remoteExecCall ["DK_fnc_thisIsTheEnd", DK_isDedi];
	uiSleep 10;
	"EveryoneWon" call BIS_fnc_endMissionServer;
};


// Manage killed
DK_fnc_EH_entityKilled = {

	params ["_killed", "_killer", "_instigator"];


	_killed enableDynamicSimulation false;
	_killed enableSimulationGlobal true;

	if ( (!isPlayer _killed) && { !(side (group _killed) isEqualTo west)  } ) then
	{
		["HandleDamage", "Hit", "EpeContactStart", "FiredNear", "Dammaged"] apply
		{
			_killed removeAllEventHandlers _x;
		};
	};


	if (_killed isKindOf "LandVehicle") then
	{
		// Cancel JIP Repair
		private _idActRepair = _veh getVariable "DK_IDzltRepair";
		if (!isNil "_idActRepair") then
		{
			remoteExecCall ["", _idActRepair];
		};

		// Cancel JIP Flip
		private _idFlipJIP = _veh getVariable "idFlipJIP";
		if (!isNil "_idFlipJIP") then
		{
			remoteExecCall ["", _idFlipJIP];
		};

		// Cancel JIP Radio
		private _IdInitMP3car = _veh getVariable "NetIdInitMP3car";
		if (!isNil "_IdInitMP3car") then
		{
			remoteExecCall ["", _IdInitMP3car];
		};
	};


	if (isNull _instigator) then
	{
		_instigator = _killer
	};

	if ( (_instigator getVariable ["DK_side", ""] isEqualTo "civ") && { !(isNull objectParent _instigator) && { !(_instigator isEqualTo vehicle _instigator) } } ) then
	{
		private ["_nearCop", "_grp", "_nil"];
		private _nearestCops = _instigator nearEntities [["Car","Man"], 40];
		{
			_nearCop = driver _x;

			if (_nearCop getVariable ["DK_side", ""] isEqualTo "cops") then
			{
				if ( (!isNil "_grp") && { (_grp isEqualTo group _nearCop) } ) exitWith {};

				call
				{
					if (_nearCop getVariable ["DK_behaviour", ""] isEqualTo "chase") exitWith
					{
						private _grpEast = createGroup [east, true];
						[_instigator] join _grpEast;

						_instigator addRating -10000;
						_instigator setSpeedMode "FULL";
					};

					_grp = group _nearCop;
					private _veh = _nearCop getVariable "vehLinkRfr";

					call
					{
						// On Car
						if ((!isNil "_veh") && { (alive _veh) }) exitWith
						{
							deleteVehicle (_veh getVariable "DK_CLAG_trgAtch");
							_idEHs = _veh getVariable "DK_CLAG_idEHs";

							if (!isNil "_idEHs") then
							{
								_veh removeEventHandler ["EpeContactStart", _idEHs # 0];
								_veh removeEventHandler ["Hit", _idEHs # 3];
								_veh removeEventHandler ["GetIn", _idEHs # 2];
								_veh removeEventHandler ["HandleDamage", _idEHs # 1];
								_veh removeEventHandler ["FiredNear", _idEHs # 4];
							};

							_unitsCrew = units _nearCop;

							if (_unitsCrew isEqualTo []) exitWith {};

							_unitsCrew apply
							{
								_x removeAllEventHandlers "Hit";
								_x removeAllEventHandlers "FiredNear";
								_x setVariable ["DK_behaviour", "chase"];
							};

							_nil = [_unitsCrew, _veh, _instigator] spawn DK_fnc_startChase_CopsPatrol;
						};

						// On Foot
						_unitsCrew = units _nearCop;

						if (_unitsCrew isEqualTo []) exitWith {};

						_unitsCrew apply
						{
							_x removeAllEventHandlers "Hit";
							_x removeAllEventHandlers "FiredNear";
							_x setVariable ["DK_behaviour", "chase"];
						};

						_nil = [_unitsCrew, _instigator, _grp] spawn DK_loop_AiFollow_rfrFoot;
					};
				};
			};

		} count _nearestCops;
	};
};

DK_fnc_Eh_MPkilledVeh = {

	params ["_veh"];


	if (hasInterface) then
	{
		removeAllActions _veh;
		_veh removeAllEventHandlers "HandleDamage";
	};

	if (isServer) then
	{
		_veh setVariable ["cleanUpOn",true];
		DelInEmpV(_veh);
		DelInCUM(_veh);

		private _idActRepair = _veh getVariable "DK_IDzltRepair";
		if (!isNil "_idActRepair") then
		{
			remoteExecCall ["", _idActRepair];
		};

		private _idFlipJIP = _veh getVariable "idFlipJIP";
		if (!isNil "_idFlipJIP") then
		{
			remoteExecCall ["", _idFlipJIP];
		};
	};
};


// For BattleEye
DK_fnc_deleteVehicle = {

	deleteVehicle _this;
};


// THX KillzoneKid
if (isNil "KK_fnc_arrayShuffle") then
{
	KK_fnc_arrayShuffle = {

		private _cnt = count _this;

		for "_i" from 1 to _cnt do
		{
			_this pushBack (_this deleteAt floor random _cnt);
		};

		_this
	};
};

