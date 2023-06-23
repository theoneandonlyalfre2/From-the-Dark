extends MeshInstance3D

@export_node_path("Node3D") var _origin_point

@onready var origin_point : Node3D = get_node(_origin_point)
@onready var shader : ShaderMaterial = self.get_active_material(0)
func _ready():
	show()

func _input(_event):
	if Input.is_action_just_pressed("ui_echolocation"):
		shader.set_shader_parameter("shape_transform", origin_point.global_transform)
		var tween := create_tween()
		tween.tween_method(_update_shader, 0.0, 5.0, 1.0)

func _update_shader(size:float):
	shader.set_shader_parameter("size", size)
