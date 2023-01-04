extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var fire_rate_slider = $CanvasLayer/VBoxContainer/HBoxContainer2/HSlider
onready var reload_time = $CanvasLayer/VBoxContainer/HBoxContainer/ReloadTime
onready var max_ammo = $CanvasLayer/VBoxContainer/HBoxContainer3/MaxAmmo
onready var player = $Gunner

# Called when the node enters the scene tree for the first time.
func _ready():
	fire_rate_slider.connect("value_changed",player,"set_fire_rate")
	reload_time.connect("value_changed",player,"set_reload_time")
	max_ammo.connect("value_changed",player,"set_max_ammo")
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
