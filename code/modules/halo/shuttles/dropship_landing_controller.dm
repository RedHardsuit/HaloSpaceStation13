var/global/datum/dropship_landing_controller/dropship_landing_controller = new /datum/dropship_landing_controller

/datum/dropship_landing_controller
	var/list/land_points = list()

/datum/dropship_landing_controller/proc/get_faction_land_points(var/wanted_faction)
	var/list/faction_land_points = list()
	for(var/obj/effect/landmark/dropship_land_point/O in land_points)
		if(O.faction == wanted_faction)
			faction_land_points += O
	return faction_land_points

/datum/dropship_landing_controller/proc/get_active_land_points()
	var/list/active_land_points = list()
	for(var/obj/effect/landmark/dropship_land_point/O in land_points)
		if(O.active)
			active_land_points += O
	return active_land_points

/datum/dropship_landing_controller/proc/get_unoccupied_land_points()
	var/list/active_land_points = list()
	for(var/obj/effect/landmark/dropship_land_point/O in land_points)
		if(!O.occupied)
			active_land_points += O
	return active_land_points

/datum/dropship_landing_controller/proc/get_potential_landing_points(var/check_active = 1,var/check_occupied = 1,var/faction_check)
	var/list/potential_landing_points = land_points.Copy()
	if(check_active)
		potential_landing_points &= get_active_land_points()
	if(check_occupied)
		potential_landing_points &= get_unoccupied_land_points()
	if(faction_check)
		potential_landing_points &= get_faction_land_points(faction_check)
	return potential_landing_points

/datum/dropship_landing_controller/proc/add_land_point(var/obj/land_point)
	land_points += land_point

/datum/dropship_landing_controller/proc/remove_land_point(var/obj/land_point)
	land_points -= land_point

/obj/effect/landmark/dropship_land_point
	name = "Dropship Land Point"
	var/faction //The faction this landing point belongs to. Null for all-factions.
	var/active = 1 //Is this landing point available.
	var/occupied = 0 //Is this landing point currently occupied?

/obj/effect/landmark/dropship_land_point/New()
	..()
	dropship_landing_controller.add_land_point(src)

/obj/effect/landmark/dropship_land_point/inactive
	name = "Inactive Dropship Land Point"
	active = 0

/obj/effect/landmark/dropship_land_point/occupied
	name = "Occupied Dropship Land Point"
	occupied = 1