extends Node3D

@onready var gramophone_system = get_parent() as GramophoneSystem

@onready var highlight: Node3D = $InteractableHinge/Highlight
@onready var interactable_hinge: XRToolsInteractableHinge = $InteractableHinge
@onready var interactable_handle: XRToolsInteractableHandle = $InteractableHinge/Handle/InteractableHandle

var enabled = false:
	set(value):
		enabled = value
		# Only try to set hinge if node is ready
		if interactable_hinge && interactable_handle:
			interactable_handle.enabled = value
			highlight.visible = value

var starting_angle: float = 0.0

func _ready() -> void:
	# Maybe just disable it in the editor?
	# interactable_handle.enabled = false
	pass

func _on_interactable_hinge_hinge_moved(angle: float) -> void:
	# Calculate the angle difference from starting position
	var calculated_angle_difference = absf(angle - starting_angle)
	
	if calculated_angle_difference > 65:
		# MOZDA OVO ZAMIJENIT SA SAMO PLAYANJEM ANIMACIJE UMJESTO LERPANJA?		
		# Lerp the lid fully open to 90 degrees (-90.0 here because of the orientation)
		var tween = create_tween()
		tween.tween_property(interactable_hinge, "rotation_degrees:x", -90.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		# Call the function after tween is done
		# tween.finished.connect(_on_lid_opened)
		
		gramophone_system.set_state(gramophone_system.State.LID_OPEN)
