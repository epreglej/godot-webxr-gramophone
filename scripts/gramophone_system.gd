extends Node
class_name GramophoneSystem

@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var instructions_label: Label3D = $"../Blackboard/Instructions"

@export var lid: GramophoneLid
@export var crank: GramophoneCrank
@export var crank_woundable: GramophoneCrankWoundable
@export var crank_snap_zone: GramophoneCrankSnapZone
@export var filter: GramophoneFilter
@export var filter_snap_zone: GramophoneFilterSnapZone
@export var vinyls: Array[Vinyl]
@export var vinyl_snap_zone: GramophoneVinylSnapZone
@export var brake: GramophoneBrake

# kinda useless in the end as it doesnt stop the stutter when starting to play audio
var noche_y_dia_audio:AudioStreamMP3 = preload("res://audio/NocheYDia_ColePorter2.mp3")

enum State { START, LID_OPEN, CRANK_INSERTED, FILTER_SET, VINYL_SET, CRANK_WOUND, BRAKE_DISENGAGED }
var current_state = State.START
var current_vinyl: Vinyl = null

func _ready():
	lid.enabled = false
	crank.enabled = false
	crank_woundable.enabled = false
	crank_woundable.visible = false
	crank_snap_zone.enabled = false
	filter.enabled = false
	filter_snap_zone.enabled = false
	for vinyl in vinyls:
		vinyl.enabled = false
	vinyl_snap_zone.enabled = false
	brake.enabled = false
	
	set_state(State.START)

func set_state(new_state: State):
	current_state = new_state
	
	match current_state:
		State.START:
			instructions_label.text = "1. Open the lid"
			lid.enabled = true
			
		State.LID_OPEN:
			instructions_label.text = "2. Pick up the crank & insert it into the hole on the right side of the gramophone"
			lid.enabled = false
			crank.enabled = true
			crank_snap_zone.enabled = true
			
		State.CRANK_INSERTED:
			instructions_label.text = "3. Pick up the filter from under the table & set it on top of the turntable"
			crank.enabled = false
			crank.visible = false
			crank_woundable.visible = true
			crank_snap_zone.enabled = false
			filter.enabled = true
			filter_snap_zone.enabled = true
			
		State.FILTER_SET:
			instructions_label.text = "4. Pick up the vinyl from under the table & set it on top of the filter"
			filter.enabled = false
			filter_snap_zone.enabled = false
			for vinyl in vinyls:
				vinyl.enabled = true
			vinyl_snap_zone.enabled = true
			
		State.VINYL_SET:
			instructions_label.text = "5. Crank the crank"
			for vinyl in vinyls:
				vinyl.enabled = false
			vinyl_snap_zone.enabled = false
			
			crank_woundable.enabled = true
			
		State.CRANK_WOUND:
			instructions_label.text = "6. Disengage the brake"
			crank_woundable.enabled = false
			brake.enabled = true
			
		State.BRAKE_DISENGAGED:
			instructions_label.text = "7. Enjoy the music"
			audio_player.play()
			
func insert_vinyl(vinyl: Vinyl) -> void:
	current_vinyl = vinyl
	if vinyl.title == "Noche y Dia":
		audio_player.stream = noche_y_dia_audio

func remove_vinyl() -> void:
	audio_player.stop()
	current_vinyl = null
