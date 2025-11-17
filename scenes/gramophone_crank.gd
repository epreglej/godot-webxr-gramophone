extends Node3D

@onready var interactable_handle = $"InteractableHandle"
# @onready var crank_handle = $"./PickableObject/GramophoneCrank/CrankOrigin/InteractableHinge/CrankHandle/InteractableHandle"
@onready var xr_tools_highlight_visible: XRToolsHighlightVisible = $InteractableHandle/XRToolsHighlightVisible

var enabled = false:
	set(value):
		enabled = value
		# Only try to set hinge if node is ready
		if interactable_handle:
			interactable_handle.enabled = value
			xr_tools_highlight_visible.visible = value
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# pickable_object.enabled = true	
	# crank_handle.enabled = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
