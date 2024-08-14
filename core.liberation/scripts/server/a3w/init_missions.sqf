//--- A3W_Missions
// Stolen from A3 Wasteland by AgenRev
// tweaked to fit in Liberation

if (!isServer) exitWith {};

cityList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\towns.sqf";
fn_selectRandomWeighted = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_selectRandomWeighted.sqf";
fn_refillbox  = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_refillbox.sqf";
checkSpawn = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_checkSpawn.sqf";
checkMissionItems = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_checkMissionItems.sqf";
sideMissionProcessor = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\sideMissionProcessor.sqf";
generateMissionWeights = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_generateMissionWeights.sqf";
setMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setMissionState.sqf";
getMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getMissionState.sqf";
getMissionLocation = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getMissionLocation.sqf";
setLocationState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setLocationState.sqf";
attemptCompileMissions = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_attemptCompileMissions.sqf";
cleanMissionVehicles = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_cleanMissionVehicles.sqf";
createMissionMarker = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createMissionMarker.sqf";
createMissionMarkerCiv = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createMissionMarkerCiv.sqf";
createCustomGroup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createCustomGroup.sqf";
getBallMagazine = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getBallMagazine.sqf";
processItems = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_processItems.sqf";
updateMissionsList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_updateMissionsList.sqf";
getNbUnits = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getNbUnits.sqf";
createOutpost = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createOutpost.sqf";
debugSpawnMarkers = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_debugSpawnMarkers.sqf";

A3W_sectors_in_use = [];
A3W_delivery_failed = 0;
A3W_mission_success = 0;
A3W_mission_failed = 0;
A3W_Mission_delay = 15*60;			// Time in seconds between Side Missions
A3W_Mission_timeout = 60*60;		// Time in seconds that a Side Mission will run for, unless completed

/*	***  Debug A3W missions ***

	A3W_debug = true;   // enable debug
	A3W_mission = "mission_SearchIntel";   // load mission
	A3W_debug_marker = true;  // debug spawn markers
	A3W_Mission_delay = 1*60;
	A3W_Mission_timeout = 5*60;
*/
waitUntil {sleep 1; !isNil "GRLIB_init_server"};

// move to shared init (HC)
//[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\setupMissionArrays.sqf";

for "_i" from 1 to 4 do {
	// Start Permanent controller
	private _init_sleep = ((2 + floor random 10) * 60);
	while {_init_sleep > 0 && isNil "A3W_debug"} do { sleep 1; _init_sleep = _init_sleep - 1 };
	diag_log format ["--- LRX A3W Starting Mission Controller #%1 at %2", _i, time];
	if ((_i == 1) || (_i > 1 && isNil "A3W_debug")) then {
		[_i, false] spawn compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\sideMissionController.sqf";
	};
	sleep 60;
};

diag_log "--- LRX A3W Missions Initialized";