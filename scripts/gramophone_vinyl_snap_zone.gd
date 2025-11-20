extends Node3D
class_name GramophoneVinylSnapZone

@onready var gramophone_system = get_parent() as GramophoneSystem
@export var snap_zone: XRToolsSnapZone
@export var highlight: Node3D

var enabled = false:
	set(value):
		enabled = value
		snap_zone.enabled = value
		highlight.visible = value

func _on_xr_tools_snap_zone_has_picked_up(what: Variant) -> void:
	if what.get_parent() is Vinyl:
		var vinyl = what.get_parent()
		if vinyl:
			gramophone_system.set_state(gramophone_system.State.VINYL_SET)
			# gramophone_system.current_vinyl = vinyl
			gramophone_system.insert_vinyl(vinyl)
