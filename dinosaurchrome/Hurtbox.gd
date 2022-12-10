class_name Hurtbox
extends Area2D


func _ready():
	self.connect("area_entered",self,"_on_Area2D_area_entered")

func _on_Area2D_area_entered(hitbox:Hitbox):
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		
		
#
