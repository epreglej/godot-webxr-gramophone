extends Node

# Reference to the hinge and display label
@onready var hinge = $"./GramophoneLid/LidOrigin/InteractableLever"
@onready var success_label = $"./Label3D"

# Track the starting angle
var starting_angle: float = 0.0

func _ready():
	# Store the initial angle when scene starts
	starting_angle = 0.0  # Hinge typically starts at 0
	
	# Make the label visible and set initial text
	if success_label:
		success_label.visible = true
		success_label.text = "Angle: 0.0°"
	
	# Connect to the hinge_moved signal
	if hinge:
		hinge.hinge_moved.connect(_on_hinge_moved)
		print("Hinge monitor connected successfully")
	else:
		push_error("Hinge not found! Check the node path.")

func _on_hinge_moved(current_angle: float):
	# Calculate the angle difference from starting position
	var angle_difference = current_angle - starting_angle
	
	# Update the label with the current angle (formatted to 1 decimal place)
	if success_label:
		success_label.text = "Angle: %.1f°" % angle_difference
	
	# Debug output to console
	print("Current angle: %.1f | Difference: %.1f" % [current_angle, angle_difference])
