extends Node3D

@onready var player = $Characters/player

func _physics_process(_delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
