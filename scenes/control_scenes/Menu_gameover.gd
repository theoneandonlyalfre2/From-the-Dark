extends MarginContainer

## Version: 1.1 |
## Short description.
##
## Long description.

# Load references.

## Load reference to Menu_principal node.
@onready var menu_principal = %Menu_principal
## Load reference to Quit node.
@onready var quit = %Quit
## Load reference to Retry node.
@onready var retry = %Retry

# Define the methods that will be called when the node enters the scene tree for the first time.

## Undefined.
func _ready():
	menu_principal.pressed.connect(_on_menu_principal_presssed)
	quit.pressed.connect(_on_quit_presssed)
	retry.pressed.connect(_on_retry_presssed)

## Undefined.
func _on_menu_principal_presssed():
	get_tree().change_scene_to_file("res://scenes/control_scenes/main_menu.tscn")	

## Undefined.
func _on_retry_presssed():
	get_tree().change_scene_to_file("res://scenes/new_map_scenes/MapaNuevo.tscn")

## Undefined.
func _on_quit_presssed(): 
	get_tree().quit()
