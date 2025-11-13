extends Node3D

@onready var pickable_object = $"./PickableObject"
@onready var crank_handle = $"./PickableObject/GramophoneCrank/CrankOrigin/InteractableHinge/CrankHandle/InteractableHandle"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pickable_object.enabled = true	
	# crank_handle.enabled = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
