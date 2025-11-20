extends Node3D
class_name GramophoneBrake

@onready var gramophone_system = get_parent() as GramophoneSystem

@onready var interactable_handle: XRToolsInteractableHandle = $InteractableHandle

var enabled = false:
	set(value):
		enabled = value
		interactable_handle.enabled = value

func _on_interactable_handle_grabbed(pickable: Variant, by: Variant) -> void:
	rotation.y += deg_to_rad(90)
	gramophone_system.set_state(gramophone_system.State.BRAKE_DISENGAGED)
