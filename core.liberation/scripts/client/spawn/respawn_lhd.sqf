params ["_pos"];
player setPosATL (_pos vectorAdd [floor(random 5), floor(random 5), 1]);
GRLIB_player_spawned = ([] call F_getValid);
cinematic_camera_started = false;
