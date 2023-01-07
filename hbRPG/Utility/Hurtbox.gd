extends Area2D
class_name HurtBox

onready var HitEffect = preload("res://Utility/HitEffect.tscn")
func _ready(): 
	connect("area_entered", self, "_on_area_entered")


func _on_area_entered(hitbox: HitBox):
	if hitbox == null:
		return
	if owner.has_method("receive_hit"):
		AudioPlayer.play(AudioPlayer.Hurt)
		AudioPlayer.play(AudioPlayer.Hit)
		var hit_effect = HitEffect.instance() 
		hit_effect.position = position 
		owner.add_child(hit_effect)
		owner.receive_hit(hitbox)
