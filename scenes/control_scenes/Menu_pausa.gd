extends MarginContainer
@onready var resume = %Resume
@onready var restart = %Restart
@onready var menu_principal = %Menu_principal


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	resume.pressed.connect(_on_resume_presssed)
	restart.pressed.connect(_on_restart_presssed)
	menu_principal.pressed.connect(_on_menu_principal_presssed)
	
func _input(event):
	if event.is_action_pressed("pausa"):
		show()
		get_tree().paused = true

func _on_resume_presssed():
	hide()
	get_tree().paused = false
	
func _on_restart_presssed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func _on_menu_principal_presssed():
	get_tree().change_scene_to_file("res://scenes/control_scenes/main_menu.tscn")
	get_tree().paused = false
