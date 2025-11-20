extends Node3D
class_name GramophoneFilter

@onready var gramophone_system = get_parent() as GramophoneSystem

@export var highlight: Node3D
@onready var interactable_handle = $"InteractableHandle"
# @onready var crank_handle = $"./PickableObject/GramophoneCrank/CrankOrigin/InteractableHinge/CrankHandle/InteractableHandle"

var enabled = false:
	set(value):
		enabled = value
		interactable_handle.enabled = value
		highlight.visible = value
