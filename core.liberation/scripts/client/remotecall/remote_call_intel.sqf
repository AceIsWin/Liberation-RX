if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_notiftype", ["_obj_position", getpos player]];

if ( _notiftype == 0 ) then {
	if (_obj_position) then {
		["lib_intel_prisoner_friendly"] call BIS_fnc_showNotification;
	} else {
		["lib_intel_prisoner"] call BIS_fnc_showNotification;
	};
};

if ( _notiftype == 1 ) then {
	["lib_intel_document"] call BIS_fnc_showNotification;
};

if ( _notiftype == 2 ) then {
	waitUntil { !isNil "secondary_objective_position_marker" };
	waitUntil { secondary_objective_position_marker distance2D zeropos > 300 };

	private _location_name = [secondary_objective_position_marker] call F_getLocationName;
	["lib_intel_fob", [_location_name]] call BIS_fnc_showNotification;

	private _secondary_random_position_marker = secondary_objective_position_marker getPos [800, floor random 360];
	private _secondary_marker = createMarkerLocal ["secondarymarker", _secondary_random_position_marker];
	_secondary_marker setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker setMarkerTypeLocal "hd_unknown";

	private _secondary_marker_zone = createMarkerLocal ["secondarymarkerzone", _secondary_random_position_marker];
	_secondary_marker_zone setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker_zone setMarkerShapeLocal "ELLIPSE";
	_secondary_marker_zone setMarkerBrushLocal "FDiagonal";
	_secondary_marker_zone setMarkerSizeLocal [1500,1500];
};

if ( _notiftype == 3 ) then {
	["lib_secondary_fob_destroyed"] call BIS_fnc_showNotification;
	deleteMarkerLocal "secondarymarker";
	deleteMarkerLocal "secondarymarkerzone";
	secondary_objective_position_marker = zeropos;
};

if ( _notiftype == 4 ) then {
	waitUntil {_obj_position distance2D zeropos > 300 };
	private _location_name = [_obj_position] call F_getLocationName;
	["lib_intel_convoy", [_location_name]] call BIS_fnc_showNotification;
};

if ( _notiftype == 5 ) then {
	["lib_secondary_convoy_success"] call BIS_fnc_showNotification;
};

if ( _notiftype == 51 ) then {
	["lib_secondary_convoy_failed"] call BIS_fnc_showNotification;
};

if ( _notiftype == 6 ) then {
	waitUntil {!isNil "secondary_objective_position_marker" };
	waitUntil {count secondary_objective_position_marker > 0 };
	waitUntil {secondary_objective_position_marker distance2D zeropos > 300 };

	private _location_name = [secondary_objective_position_marker] call F_getLocationName;
	["lib_intel_sar", [_location_name]] call BIS_fnc_showNotification;

	private _secondary_random_position_marker = secondary_objective_position_marker getPos [800, floor random 360];
	private _secondary_marker = createMarkerLocal ["secondarymarker", _secondary_random_position_marker];
	_secondary_marker setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker setMarkerTypeLocal "hd_unknown";

	private _secondary_marker_zone = createMarkerLocal ["secondarymarkerzone", _secondary_random_position_marker];
	_secondary_marker_zone setMarkerColorLocal GRLIB_color_enemy_bright;
	_secondary_marker_zone setMarkerShapeLocal "ELLIPSE";
	_secondary_marker_zone setMarkerBrushLocal "FDiagonal";
	_secondary_marker_zone setMarkerSizeLocal [1500,1500];
};

if (_notiftype == 7 || _notiftype == 8) then {
	if ( _notiftype == 7 ) then {
		["lib_intel_sar_failed"] call BIS_fnc_showNotification;
	};
	if ( _notiftype == 8 ) then {
		["lib_intel_sar_succeeded"] call BIS_fnc_showNotification;
	};
	deleteMarkerLocal "secondarymarker";
	deleteMarkerLocal "secondarymarkerzone";
	secondary_objective_position_marker = zeropos;
};