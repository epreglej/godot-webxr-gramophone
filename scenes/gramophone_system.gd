extends Node

@onready var lid_hinge = $"./GramophoneLid/LidOrigin/InteractableLever"
@onready var lid_handle = $"./GramophoneLid/LidOrigin/InteractableLever/HandleOrigin/InteractableHandle"
@onready var text_label = $"./Label3D"

var starting_angle: float = 0.0
var has_auto_opened: bool = false

# State machine flags.
var can_interact_with_lid: bool = false
var can_interact_with_crank: bool = false

func _ready():
	# Store the initial angle when scene starts.
	starting_angle = 0.0  # Hinge typically starts at 0.
	
	# Allow interactions with the lid
	can_interact_with_lid = true
	# Set initial text on the label.
	if text_label:
		text_label.text = "Open the lid on the gramophone."
	
	# Connect to the hinge_moved signal
	if lid_hinge:
		lid_hinge.hinge_moved.connect(_on_hinge_moved)
		print("Hinge connected successfully")
	else:
		push_error("Hinge not found! Check the node path.")

func _on_hinge_moved(current_angle: float):
	# Calculate the angle difference from starting position
	var calculated_angle_difference = absf(current_angle - starting_angle)
	
	if calculated_angle_difference > 70 && text_label && !has_auto_opened:
		has_auto_opened = true
		
		# Lerp the lid fully open to 90 degrees (-90.0 here because of the orientation)
		var tween = create_tween()
		tween.tween_property(lid_hinge, "rotation_degrees:x", -90.0, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		
		# Disable interaction after animation completes
		tween.finished.connect(_on_lid_opened)

func _on_lid_opened():
	# Find and disable the XRToolsPickable node
	text_label.text = "Great! Now pick up the crank."
	
	if lid_handle:
		lid_handle.enabled = false
		text_label.text = "Lid disabled."
	else:
		push_error("XRToolsPickable node not found on hinge")
