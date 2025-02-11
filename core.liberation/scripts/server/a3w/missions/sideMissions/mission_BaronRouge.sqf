if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_leader"];

_setupVars = {
	_missionType = "STR_BARON_ROUGE";
	_locationsArray = nil; // locations are generated on the fly from towns
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	if (count sectors_bigtown <= 1) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_missionPos = markerPos (selectRandom sectors_bigtown);
	_vehicleClass = "";
	if (count a3w_br_planes == 0) then {
		_vehicleClass = selectRandom (opfor_air select { _x isKindOf "Plane" });
	} else {
		_vehicleClass = selectRandom a3w_br_planes;
	};
	if (isNil "_vehicleClass") exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find vehicle class!", localize _missionType];
    	false;
	};

	_aiGroup = createGroup [GRLIB_side_enemy, true];
	_aiGroup setFormation "WEDGE";
	_aiGroup setBehaviourStrong "AWARE";
	_aiGroup setCombatMode "YELLOW";
	_aiGroup setSpeedMode "FULL";

	[_aiGroup] call F_deleteWaypoints;
	private _path = (sectors_bigtown call BIS_fnc_arrayShuffle) select [0,5];
	{
		_waypoint = _aiGroup addWaypoint [markerPos _x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointCompletionRadius 500;
		_waypoint setWaypointFormation "WEDGE";
	} forEach _path;

	_wp0 = waypointPosition [_aiGroup, 0];
	_waypoint = _aiGroup addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";

	_vehicles = [];
	for "_i" from 1 to 3 do {
		_plane = [_missionPos, _vehicleClass] call F_libSpawnVehicle;
		_plane addEventHandler ["Fuel",  { (_this select 0) setFuel 1 }];
		_plane addEventHandler ["Fired", { (_this select 0) setVehicleAmmo 1 }];
		_plane flyInHeight 1600;
		_plane setVariable ["GRLIB_mission_AI", true, true];
		_vehicles pushBack _plane;
		(crew _plane) joinSilent _aiGroup;
		sleep 2;
	};

	_leader = driver (_vehicles select 0);
	_leader setSkill 0.70;
	_leader setSkill ["courage", 1];
	_leader allowFleeing 0;
	_aiGroup selectLeader _leader;
	{_x doFollow leader _aiGroup} foreach units _aiGroup;

	_missionPos = getPosATL (leader _aiGroup);
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "displayName");
	_missionHintText = ["STR_BARON_ROUGE_MESSAGE1", _vehicleName, sideMissionColor];
	true;
};

_waitUntilMarkerPos = { getPosATL (leader _aiGroup) };
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { !alive (_vehicles select 0) };

_failedExec = nil;

_successExec = {
	// Mission completed
	private _killer = (_vehicles select 0) getVariable ["GRLIB_last_killer", objNull];
	if (isPlayer _killer) then {
		private _rwd_xp = 30;
		private _text = format ["Reward Received: %1 XP", _rwd_xp];
		[_killer, _rwd_xp] call F_addScore;
		[gamelogic, _text] remoteExec ["globalChat", owner _killer];
	};
	_successHintMessage = "STR_BARON_ROUGE_MESSAGE2";
};

_this call sideMissionProcessor;
