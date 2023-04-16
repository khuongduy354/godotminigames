extends StaticBody2D
var direction = Vector2.ZERO
export var speed = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	position += direction * speed 

func _on_StoneBullet_area_entered(area):
	if area.is_in_group("tree"): 
		if area.has_method("_on_bullet_hit"): 
			area._on_bullet_hit()
