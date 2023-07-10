extends MarginContainer

## Version: 1.1 |
## Short description.
##
## Long description.

# Load references.

## Load reference to Start node.
@onready var start = %Start
## Load reference to Quit node.
@onready var quit = %Quit
## Load screech sound
@onready var screech = $Screech
# Define the methods that will be called when the node enters the scene tree for the first time.
## Undefined.
func _ready():
	start.pressed.connect(_on_start_presssed)
	quit.pressed.connect(_on_quit_presssed)
## Undefined.
func _on_start_presssed():
	screech.play()
	get_tree().change_scene_to_file("res://scenes/new_map_scenes/MapaNuevo.tscn")
	get_tree().paused = false
## Undefined.
func _on_quit_presssed():
	get_tree().quit()
