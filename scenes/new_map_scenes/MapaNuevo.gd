extends Node3D

@onready var player = $Characters/player
@onready var camera = $Characters/player/Pivot/SpringArm3D/Camera3D
@onready var gameover = $Characters/Buho/Pivot/GameOver
@onready var owlanimation= $Characters/Buho/AnimationPlayer
@onready var owllight= $Characters/Buho/ScreamerLight
@onready var wincondition= $Mapa/NavigationRegion3D/Walls/HabitacionFinal/WinCondition

func _physics_process(_delta):
	pass #get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
	


func _on_buho_attacking(is_attacking):
	if (is_attacking==true):
		camera.current=false
		gameover.current=true
		owllight.visible=true
		owlanimation.play("Comer")
		await get_tree().create_timer(2.0).timeout
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://scenes/control_scenes/Menu_gameover.tscn")

func _on_buho_spoting(is_spoting):
	if is_spoting:
		get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://scenes/FinalScene2.tscn")
		#print("You've won this time")
