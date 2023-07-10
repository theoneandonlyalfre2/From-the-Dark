extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

signal attacking(is_attacking:bool)
signal spoting(is_spoting:bool)
var SPEED = 2.0

func _physics_process(_delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = new_velocity
	move_and_slide()

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
	# Rotate owl
	look_at(Vector3(target_location.x, global_transform.origin.y, target_location.z), Vector3.UP)

func _on_folllow_body_entered(body):
	if body.is_in_group("player"):
		spoting.emit(true)

func _on_folllow_body_exited(body):
	if body.is_in_group("player"):
		spoting.emit(false)

func _on_attack_body_entered(body):
	if body.is_in_group("player"):
		attacking.emit(true)
		print("oh crap")
