// Mod signature
GRLIB_MOD_signature = [];						// Used to filter several MOD items

// Default Personal Arsenal
private _path = format ["mod_template\%1\arsenal.sqf", GRLIB_mod_west];
[_path] call F_getTemplateFile;
private _ret = [] call compileFinal preprocessFileLineNumbers "addons\LARs\default_personal_arsenal.sqf";
if (isNil "default_personal_arsenal") then { default_personal_arsenal = _ret };

// Default LRX blacklist
GRLIB_blacklisted_from_arsenal = [
	"Zasleh2",
	"CMFlare",
	"SmokeLauncher",
	"FlareLauncher",
	"Laserdesignator",
	"weapon_Fighter"
] + blacklisted_bag + blacklisted_weapon;

if (!GRLIB_SOG_enabled && !GRLIB_SPE_enabled) then {
	// UAVs Terminal
	private _blacklisted_uavs_terminal = [
		"B_UavTerminal",
		"O_UavTerminal",
		"I_UavTerminal",
		"I_E_UavTerminal",
		"C_UavTerminal"
	] - [uavs_terminal_typename];
	GRLIB_blacklisted_from_arsenal = GRLIB_blacklisted_from_arsenal + _blacklisted_uavs_terminal;
};

// Default LRX whitelist
GRLIB_whitelisted_from_arsenal = [
	mobile_respawn_bag,
	uavs_terminal_typename,
	"B_Parachute",
	"arifle_SDAR_F",
	"20Rnd_556x45_UW_mag",
	"U_B_Wetsuit",
	"U_O_Wetsuit",
	"U_I_Wetsuit",
	"V_RebreatherB",
	"V_RebreatherIA",
	"V_RebreatherIR"
] + whitelisted_from_arsenal;
