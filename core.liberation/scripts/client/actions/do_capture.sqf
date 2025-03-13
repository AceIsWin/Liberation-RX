params ["_unit"];
if (isNull _unit) exitWith {};

waitUntil {
    [_unit] joinSilent (group player);
    gamelogic globalChat format ["Capturing prisoner %1...", name _unit];
    sleep 2;
    ((!alive _unit) || (local _unit && _unit in (units player)));
};
if (!alive _unit) exitWith {};

if (goggles _unit == "G_Blindfold_01_black_F") then {
    removeGoggles _unit;
    [player, 5] remoteExec ["F_addReput", 2];
};

_unit removeAllEventHandlers "GetInMan";
_unit removeAllEventHandlers "SeatSwitchedMan";
_unit removeAllEventHandlers "Take";
_unit addEventHandler ["GetInMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["SeatSwitchedMan", {_this spawn vehicle_permissions}];
_unit addEventHandler ["Take", {removeAllWeapons (_this select 0)}];
_unit setVariable ["GRLIB_prisoner_owner", player, true];
_unit setVariable ["GRLIB_is_prisoner", false, true];
_unit setVariable ["GRLIB_counter_TTL", nil, true];
[_unit] joinSilent (group player);
