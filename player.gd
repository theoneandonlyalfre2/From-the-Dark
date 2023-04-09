extends CharacterBody3D

@onready var luz_var = %Luz_var
var poder_activado = false
var tiempo_poder_activado = 5
var tiempo_espera = 3
var poder_cargado = true
var tiempo_espacio_prohibido = 2
const SPEED = 5.0
const JUMP_VELOCITY = 2.5
const Alt_min = 1
const Alt_max = 3
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")




func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_pressed("poder") and poder_cargado:
		poder_activado = true
	if Alt_max < position.y or position.y < Alt_min:
		luz_var.light_color = Color(1,0,0,0)
		
		tiempo_espacio_prohibido -= delta
		if tiempo_espacio_prohibido < 0:
			get_tree().change_scene_to_file("res://MI_theme/Menu_gameover.tscn")
	if Alt_max > position.y and position.y > Alt_min:
		tiempo_espacio_prohibido = 2
		luz_var.light_color = Color(1,1,1,1)
	if poder_activado:
		luz_var.light_energy += 2*delta
		tiempo_poder_activado -= delta
	if tiempo_poder_activado < 0:
		luz_var.light_energy = 1
		poder_activado = false
		poder_cargado = false
		tiempo_poder_activado = 5
		tiempo_espera = 3
	if not poder_cargado:
		if tiempo_espera < 0:
			poder_cargado = true
		else:
			tiempo_espera -= delta
		
	velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

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
	
	
	
	
	
	
	
	
