if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_townName", "_marker_mission"];

_setupVars = {
	_missionType = "STR_FOODDELI";
	_locationsArray = [LRX_MissionMarkersCap] call checkSpawn;
	_ignoreAiDeaths = true;
};

_setupObjects = {
	_townName = markerText _missionLocation;
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_man1 = createAgent ["C_Marshal_F", _missionPos, [], 5, "NONE"];
	_man1 allowDamage false;
	_man1 setVariable ['GRLIB_can_speak', true, true];
	_man1 setVariable ["GRLIB_A3W_Mission_DL3", true, true];
	doStop _man1;
	[_man1, "LHD_krajPaluby"] spawn F_startAnimMP;
	_marker_mission = ["DEL2", _missionPos] call createMissionMarkerCiv;
	_missionHintText = ["STR_FOODDELI_MESSAGE1", sideMissionColor, _townName];
	_vehicles = [_man1];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { ([_missionPos, Foodbarrel_typename, 3] call checkMissionItems) };

_failedExec = {
	// Mission failed
	{ [_x, -2] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	deleteMarker _marker_mission;
	_failedHintMessage = ["STR_FOODDELI_MESSAGE2", sideMissionColor, _townName];
	A3W_delivery_failed = A3W_delivery_failed + 1;
};

_successExec = {
	// Mission completed
	private _winner = ([_missionPos, 50] call F_getNearbyPlayers) select 0;
	if (!isNil "_winner") then {
		private _bonus = round (22 + random 25);
        [_bonus] remoteExec ["remote_call_a3w_info", owner _winner];
        [_winner, _bonus] call F_addScore;
		[_winner, 5] call F_addReput;
	};
	_successHintMessage = ["STR_FOODDELI_MESSAGE3", sideMissionColor];
	deleteMarker _marker_mission;
	A3W_delivery_failed = 0;
};

_this call sideMissionProcessor;
