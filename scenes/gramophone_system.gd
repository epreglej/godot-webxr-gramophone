class_name GramophoneSystem
extends Node

@onready var instructions_label: Label3D = $"../Blackboard/Instructions"
@onready var lid = $GramophoneLid
@onready var crank_snap_zone: XRToolsSnapZone = $GramophoneCrankSnapZone
@export var crank: GramophoneCrank

enum State { START, LID_OPEN, CRANK_ACTIVE }
var current_state = State.START

func _ready():
	lid.enabled = false
	crank.enabled = false
	crank_snap_zone.enabled = false
	
	set_state(State.START)

func set_state(new_state: State):
	current_state = new_state
	
	match current_state:
		State.START:
			instructions_label.text = "1. Open the lid"
			lid.enabled = true
			
		State.LID_OPEN:
			instructions_label.text = "2. Pick up the crank"
			lid.enabled = false
			crank.enabled = true
			
		State.CRANK_ACTIVE:
			instructions_label.text = "3. Put the crank in the hole"
			crank_snap_zone.enabled = true

func on_lid_opened():
	set_state(State.LID_OPEN)
