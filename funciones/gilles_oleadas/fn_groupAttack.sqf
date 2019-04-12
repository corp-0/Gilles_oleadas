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

 params ["_group", "_attackPos"];

_attackWP = _group addWaypoint [_attackPos, 10, 1];
[_group, 1] setWaypointType "MOVE";
[_group, 1] setWaypointbehaviour "AWARE";
[_group, 1] setWaypointSpeed "FULL";
[_group, 1] setWaypointCombatMode "WHITE";
_attackWP = _group addWaypoint [_attackPos, 10, 2];
[_group, 2] setWaypointType "MOVE";
[_group, 2] setWaypointbehaviour "AWARE";
[_group, 2] setWaypointSpeed "FULL";
[_group, 2] setWaypointCombatMode "WHITE";

_group deleteGroupWhenEmpty true;
