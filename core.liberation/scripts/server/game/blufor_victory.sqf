diag_log "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=";
diag_log format ["  Blufor Victory at %1 !!", time];
diag_log "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=";

GRLIB_endgame = 1;
publicVariable "GRLIB_endgame";

{ _x setDamage 1 } foreach (units GRLIB_side_enemy);
sleep 1;

publicstats = [];
publicstats pushback stats_opfor_soldiers_killed;
publicstats pushback stats_opfor_killed_by_players;
publicstats pushback stats_blufor_soldiers_killed;
publicstats pushback stats_player_deaths;
publicstats pushback stats_opfor_vehicles_killed;
publicstats pushback stats_opfor_vehicles_killed_by_players;
publicstats pushback stats_blufor_vehicles_killed;
publicstats pushback stats_blufor_soldiers_recruited;
publicstats pushback stats_blufor_vehicles_built;
publicstats pushback stats_civilians_killed;
publicstats pushback stats_civilians_killed_by_players;
publicstats pushback stats_sectors_liberated;
publicstats pushback stats_playtime;
publicstats pushback stats_spartan_respawns;
publicstats pushback stats_secondary_objectives;
publicstats pushback stats_hostile_battlegroups;
publicstats pushback stats_ieds_detonated;
publicstats pushback stats_saves_performed;
publicstats pushback stats_saves_loaded;
publicstats pushback stats_reinforcements_called;
publicstats pushback stats_prisoners_captured;
publicstats pushback stats_blufor_teamkills;
publicstats pushback stats_vehicles_recycled;
publicstats pushback stats_ammo_spent;
publicstats pushback stats_sectors_lost;
publicstats pushback stats_fobs_built;
publicstats pushback stats_fobs_lost;
publicstats pushback (round stats_readiness_earned);

sleep 2;
[publicstats] remoteExec ["remote_call_endgame", 0];

// GRLIB_endgame = 1;
// publicVariable "GRLIB_endgame";
[] call save_game_mp;
