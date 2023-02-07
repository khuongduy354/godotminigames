extends Node2D
class_name Bullet

var direction = Vector2.ZERO
export var SPEED = 30

func _ready():
	set_as_toplevel(true)
	look_at(global_position+direction)
	
func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta



