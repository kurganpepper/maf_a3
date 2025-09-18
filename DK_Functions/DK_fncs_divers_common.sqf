// OTHER
DK_fnc_setHitPoint = {

	params ["_veh", "_hitPoint", "_hitLvl"];


	_veh setHitPointDamage [_hitPoint, _hitLvl];
};

DK_fnc_setHit = {

	params ["_veh", "_hitPoint", "_hitLvl"];


	_veh setHit [_hitPoint, _hitLvl];
};

DK_fnc_setVelModelSpace = {

	params ["_vehicle", "_velSpace1", "_velSpace2", "_velSpace3"];


	_vehicle setVelocityModelSpace [_velSpace1, _velSpace2, _velSpace3];
};

DK_fnc_setVehLock = {

	params ["_vehicle", "_statelock"];


	_vehicle setVehicleLock _statelock;
};

DK_fnc_setFuel = {

	params ["_vehicle", "_fuelLvl"];


	_vehicle setFuel _fuelLvl;
};

DK_fnc_allowDmg = {

	params ["_object", "_allow"];


	_object allowDamage _allow;
};

DK_fnc_randomLip = {

	params ["_unit", "_time", "_nil"];


	private _nearPlyrs = [];
	{
		if (_x distance2D _unit < 50) then
		{
			_nil = _nearPlyrs pushBackUnique _x;
		};

//	} forEach playableUnits;
	} count playableUnits;

	if (_nearPlyrs isEqualTo []) exitWith {};

	[_unit, _time] remoteExecCall ["DK_fnc_randomLip_cl", _nearPlyrs];
};


DK_fnc_flipVeh = {

	_this spawn
	{
		_this allowdamage false;

		_this setPosATL (getPosATLVisual _this vectorAdd [0,0,1.5]);

		uiSleep 0.02;

		_this setVectorUp [0,0,1];

		uiSleep 1;

		_this allowdamage true;
	};
};