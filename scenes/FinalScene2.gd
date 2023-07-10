extends MarginContainer
@onready var restart = %Restart
@onready var main_menu = %MainMenu


# Called when the node enters the scene tree for the first time.
func _ready():
	restart.pressed.connect(_on_restart_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/new_map_scenes/MapaNuevo.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/control_scenes/main_menu.tscn")
