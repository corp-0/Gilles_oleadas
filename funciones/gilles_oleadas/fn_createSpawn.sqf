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
params["_spawnPos", "_group", "_attackPos", "_MAXSPAWN", ["_tank", false], ["_air", false], ["_currentWaveCount", 0]];

_spawnPos = _spawnPos findEmptyPosition [20,500, "B_MBT_01_cannon_F"];

diag_log format ["GO: spawn pos received %1", _spawnPos];
private _groupCount = floor random (_MAXSPAWN + 1);
private _currentGroup = 0;

while {_groupCount > _currentGroup} do {
	if(_tank) then{
		if(_currentWaveCount >= MAX_TANK_PER_WAVE) exitWith {diag_log "GO: Max tanks per wave reached, suspending spawn!"};
		
		if(true) exitWith{
			_createdGroup = [_spawnPos, 180, _group, ENEMY_SIDE] call bis_fnc_spawnvehicle;
			_currentGroup = _currentGroup + 1;
			[_createdGroup select 2, _attackpos] call gilles_oleadas_fnc_groupAttack;
			diag_log format ["GO: succesfully created new group! %1", _createdGroup];
		};
	};
	if(_air) then{
		if(_currentWaveCount >= MAX_AIR_PER_WAVE) exitWith {diag_log "GO: Max air per wave reached, suspending spawn!"};

		if(true) exitWith{
			_createdGroup = [_spawnPos, 180, _group, ENEMY_SIDE] call bis_fnc_spawnvehicle;
			_currentGroup = _currentGroup + 1;
			[_createdGroup select 2, _attackpos] call gilles_oleadas_fnc_groupAttack;
			diag_log format ["GO: succesfully created new group! %1", _createdGroup];
		};
	};

	_createdGroup = [ _spawnPos, ENEMY_SIDE, _group] call BIS_fnc_spawnGroup;
	diag_log format ["GO: attempt to create new group!"];
	_createdGroup = [ _spawnPos, ENEMY_SIDE, _group ,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
	_currentGroup = _currentGroup + 1;
	[_createdGroup, _attackpos] call gilles_oleadas_fnc_groupAttack;
	diag_log format ["GO: succesfully created new group! %1", _createdGroup];
};
