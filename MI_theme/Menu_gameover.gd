extends MarginContainer

@onready var menu_principal = %Menu_principal
@onready var quit = %Quit
@onready var retry = %Retry

# Called when the node enters the scene tree for the first time.
func _ready():
	menu_principal.pressed.connect(_on_menu_principal_presssed)
	quit.pressed.connect(_on_quit_presssed)
	retry.pressed.connect(_on_retry_presssed)
func _on_menu_principal_presssed():
	get_tree().change_scene_to_file("res://Main_Meno.tscn")
	
	
func _on_retry_presssed():
	get_tree().change_scene_to_file("res://node_3d.tscn")

func _on_quit_presssed(): 
	get_tree().quit()
