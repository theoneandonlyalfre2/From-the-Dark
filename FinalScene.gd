extends MarginContainer

@onready var won= %Won
@onready var restart= %Restart
@onready var mainmenu= %MainMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	restart.pressed.connect(_on_restart_presssed)
	mainmenu.pressed.connect(_on_mainmenu_presssed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/new_map_scenes/MapaNuevo.tscn")
	get.tree().paused = true

func _on_mainmenu_pressed():
	get_tree().change_scene_to_file("res://scenes/control_scenes/main_menu.tscn")
