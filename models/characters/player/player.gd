extends CharacterBody3D
class_name Player

## Version: 1.1 |
## This script defines the behavior of the bat.
##
## This script defines how the bat can fly, how the bat can move and how the bat can use his echolocation hability.

# Load references

## Load reference to an AudioStreamPlayer node.
@onready var audio_stream_player = $AudioStreamPlayer

## Load a reference to a poder.tscn scene.
var Poder = preload("res://models/characters/player/poder.tscn")

# Define variables to track the state of the player's abilities and various time intervals.

## Power of the bat activated.
var poder_activado = false
## Time of the power been activated.
var tiempo_poder_activado = 3
## Time of wait.
var tiempo_espera = 3
## Power of the bat loaded.
var poder_cargado = true
## Time of space forbidden.
var tiempo_espacio_prohibido = 1

# Define constants for movement and jumping.

## Speed of the bat.
const SPEED = 5.0
## Jump velocity of the bat.
const JUMP_VELOCITY = 3
## Min of height.
const Alt_min = 1
## Max of height.
const Alt_max = 3

## Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Define the methods.

## Physics of the bat.
func _physics_process(delta):
	# Add the gravity.
	velocity.y -= gravity * delta

	# Handle jumping when the "ui_accept" action is pressed.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
		audio_stream_player.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Move the player based on the input direction or decelerate if no input is detected.
	if direction:
		velocity.x = -direction.x * SPEED
		velocity.z = -direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Move the player based on their current velocity.
	move_and_slide()
