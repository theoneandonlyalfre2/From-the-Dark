extends MarginContainer
@onready var start = %Start
@onready var quit = %Quit

# Called when the node enters the scene tree for the first time.
func _ready():
	start.pressed.connect(_on_start_presssed)
	quit.pressed.connect(_on_quit_presssed)

func _on_start_presssed():
	get_tree().change_scene_to_file("res://scenes/control_scenes/node_3d.tscn")
	get_tree().paused = false
	
func _on_quit_presssed():
	get_tree().quit()
