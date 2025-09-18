if !(hasInterface) exitWith {};

pierremgi_fnc_otherUnif = {
	params ["_type","_return"];
	if (_type == 0) exitWith {
		MGI_button = _return select 1; false
	};
		if (_type == 1 and !isnil "MGI_button" && {MGI_button == 1}) then {
		disableSerialization;
		_control = _return select 0;
		_index = _return select 1;
		private _idc = ctrlIDC _control;
		private _text = lbText [_idc, _index];
		private _picture = lbPicture [_idc,_index];
		private _uniforms = ("getText (_x >> 'displayName') == _text && getNumber (_x >> 'ItemInfo' >> 'type') == 801" configClasses (configFile >> "CfgWeapons"));
		if (count _uniforms > 0) then {
				[_idc,_text,_picture,_index,_uniforms] spawn {
				params ["_idc","_text","_picture","_index","_uniforms","_selectedUnif","_unifContClasses",["_uniformObject",objNull],["_selectedInvent",[]],"_items","_otherItems","_g0"];
				_currentUnif = uniform player;
				_currentInvent = uniformItems player;
				_selectedUnif = ((_uniforms select {toLower (gettext (_x >> "picture")) splitString "\"joinString "\" == _picture}) apply {configName _x}) select 0;

				if !(pl_container isKindOf "CAManBase") then {
					_unifContClasses = (
						everyContainer pl_container select {
							(_x select 0) select [0,2] == "U_" or 
							["_U_",(_x select 0)] call bis_fnc_instring or 
							["uniform",(_x select 0)] call bis_fnc_instring
						});
					_cnt = 0;
					for "_i" from 0 to _index do {
						if (lbText [_idc,_i] == _text) then {
							_cnt = _cnt +1;
							_uniformObject = _unifContClasses select {_selectedUnif == (_x select 0)} select (_cnt -1) select 1
						};
					};
				} else {
					_uniformObject = uniformContainer pl_container
				};
				_selectedInvent = [];
				{_selectedInvent pushback _x} foreach (itemCargo _uniformObject);
				if ( !(isNil "_uniformObject") && {!(_uniformObject isEqualTo objNull) && {(magazineCargo _uniformObject isEqualType [])}}) then {
					{_selectedInvent pushback _x} foreach (magazineCargo _uniformObject);
				};
				if !(pl_container isKindOf "CAmanbase") then {
					_items = +itemCargo pl_container;
					_unifItems = _unifContClasses apply {_x select 0};
					_vestContClasses = (everyContainer pl_container select { (_x select 0) select [0,2] == "V_"});
					_vestItems = _vestContClasses apply {_x select 0};
					_otherItems = +_items - _unifItems - _vestItems;
					pl_container setVariable ["allconts",_unifContClasses+_vestContClasses];
					for "_i" from 0 to count (_unifContClasses+_vestContClasses) -1 do {
						if (((pl_container getVariable "allconts") select _i) select 1 == _uniformObject) exitWith {
							(pl_container getVariable "allconts") deleteAt _i
						};
					};
					pl_container setVariable ["allconts", +(pl_container getVariable "allconts") apply {[_x select 0, itemCargo (_x select 1), magazineCargo (_x select 1)]}];
					_g0 = pl_container;
					clearItemCargoGlobal _g0;
				} else {
					_g0 = createVehicle ["WeaponHolderSimulated_Scripted", (player modelToWorld [0,1,1]), [], 0, "CAN_COLLIDE"]
				};
				player forceAddUniform _selectedUnif;
				{player addItemToUniform _x} forEach _selectedInvent;
				call {
					if (pl_container isKindOf "CAManBase") exitWith {
						removeUniform pl_container
					};
					{
						_x params ["_cont",["_it",[]],["_mag",[]]];
						pl_container addItemCargoGlobal [_cont,1];
						_createdCont = pl_container call MGI_lastCont;
						{_createdCont addItemCargoGlobal [_x,1];true} count _it;
						{_createdCont addMagazineCargoGlobal [_x,1];true} count _mag;
					} forEach (pl_container getVariable ["allconts",[]]);
					{_g0 addItemCargoGlobal [_x,1]} forEach _otherItems;
				};
				_g0 addItemCargoGlobal [_currentUnif,1];
				_lastCont = _g0 call MGI_lastCont;
				{_lastCont addItemCargoGlobal [_x,1]} forEach _currentInvent;
				if (
					_g0 isKindOf "WeaponHolderSimulated" && 
					{(count itemCargo _g0 + count magazineCargo _g0 + count weaponCargo _g0 + count backpackCargo _g0) == 0}
				) then {
					deleteVehicle _g0
				};
			};
		};
	};
	MGI_button = 0; false
};

DK_fnc_checkIfNight_cl = {
	_daytime = daytime;
	((_daytime < 5) OR (_daytime > 19))
};

DK_fnc_randomLip_cl = {
	params ["_unit", ["_time", 2]];
	_unit setRandomLip true;
	[_unit, _time] spawn
	{
		params ["_unit", "_time"];
		uiSleep _time;
		if ((isNil "_unit") OR (isNull _unit) OR (!alive _unit)) exitWith {};
		_unit setRandomLip false;
	};
};

DK_fnc_removeEhHd_cl = {
	_this removeAllEventHandlers "HandleDamage";
};


DK_fnc_Horn_CopsPatrol_cl = {
	_this spawn{
		params ["_veh", "_array1", "_array2", "_array3", "_array4"];
		if !(alive _veh) exitWith {};
		_veh animateSource ["Beacons", 1];
		if (!isNil "_array4") exitWith{
			private _can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array1 # 0, 530, 1, true];
			uiSleep (_array1 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

			_can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array2 # 0, 530, 1, true];
			uiSleep (_array2 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

			_can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array3 # 0, 530, 1, true];
			uiSleep (_array3 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

			_can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array4 # 0, 530, 1, true];
			uiSleep (_array4 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};


			_veh animateSource ["Beacons", 0];
		};

		if (!isNil "_array3") exitWith{
			private _can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array1 # 0, 530, 1, true];
			uiSleep (_array1 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

			_can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array2 # 0, 530, 1, true];
			uiSleep (_array2 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

			_can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
			hideObject _can;
			_can attachTo [_veh, [0,0,0]];
			_can say3D [_array3 # 0, 530, 1, true];
			uiSleep (_array3 # 1);
			deleteVehicle _can;
			if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

			_veh animateSource ["Beacons", 0];
		};

		private _can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
		hideObject _can;
		_can attachTo [_veh, [0,0,0]];
		_can say3D [_array1 # 0, 530, 1, true];
		uiSleep (_array1 # 1);
		deleteVehicle _can;
		if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

		_can = createSimpleObject ["Land_Can_V1_F", [0,0,0], true];
		hideObject _can;
		_can attachTo [_veh, [0,0,0]];
		_can say3D [_array2 # 0, 530, 1, true];
		uiSleep (_array2 # 1);
		deleteVehicle _can;
		if ( (isNil "_veh") OR (isNull _veh) OR (!alive _veh) OR (!alive driver _veh) ) exitWith {};

		_veh animateSource ["Beacons", 0];
	};
};


DK_add_HUD_wantedLvl_cl = {
	if (DK_wantedLvl_Loop) exitWith {};
	DK_wantedLvl_Loop = true;
	[] spawn{
		private ["_cops", "_nil", "_aliveC"];
		while {
			(alive player) && 
			{
				!(lifeState player isEqualTo "INCAPACITATED") && 
				{
					!((player getVariable ["wantedLvl", []]) findIf {alive _x} isEqualTo -1) && 
					{
						(missionNamespace getVariable ["wantedMissionLvl_cl", 0] isEqualTo 0)
					}
				}
			}
		} do {
			_cops = player getVariable ["wantedLvl", []];
			[DK_vTxt_wtd_wtd, -1,  safeZoneY + safeZoneH - 0.33, 4, 0, 0, DK_lyDyn_rfr] spawn BIS_fnc_dynamicText;
			call{
				if (
					!(_cops findIf {(_x getVariable ["DK_side", ""]) isEqualTo "army" } isEqualTo -1) OR 
					!(_cops findIf {((typeOf (vehicle _x)) isEqualTo "I_Heli_light_03_dynamicLoadout_F")} isEqualTo -1)
				) exitWith{
					[DK_vTxt_wtd_strs + "* * * * *", -1,  safeZoneY + safeZoneH - 0.295, 4, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;
				};

				if !(_cops findIf {(_x getVariable ["DK_side", ""]) isEqualTo "fbi" } isEqualTo -1) exitWith{
					[DK_vTxt_wtd_strs + "* * * *", -1,  safeZoneY + safeZoneH - 0.295, 4, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;
				};

				_aliveC = {alive _x} count _cops;
				if ((_aliveC > 7) OR !(_cops findIf {((typeOf (vehicle _x)) isEqualTo "B_Heli_Light_01_F")} isEqualTo -1)) exitWith{
					[DK_vTxt_wtd_strs + "* * *", -1,  safeZoneY + safeZoneH - 0.295, 4, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;
				};

				if ( _aliveC > 3 ) exitWith{
					[DK_vTxt_wtd_strs + "* *", -1,  safeZoneY + safeZoneH - 0.295, 4, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;
				};
				[DK_vTxt_wtd_strs + "*", -1,  safeZoneY + safeZoneH - 0.295, 4, 0, 0, DK_lyDyn_Stars] spawn BIS_fnc_dynamicText;
			};

			uiSleep 0.5;

			{
				if ( (isNil "_x") OR (isNull _x) OR (!alive _x) ) then{
					_nil = _cops deleteAt (_cops find _x);
				};
			} count _cops;

			player setVariable ["wantedLvl", _cops, true];
			uiSleep 2;

			if ((player getVariable ["wantedLvl", []]) findIf {alive _x} isEqualTo -1) then{
				uiSleep 3;
			};
		};
		DK_wantedLvl_Loop = false;
	};
};


DK_allowPlane_cl = {

	// Pilot
	_this addAction ["Сесть в " + (getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "displayName")) + " как Пилот",
	{
		params ["_target", "_caller"];
		moveOut _caller;
		_caller moveInDriver _target;

	}, nil, 6, true, true, "", "(isNull objectParent player) OR (objectParent player isEqualTo _target) && { !((locked _target) isEqualTo 2) && { (alive _target) && { (isNull (driver _target)) } } }", 4];

	// Co-Pilot
	_this addAction [
		"Сесть в " + (getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "displayName")) + " как второй Пилот",
		{
			params ["_target", "_caller"];


			moveOut _caller;
			_caller moveInTurret [_target, [0]];

		}, 
		nil, 6, true, true, "", 
		"
			(isNull objectParent player) OR 
			(objectParent player isEqualTo _target) && 
			{
				!((locked _target) isEqualTo 2) && 
				{
					(alive _target) && 
					{
						((((fullCrew [_target, 'turret', true]) # 0) # 0) isEqualTo objNull) OR 
						(!alive (((fullCrew [_target, 'turret', true]) # 0) # 0))
					}
				}
			}
		", 
		4
	];
};

DK_allowBoat_cl = {
	_this addAction [
		"Сесть в " + (getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "displayName")) + " как водитель",
		{
			params ["_target", "_caller"];


			moveOut _caller;
			_caller moveInDriver _target;

		}, nil, 6, true, true, "", "(isNull objectParent player) OR (objectParent player isEqualTo _target) && { !((locked _target) isEqualTo 2) && { (alive _target) && { (isNull (driver _target)) } } }", 4
	];
};

DK_allowTract_cl = {
	_this addAction [
		"Сесть в " + (getText (configFile >> "CfgVehicles" >> (typeOf _this) >> "displayName")) + " как водитель",
		{
			params ["_target", "_caller"];
			_caller moveInDriver _target;
		}, nil, 6, true, true, "", "(isNull objectParent player) OR (objectParent player isEqualTo _target) && { !((locked _target) isEqualTo 2) && { (alive _target) && { (isNull (driver _target)) } } }", 2.3
	];
};


// Events handlers player
DK_fnc_killed_cl = {
	params ["_unit", "_killer", "_instigator"];

	//DK_lyDyn_tips cutText ["","PLAIN",0];//Советы

	if (
		((isNil "_instigator") OR (isNull _instigator) OR (_instigator isEqualTo "")) && 
		{!(isNil "_source") && {(!isNull _source) && {!(_source isEqualTo "")}}}) then {
		_instigator = _killer;
	};

	call{
		if ((side (group _instigator) isEqualTo west) OR (isPlayer _instigator)) then{
			if (_instigator isEqualTo _unit) exitWith {};
			if (group _instigator isEqualTo group _unit) exitWith{
				[DK_vTxt_killedByFr + (name _instigator), -1, safezoneH - 1.288, 10, 0, 0, DK_lyDyn_suicide] spawn BIS_fnc_dynamicText;
			};
			[DK_vTxt_killedByEn + (name _instigator), -1, safezoneH - 1.288, 10, 0, 0, DK_lyDyn_suicide] spawn BIS_fnc_dynamicText;
		};
	};


	[] spawn{
		waitUntil {playerRespawnTime > 1};
		call{
			private _nbPly = count allplayers;
			if ( (_nbPly > 3) && { (_nbPly < 13) } ) exitWith{
				setPlayerRespawnTime 13;
			};
			if (_nbPly > 12) exitWith{
				setPlayerRespawnTime 15;
			};
			setPlayerRespawnTime 11;
		};

		if !(DK_thisIsFirstStarting) then{
			uiSleep 5.1;
			//call DK_MTW_fnc_Tips_cl;//
		};
	};

	if !((DK_mkrs_spawnProtect findIf { _unit inArea _x; }) isEqualTo -1) then{
		moveOut _unit;
	};

	player setVariable ["DK_isICPCT", false];
	player setVariable ["wantedLvl", [], true];
	player setVariable ["hitSlp", false];
	player setVariable ["timeEhHD", nil];
};

DK_fnc_handleDmg_cl = {
	params ["_unit", "_hitSlct", "_dmgTotal", "_source", "_proj", "_hitPrtId", "_insti"];
	private _proType = typeName _proj;

	if ((isNil "_insti") OR (isNull _insti) OR (_insti isEqualTo "")) then{
		call{
			if ( !(isNil "_source") && { (!isNull _source) && { !(_source isEqualTo "") } } ) exitWith{
				_insti = _source;
			};
			if (_proType isEqualTo "OBJECT") then{
				(getShotParents _proj) params ["", "_instiBis"];
			};
			if (!isNil "_instiBis") then{
				_insti = _instiBis;
			};
		};
	};

	private "_dmgInit";
	private _secureEnd = true;

	call{
		// Reduc Damage
		call{
			if (_hitSlct isEqualTo "") exitWith{
				_dmgInit = damage _unit;
			};
			_dmgInit = _unit getHit _hitSlct;
		};

		if ((lifeState player isEqualTo "INCAPACITATED") && {(time < player getVariable ["timeEhHD", time + 1])}) exitWith{
			player setVariable ["timeEhHD", time + 1];
			_secureEnd = false;
			_dmgInit;
		};

		call{
			// Manage C4 damage
			if ((_proType isEqualTo "OBJECT") && {(_proj in ["DemoCharge_Remote_Ammo", "SatchelCharge_Remote_Ammo"])}) exitWith{
				_dmgInit = _dmgTotal;
			};

			private _grpInst = group _insti;

			if (side _grpInst isEqualTo west) exitWith{
				if (_grpInst isEqualTo group player) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2.2);
				};

				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgTotal;
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2.2);
			};

			private _vehInst = objectParent _insti;


			if (
				!(_grpInst isEqualTo group player) && 
				{
					(_insti isKindOf "Man") && 
					{
						(!isNull _vehInst) && 
						{
							(driver _vehInst isEqualTo _insti) && 
							{(_vehInst isKindOf "Car")}
						}
					}
				}) exitWith{
				_dmgInit;
			};

			private _shooterSide = _insti getVariable ["DK_side", ""];

			if (_shooterSide isEqualTo "cops") exitWith{
				if !(handgunWeapon _insti isEqualTo "") exitWith{
					if (_hitPrtId in [0,2]) exitWith{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 10);
					};
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 5);
				};

				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 12);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 6);
			};

			if (_shooterSide in ["mis_Looter", "mis_thug"]) exitWith{
				if !(handgunWeapon _insti isEqualTo "") exitWith{
					if (_hitPrtId in [0,2]) exitWith{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 9);
					};
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 4);
				};

				if (primaryWeapon _insti in ["sgun_HunterShotgun_01_F", "sgun_HunterShotgun_01_sawedoff_F"]) exitWith{
					if (_hitPrtId in [0,2]) exitWith{
						_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 14);
					};
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 8);
				};

				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 12);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 6);
			};

			if (_shooterSide isEqualTo "mis_thug2") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 13);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 6.5);
			};

			if (_shooterSide isEqualTo "mis_ballas") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 11.8);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 5.9);
			};

			if (_shooterSide isEqualTo "mis_ballas2") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 16);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 8);
			};

			if (_shooterSide isEqualTo "mis_triads") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 11.8);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 5.9);
			};

			if (_shooterSide isEqualTo "mis_triads2") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 16);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 8);
			};

			if (_shooterSide isEqualTo "mis_domi") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 16);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 8.5);	// 8
			};

			if (_shooterSide isEqualTo "mis_alban") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 16);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 8.5);	// 8
			};

			if (_shooterSide isEqualTo "fbi") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 15);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 7.5);
			};

			if (_shooterSide isEqualTo "army") exitWith{
				if (_hitPrtId in [0,2]) exitWith{
					_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 16);
				};
				_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 8);
			};

			if (_insti getVariable ["DK_behaviour", ""] isEqualTo "bandit") exitWith{
				if (lifeState player isEqualTo "INCAPACITATED") exitWith{
					_dmgInit;
				};
				_dmgInit = _dmgInit + 0.01;
			};
			_dmgInit = _dmgInit + ((_dmgTotal - _dmgInit) / 2);
		};
		_dmgInit
	};


	if (_secureEnd && {!(_hitPrtId isEqualTo -1) && {(_dmgInit > 0.8)}}) then{
		_dmgInit = 0.8;
	};

	// Check for allow healing
	if ((isNil "DK_idActionPlayerHeal_Local") && {(_dmgTotal > 0.085)}) then{
		call DK_addAction_playerHeal;
	};
	_dmgInit
};

DK_fnc_damaged_cl = {
	params ["_unit", "", "", "", "_hitPoint", "_instigator", "_projectile"];

//	if (!alive player) exitWith {};
	if (!alive _unit) exitWith {};

	// Manage Bonus Ambulance : Thx Larrow from BIS forum <3
	if (
		!(player getVariable ["DK_isICPCT",false]) && {
			(player getVariable ["#rev_enabled", false]) && 
			{(_hitPoint == "Incapacitated") && {(player getVariable ["#rev_state", 0] isEqualTo 2)}}
		}) exitWith {
		[_instigator, _projectile] call DK_fnc_damaged_a_cl;
	};
	[_instigator, _projectile] call DK_fnc_damaged_b_cl;
};

DK_fnc_damaged_a_cl = {
	params ["_instigator", "_projectile"];
	player setVariable ["DK_isICPCT", true];
	player setVariable ["wantedLvl", [], true];
	player setVariable ["timeEhHD", time + 1];

	if (!isNil "DK_idActionPlayerHeal_Local") then {
		[player, DK_idActionPlayerHeal_Local] call BIS_fnc_holdActionRemove;
		DK_idActionPlayerHeal_Local = nil;
	};

	player remoteExecCall ["DK_fnc_bonus_amb_verifMoney",2];

	// Reset
	[] spawn{
		uiSleep 0.5;
		waitUntil { !(lifeState player isEqualTo "INCAPACITATED") };
		call DK_addAction_playerHeal;

		player setVariable ["DK_isICPCT", false];
		player setVariable ["timeEhHD", nil];
	};


	// Killfeed Incapacitated
	if (typeName _projectile isEqualTo "OBJECT") then{
		(getShotParents _projectile) params ["", "_instigatorBis"];
	};

	if ((player isEqualTo _instigator) OR ((!isNil "_instigatorBis") && {(player isEqualTo _instigatorBis)})) exitWith {};

	private _grpInst = group _instigator;
	private _grpPlayer = group player;
	private _rolePlayer = roleDescription player;

	if (side _grpInst isEqualTo west) exitWith{
		private _player = player;

		// Killfeed Hud
		[_instigator, _player, DK_vTxt_INC_KF] remoteExecCall ["DK_fnc_hdlPlyKF", 2];

		// Wounded Hud
		if ((_grpInst isEqualTo _grpPlayer) OR ((roleDescription _instigator) isEqualTo _rolePlayer)) exitWith{
			[_player, _instigator] remoteExecCall ["DK_fnc_wndd_Fr_Dwn", _instigator];
			[DK_vTxt_incaByFr + (name _instigator), -1, safezoneH - 1.288, 10, 0, 0, DK_lyDyn_suicide] spawn BIS_fnc_dynamicText;
			[_instigator, -25] remoteExecCall ["DK_fnc_addScr", 2];
			[_instigator, 1] remoteExecCall ["DK_fnc_tabScr", 2];
		};
		[_player, _instigator] remoteExecCall ["DK_fnc_wndd_En_Dwn", _instigator];
		[DK_vTxt_incaByEn + (name _instigator), -1, safezoneH - 1.288, 10, 0 ,0, DK_lyDyn_suicide] spawn BIS_fnc_dynamicText;
		[_instigator, 15] remoteExecCall ["DK_fnc_addScr", 2];
		//[_instigator, 1] remoteExecCall ["DK_fnc_tabScr", 2];
	};

	if (isNil "_instigatorBis") exitWith {};
	private _grpInstBis = group _instigatorBis;
	if (side _grpInstBis isEqualTo west) then{
		private _player = player;
		// Killfeed Hud
		[_instigatorBis, _player, DK_vTxt_INC_KF] remoteExecCall ["DK_fnc_hdlPlyKF", 2];

		// Wounded Hud
		if ((_grpInstBis isEqualTo _grpPlayer) OR ((roleDescription _instigatorBis) isEqualTo _rolePlayer)) exitWith{
			[_player, _instigatorBis] remoteExecCall ["DK_fnc_wndd_Fr_Dwn", _instigatorBis];
			[DK_vTxt_incaByFr + (name _instigatorBis), -1, safezoneH - 1.288, 10, 0, 0, DK_lyDyn_suicide] spawn BIS_fnc_dynamicText;
			[_instigatorBis, -25] remoteExecCall ["DK_fnc_addScr", 2];
			[_instigatorBis, 1] remoteExecCall ["DK_fnc_tabScr", 2];
		};
		[_player, _instigatorBis] remoteExecCall ["DK_fnc_wndd_En_Dwn", _instigatorBis];
		[DK_vTxt_incaByEn + (name _instigatorBis), -1, safezoneH - 1.288, 10, 0 ,0, DK_lyDyn_suicide] spawn BIS_fnc_dynamicText;
		[_instigatorBis, 15] remoteExecCall ["DK_fnc_addScr", 2];
		//[_instigatorBis, 1] remoteExecCall ["DK_fnc_tabScr", 2];
	};
};

DK_fnc_damaged_b_cl = {
	params ["_instigator", "_projectile"];

	// Killfeed Hit
	(getShotParents _projectile) params ["", "_instigatorBis"];

	if (
		(player getVariable ["hitSlp", false]) OR 
		(player isEqualTo _instigator) OR 
		((!isNil "_instigatorBis") && {(player isEqualTo _instigatorBis)} )
	) exitWith {};


	private _grpInst = group _instigator;
	private _grpPlayer = group player;
	private _rolePlayer = roleDescription player;

	if (side _grpInst isEqualTo west) exitWith{
		call DK_fnc_damagedHitRdy_cl;
		private _player = player;

		if ((_grpInst isEqualTo _grpPlayer) OR ((roleDescription _instigator) isEqualTo _rolePlayer)) exitWith{
			[_player, _instigator] remoteExecCall ["DK_fnc_wndd_Fr_hit", _instigator];
			[_instigator, -1] remoteExecCall ["DK_fnc_addScr",2];
		};
		[_player, _instigator] remoteExecCall ["DK_fnc_wndd_En_hit", _instigator];
	};

	if (isNil "_instigatorBis") exitWith {};
	private _grpInstBis = group _instigatorBis;
	if (side _grpInstBis isEqualTo west) then{
		call DK_fnc_damagedHitRdy_cl;
		private _player = player;
		if ((_grpInstBis isEqualTo _grpPlayer) OR ((roleDescription _instigatorBis) isEqualTo _rolePlayer)) exitWith{
			[_player, _instigatorBis] remoteExecCall ["DK_fnc_wndd_Fr_hit", _instigatorBis];
			[_instigatorBis, -1] remoteExecCall ["DK_fnc_addScr", 2];
		};
		[_player, _instigatorBis] remoteExecCall ["DK_fnc_wndd_En_hit", _instigatorBis];
	};
};

DK_fnc_damagedHitRdy_cl = {
	player setVariable ["hitSlp", true];

	[] spawn{
		uiSleep 0.02;
		player setVariable ["hitSlp", false];
	};
};

DK_fnc_MPkilled_cl = {
	params ["_killed", "_killer"];
	removeAllActions _killed;
	if (player isEqualTo _killed) then{
		DK_idActionJacobWeapon_Local = nil;
	};
};


// Flip all veh
DK_addAction_flipVeh = {
	if (!isNil {_this getVariable "idFlip"}) exitWith {};
	private _idFlip = _this addAction  [
		DK_vTxt_colorTake + "Перевернуть",
		{
			_this params ["_veh"];
			_veh remoteExecCall ["DK_fnc_flipVeh", _veh];
		} ,
		nil,2,true,true,"",
		"_target call DK_fnc_condActionFlipVeh",
		7
	];
	_this setVariable ["idFlip", _idFlip];
};

DK_fnc_condActionFlipVeh = {
	(isNull (objectParent player)) && {
		(cursortarget isEqualTo _this) && {
			(!alive driver _this) && {
				(crew _this findIf {alive _x} isEqualTo -1) && {
					(speed _this > -1) && {
						((vectorUp _this) vectorCos (surfaceNormal getPos _this) < 0.8) && {
							(speed _this < 1) && 
							{((_this nearEntities [["Man"], 4]) - [player] findIf {(side (group _x) isEqualTo west)} isEqualTo -1)}
}}}}}}};

DK_fnc_hide = {
	params ["_object", ["_hide", true]];
	_object hideObject _hide;
};



DK_fnc_repairAir = {
	private _idActionOld = _this getVariable "DK_idActRepair";
	if !(isNil "_idActionOld") then{
		_this removeAction _idActionOld;
	};
	private _idAction = _this addAction [
		"Ремонт" + "</t>", 
		{params ["_target"]; _target call zltDK_fnc_doRepair }, 
		[], -3, false, true, '', 
		"_target call zltDK_fnc_repairCond", 10, false
	];
	_this setVariable ["zltDisMax", 10.5];
	_this setVariable ["DK_idActRepair", _idAction];
};


// EVENTS
DK_fnc_event01_cl = {
	if ( (isNil "_this") OR (isNull _this) ) exitWith {};
	_this spawn{
		if ((isNil "_this") OR (isNull _this)) exitWith {};
		private _isLand = _this isKindOf "LandVehicle";
		// Marker at Bonus stuff
		private _mkr = createMarkerLocal [str (random 1000), _this];
		call{
			if _isLand exitWith{
				_mkr setMarkerTypeLocal "mil_box";
			};
			_mkr setMarkerTypeLocal "mil_triangle";
		};
		_mkr setMarkerColorLocal "ColorKhaki";
		_mkr setMarkerSizeLocal [1.1,1.1];

		call{
			private _time = time + 240;
			if _isLand exitWith{
				while {
					(!isNil "_this") && {
						(!isNull _this) && {
							(alive _this) && {
								(time < _time) && {
									(crew _this findIf {alive _x} isEqualTo -1)
				}}}}} do {
					uiSleep 0.5;
					_mkr setMarkerPosLocal _this;
				};
			};

			while {(!isNil "_this") && {(!isNull _this) && {(alive _this) && {(time < _time)}}}} do {
				uiSleep 0.5;
				_mkr setMarkerPosLocal _this;
			};
		};
		deleteMarkerLocal _mkr;
	};
};

DK_fnc_customChat_cl = {
	_this spawn{
		params [["_channelID", "fuck"], "_theme"];
		if ((_channelID isEqualTo "fuck") OR {(isNil "_theme")}) exitWith {};
		switch (_theme) do{
			case "Бонусный самолет" :{
				_channelID radioChannelAdd [player];
				player customChat [_channelID, "Похоже, с армейским самолётом, перевозившим военные грузы, произошла небольшой 'авария'. Будьте первым, кто получит выгоду."];
			};
			case "LJ Welcome" :{
				waitUntil {(alive player)};
				_channelID radioChannelAdd [player];
				player customChat [_channelID, "Привет чувак, Петрович мне о тебе рассказывал. Похоже ты надёжный человек. Могу предоставить разное дешёвое оружие. Звони когда понадобится, но и моё время не трать зря, у меня есть и другие клиенты, сам знаешь... ДЕЛА"];
			};
		};
		playSound ["SMS", true];
		uiSleep 0.5;
		_channelID radioChannelRemove [player];
	};
};

//NEW
// Советы

/*
DK_tip01 = {
	[DK_vTxt_Tips + "1<br/>" + "<t size = '.55' color='#FFFFFF'>Если враги убегают на машине, преследуйте их или двигайесь рядом с их машиной, чтобы заставить их остановиться.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip02 = {
	[DK_vTxt_Tips + "2<br/>" + "<t size = '.55' color='#FFFFFF'>При скорости ниже 80 км/ч вы можете безопасно выйти из автомобиля.<br/>Выпрыгнуть на большей скорости все еще возможно, но на свой страх и риск.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip03 = {
	[DK_vTxt_Tips + "3<br/>" + "<t size = '.55' color='#FFFFFF'>каскадерские прыжки<br/>дают деньги и очки для вашей семьи со скорости 100 км/ч.<br/>Только один раз.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip04 = {
	[DK_vTxt_Tips + "4<br/>" + "<t size = '.55' color='#FFFFFF'>Полицейские машины часто оснащены штурмовыми винтовками.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip05 = {
	[DK_vTxt_Tips + "5<br/>" + "<t size = '.55' color='#FFFFFF'>Стрельба по гражданским транспортным средствам зачастую может заставить их остановить свою машину.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip06 = {
	[DK_vTxt_Tips + "6<br/>" + DK_vTxt_colorRescue + "<t size = '.55'>Желтый " + "<t color='#FFFFFF'>квадрат представляет места, где " + DK_vTxt_colorTake + "фиолетовые " + "<t color='#FFFFFF'>цели должны быть сброшены.<br/>Только " + DK_vTxt_colorTake + "фиолетовый " +  "<t color='#FFFFFF'>водитель может видеть пункт назначения, отмеченный в " + DK_vTxt_colorRescue + "желтый <br/>" + "<t color='#FFFFFF'>на вашей карте и игровые 3D-маркеры зоны высадки.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip07 = {
	[DK_vTxt_Tips + "7<br/>" + "<t size = '.55' color='#FFFFFF'>Если вам нравятся большие взрывы, попробуйте найти бензовозы/газовозы..", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip08 = {
	[DK_vTxt_Tips + "8<br/>" + "<t size = '.55' color='#FFFFFF'>Если вы слышите полицейские сирены, значит, на дежурстве находится полицейский патруль, которому разрешено стрелять без предупреждения.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip09 = {
	[DK_vTxt_Tips + "9<br/>" + "<t size = '.55' color='#FFFFFF'>Вся техника может быть отремонтирована на месте в любое время.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip10 = {
	[DK_vTxt_Tips + "10<br/>" + "<t size = '.55' color='#FFFFFF'>Если во время миссии '" + DK_vTxt_colorTake + "Угнать " + "<t color='#FFFFFF'>технику и " + DK_vTxt_colorRescue + "Передать" + "<t color='#FFFFFF'>' у вас есть товарищ по команде ,<br/>ремонтный автомобиль может быть очень полезен.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip11 = {
	[DK_vTxt_Tips + "11<br/>" + "<t size = '.55' color='#FFFFFF'>Вы можете переупаковать магазины нажав " + "<t color='#008C19'> Ctrl + R.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip12 = {
	[DK_vTxt_Tips + "12<br/>" + "<t size = '.55' color='#FFFFFF'>Цвет ящиков с наградами дает представление о их ценности.:" + "<br/><t align='left'>																  > Уровень 1 - это " + "<t color='#dadada'>Светло-серый" + "<br/><t align='left' color='#FFFFFF'>																  > Уровень 2 - это " + "<t color='#9b9355'>Оливковый" + "<br/><t align='left' color='#FFFFFF'>																  > Уровень 3 - это " + "<t color='#8e653f'>Коричневый" + "<br/><t align='left' color='#FFFFFF'>																  > Уровень 4 - это " + "<t color='#585953'>Темно-серый/чёрный" + "<br/><t align='left' color='#FFFFFF'>																  > Уровень 5 - это " + "<t color='#52664a'>Тропический зеленый", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip13 = {
	[DK_vTxt_Tips + "13<br/>" + "<t size = '.55' color='#FFFFFF'>Бронежилеты полицейских обеспечат лучшую защиту чем те, которые используют мафиози.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip14 = {
	[DK_vTxt_Tips + "14<br/>" + "<t size = '.55' color='#FFFFFF'>Оружие с глушителем позволяет вам поражать цели, не будучи обнаруженным.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip15 = {
	[DK_vTxt_Tips + "15<br/>" + "<t size = '.55' color='#FFFFFF'>Вам доступны несколько услуг:" + "<br/><t align='left'>			> Маленький Джейкоб может предоставить вам оружие(от 250 личных очков)" + "<br/><t align='left'>			> Медики могут спасти вашу жизнь (35$)" + "<br/><t align='left'>			> Ваш стартовый автомобиль может получить систему СЗА(система закиси азота), если ваши личные очки не отрицательные." + "<br/><t align='left'>			> Военный сброс", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};

DK_tip16 = {
	[DK_vTxt_Tips + "16<br/>" + "<t size = '.55' color='#FFFFFF'>Первая страница, доступная через" + "<t size = '.55' color='#01cbc2'> 'P'" + "<t size = '.55' color='#FFFFFF'> клавиша(по умолчанию) показывает количество убитых вражеских игроков.", safeZoneX + safeZoneW - 1.4 * 3 / 4,  safeZoneY + safeZoneH - 1.02, 49, 0, 0, DK_lyDyn_tips] spawn BIS_fnc_dynamicText;
};
*/


//#define tips [DK_tip01, DK_tip02, DK_tip03, DK_tip04, DK_tip05, DK_tip06, DK_tip07, DK_tip08, DK_tip09, DK_tip10, DK_tip11, DK_tip12, DK_tip13, DK_tip14, DK_tip15, DK_tip16]

//DK_tips = +tips;

/*
DK_MTW_fnc_Tips_cl = {
	private _tip = selectRandom DK_tips;
	private _nul = DK_tips deleteAt (DK_tips find _tip);

	if (DK_tips isEqualTo []) then{
		DK_tips = +tips;
		_nul = DK_tips deleteAt (DK_tips find _tip);
	};
	call _tip;
};
*/