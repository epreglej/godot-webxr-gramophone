extends Node3D
class_name GramophoneCrank

@onready var gramophone_system = get_parent() as GramophoneSystem

@export var highlight: Node3D
@export var interactable_handle: XRToolsPickable

var enabled = false:
	set(value):
		enabled = value
		interactable_handle.enabled = value
		highlight.visible = value
