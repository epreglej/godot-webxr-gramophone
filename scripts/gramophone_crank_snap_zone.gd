extends Node3D
class_name GramophoneCrankSnapZone

@onready var gramophone_system = get_parent() as GramophoneSystem
@export var snap_zone: XRToolsSnapZone
@export var highlight: Node3D

var enabled = false:
	set(value):
		enabled = value
		snap_zone.enabled = value
		highlight.visible = value

# Maybe reparaent this so that every component of GramophoneSystem is a standard Node3D
func _on_gramophone_crank_snap_zone_has_picked_up(what: Variant) -> void:
	var crank = what.find_parent("GramophoneCrank")
	if crank:
		gramophone_system.set_state(gramophone_system.State.CRANK_INSERTED)
