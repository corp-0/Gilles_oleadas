/*
 * Author: Gilles
 *
 * //TODO: DOCSTRING
 *
 * Arguments:
 * none
 *
 *
 * Return Value:
 * <ARRAY>, multidimensional array with both array markers.
 *
 * Example:
 * trivial
 *
 * Public: No
 *
 * Scope: Server
 */

params["_spawnMarkers", "_attackMarkers"];

if (ENEMY_SIDE countSide (allUnits - allPlayers) >= MAX_ENEMY_PER_WAVE) exitWith {diag_log "GO: max units per wave reached, suspending spawn!"};
if (!GILLES_OLEADAS_INIT) exitWith {};

private _spawnPos  =  getMarkerPos (selectRandom _spawnMarkers);

private _attackPos = getMarkerPos  (selectRandom _attackMarkers);
_spawnPos = [_spawnPos, 0, 100, 10, 0, 0.5, 0, [], _spawnPos] call BIS_fnc_findSafePos;

if (DEBUG_MODE) then {
	diag_log format ["GO: This wave spawn point = %1", _spawnPos];
	diag_log format ["GO: This wave attack pos = %1", _attackPos];
};

// Rolling dices for type of spawn
private _dice = selectRandom ["INF", "CAB", "TANK", "AIR"];

switch _dice do{
	case "INF": {
		
	};
};
// Spawning infantry 
private _infGroup = selectRandom GILLES_OLEADAS_ALL_INF;

[_spawnPos,  _infGroup, _attackPos, MAX_INF_PER_SPAWN, false, false] spawn gilles_oleadas_fnc_createSpawn;

// Spawning cab 
private _dice = round (random 100);
_currentWaveCount = allUnits apply {(typeOf _x) find "LOP_AM_OPF_BTR60"};
_currentWaveCount = _currentWavecount - allDead;
_currentWaveCount = count _currentWaveCount;

if (DEBUG_MODE) then {
	diag_log format ["GO: current count of CAB : %1", _currentWaveCount];
	diag_log format ["GO: cab dice: %1", _dice];
};

if (_dice < CHANCE_OF_CAB) then {
	if(count (nearestObjects [_spawnPos, ["LOP_AM_OPF_BTR60"], 50, false])> 0) exitWith {diag_log "GO: disabled spawn to avoid collition"};
	
	if (DEBUG_MODE) then {
		diag_log "GO: Dices have spoken, we spawned CAB";
	};
	
	private _cabGroup = selectRandom GILLES_OLEADAS_ALL_CAB;
	[_spawnPos,  "LOP_AM_OPF_BTR60", _attackPos, MAX_TANK_PER_SPAWN, true, false] spawn gilles_oleadas_fnc_createSpawn;
};

// Spawning Tank 
private _dice = round (random 100);
_currentWaveCount = allUnits apply {(typeOf _x) find "LOP_AM_OPF_BTR60"};
_currentWaveCount = _currentWavecount - allDead;
_currentWaveCount = count _currentWaveCount;

if (DEBUG_MODE) then {
	diag_log format ["GO: current count of TANK : %1", _currentWaveCount];
	diag_log format ["GO: tank dice: %1", _dice];
};

if(_dice < CHANCE_OF_TANK) then {
	
	if (DEBUG_MODE) then {
		diag_log "GO: Dices have spoken, we spawned TANK";
	};
	
	if(count (nearestObjects [_spawnPos, ["rhs_t72ba_tv"], 50, false])> 0) exitWith {diag_log "GO: disabled spawn to avoid collition"};
	[_spawnPos,  "rhs_t72ba_tv", _attackPos, MAX_TANK_PER_SPAWN, true, false, _currentWaveCount] spawn gilles_oleadas_fnc_createSpawn;
};

// Spawning Air 
private _dice = round (random 100);
_currentWaveCount = allUnits apply {(typeOf _x) find "RHS_Mi24P_vdv"};
_currentWaveCount = _currentWavecount - allDead;
_currentWaveCount = count _currentWaveCount;

if (DEBUG_MODE) then {
	diag_log format ["GO: air dice: %1", _dice];
	diag_log format ["GO: current count of AIR : %1", _currentWaveCount];
};


if(_dice < CHANCE_OF_AIR) then{

	if (DEBUG_MODE) then {
		diag_log "GO: Dices have spoken, we have spawned AIR";
	};

	_currentWaveCount = _currentWaveCount +1;
	if(count (nearestObjects [_spawnPos, ["RHS_Mi24P_vdv"], 50, false])> 0) exitWith {diag_log "GO: disabled spawn to avoid collition"};

	[_spawnPos,  GILLES_OLEADAS_AIR, _attackPos, MAX_AIR_PER_SPAWN, false, true, _currentWaveCount] spawn gilles_oleadas_fnc_createSpawn;
};

allGroups apply {
	if(side _x isEqualTo ENEMY_SIDE)then{
		_x addWaypoint [_attackPos, 0]; 
	};
};