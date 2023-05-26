extends MeshInstance3D

@export_node_path("Node3D") var _origin_point

@onready var origin_point : Node3D = get_node(_origin_point)
@onready var shader : ShaderMaterial = self.get_active_material(0)

func _unhandled_key_input(event:InputEvent):
	if event.is_pressed() and event.keycode == KEY_F:
		shader.set_shader_parameter("shape_transform", origin_point.global_transform)
		var tween := create_tween()
		tween.tween_method(_update_shader, 0.0, 50.0, 10.0)

func _update_shader(size:float):
	shader.set_shader_parameter("size", size)
