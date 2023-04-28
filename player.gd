extends CharacterBody3D

@onready var luz_var = %Luz_var
@onready var audio_stream_player = $AudioStreamPlayer

var Poder = preload("res://poder.tscn")
var poder_activado = false
var tiempo_poder_activado = 3
var tiempo_espera = 3
var poder_cargado = true
var tiempo_espacio_prohibido = 1
const SPEED = 5.0
const JUMP_VELOCITY = 3
const Alt_min = 1
const Alt_max = 3
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")





func _physics_process(delta):
	# Add the gravity.
	velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		audio_stream_player.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = -direction.x * SPEED
		velocity.z = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	

	
	
	
	
