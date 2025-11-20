extends Node3D
class_name GramophoneCrankWoundable

@onready var gramophone_system = get_parent() as GramophoneSystem

@export var highlight: Node3D
@export var interactable_handle: XRToolsPickable

var enabled = false:
	set(value):
		enabled = value
		interactable_handle.enabled = value
		highlight.visible = value

func _on_interactable_hinge_hinge_moved(angle: Variant) -> void:
	gramophone_system.set_state(gramophone_system.State.CRANK_WOUND)
