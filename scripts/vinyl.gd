extends Node3D
class_name Vinyl

@onready var gramophone_system = get_parent() as GramophoneSystem

@export var song: AudioStream
@export var title: String = "Unknown Track"
@export var artist: String = "Unknown Artist"

@export var highlight: Node3D
@onready var interactable_handle = $"InteractableHandle"

var enabled = false:
	set(value):
		enabled = value
		interactable_handle.enabled = value
		highlight.visible = value

func get_song() -> AudioStream:
	return song
