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

private _oleadasSpawnMarkers = allMapMarkers select {_x find "gilles_oleadas_spawn" == 0};
private _oleadasAttackMarkers = allMapMarkers select {_x find "gilles_oleadas_attack" == 0};

private _oleadasMarkers = [_oleadasSpawnMarkers, _oleadasAttackMarkers];
diag_log format ["GO: found these markers %1", _oleadasMarkers];
_oleadasMarkers;