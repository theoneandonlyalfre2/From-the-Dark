extends MarginContainer

## Version: 1.1 |
## Short description.
##
## Long description.

# Load references.

## Load reference to Resume node.
@onready var resume = %Resume
## Load reference to Restart node.
@onready var restart = %Restart
## Load reference to Menu_principal node.
@onready var menu_principal = %Menu_principal

# Define methods that will be called when the node enters the scene tree for the first time.

## Undefined.
func _ready():
	resume.pressed.connect(_on_resume_presssed)
	restart.pressed.connect(_on_restart_presssed)
	menu_principal.pressed.connect(_on_menu_principal_presssed)

## Undefined.
func _input(event):
	if event.is_action_pressed("pausa"):
		show()
		get_tree().paused = true

## Undefined.
func _on_resume_presssed():
	hide()
	get_tree().paused = false

## Undefined.
func _on_restart_presssed():
	get_tree().reload_current_scene()
	get_tree().paused = false

## Undefined.
func _on_menu_principal_presssed():
	get_tree().change_scene_to_file("res://scenes/control_scenes/main_menu.tscn")
	get_tree().paused = false
