extends Node3D
class_name GramophoneFilterSnapZone

@onready var gramophone_system = get_parent() as GramophoneSystem
@export var snap_zone: XRToolsSnapZone
@export var highlight: Node3D

var enabled = false:
	set(value):
		enabled = value
		snap_zone.enabled = value
		highlight.visible = value

func _on_xr_tools_snap_zone_has_picked_up(what: Variant) -> void:
	var filter = what.find_parent("GramophoneFilter")
	if filter:
		gramophone_system.set_state(gramophone_system.State.FILTER_SET)
