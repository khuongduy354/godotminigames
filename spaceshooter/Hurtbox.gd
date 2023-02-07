extends Area2D
class_name Hurtbox

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("area_entered",self,"_on_Area2D_body_entered")
func _on_Area2D_body_entered(hitbox: Hitbox):
	if hitbox == null:
		return
	if owner.has_method("receive_hit"):
		owner.receive_hit(hitbox)
		
