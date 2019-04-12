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
 * 
 *
 * Example:
 * trivial
 *
 * Public: No
 *
 * Scope: Server
 */
if(!isServer) exitWith {};
diag_log "Gilles Oleadas initiliazed!";

// Groups 

GILLES_OLEADAS_INF =   (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_AM_OPF" >> "Infantry" >> "LOP_AM_OPF_Fireteam");
// GILLES_OLEADAS_INF2 =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Motorized" >> "PO_ISTS_OPF_Offroad_Patrol");
GILLES_OLEADAS_INF3 =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_AM_OPF" >> "Infantry" >> "LOP_AM_OPF_Rifle_squad");
GILLES_OLEADAS_INF4 =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Infantry" >> "PO_ISTS_OPF_inf_MG_ft");
GILLES_OLEADAS_INF5 =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Infantry" >> "PO_ISTS_OPF_inf_Weapon_ft");
GILLES_OLEADAS_INF6 =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Infantry" >> "PO_ISTS_OPF_inf_WEAP_SEC");
// GILLES_OLEADAS_INF7 =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Motorized" >> "PO_ISTS_OPF_MotInf_Team");
GILLES_OLEADAS_TANK =  (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Armored" >> "PO_ISTS_OPF_T72_Platoon");
GILLES_OLEADAS_CAB =   (configfile >> "CfgGroups" >> "ENEMY_SIDE" >> "LOP_ISTS_OPF" >> "Motorized" >> "PO_ISTS_OPF_MotInf_Team_BTR60");
GILLES_OLEADAS_AIR =   "RHS_Mi24P_vdv";

GILLES_OLEADAS_ALL_INF = [GILLES_OLEADAS_INF,GILLES_OLEADAS_INF3, GILLES_OLEADAS_INF4,GILLES_OLEADAS_INF5, GILLES_OLEADAS_INF6];
GILLES_OLEADAS_ALL_CAB = [GILLES_OLEADAS_CAB];

/****************************************
**            User                     **
**          Settings                   **
*****************************************/
ENEMY_SIDE         = EAST; //What side is the enemy playing
DEBUG_MODE         = false; //Logs into the RPT file

MAX_ENEMY_PER_WAVE = 5; //How many enemies can be in the map at once.
MAX_TANK_PER_WAVE  = 2; //How many tanks can a wave spawn.
MAX_AIR_PER_WAVE   = 2; //How many aircraft can a wave spawn

MAX_INF_PER_SPAWN  = 3; //How many infantry groups can spawn at once
MAX_CAB_PER_SPAWN  = 1; //How many mechanized can spawn at once
MAX_TANK_PER_SPAWN = 1; //How many tanks can spawn at once
MAX_AIR_PER_SPAWN  = 1; //How many aircraft can spawn at once

CHANCE_OF_CAB      = 40; //Chance of mechanized spawning in a wave
CHANCE_OF_TANK     = 10; //Chance of tank spawning in a wave
CHANCE_OF_AIR      = 5; //Chance of aircraft spawning in a wave

TIME_BETWEEN_SPAWNS = 10;

/****************************************
**            End                     **
**          Settings                   **
*****************************************/

waitUntil {GILLES_OLEADAS_INIT};

private _oleadasMarkers = call gilles_oleadas_fnc_readMarkers;
private _spawnMarkers = _oleadasMarkers select 0;
diag_log format ["GO: spawn markers %1", _spawnMarkers];
private _attackMarkers = _oleadasMarkers select 1;
diag_log format ["GO: attack markers %1", _attackMarkers];

if(_spawnMarkers isEqualTo []) exitWith {
    diag_log "GO: No se encontraron marcadores de spawn";
    diag_log "GO: ERROR -- No se ecntraron marcadores de spawn";
    };
if(_attackMarkers isEqualTo []) exitWith {
    diag_log "GO: No se encontraron marcadores de ataque";
    diag_log "GO: ERROR -- No se ecntraron marcadores de ataque";
    };

while {GILLES_OLEADAS_INIT} do{
    [_spawnMarkers, _attackMarkers] call gilles_oleadas_fnc_createWave;
    sleep TIME_BETWEEN_SPAWNS;
};

diag_log "GO: Finished runtime!";