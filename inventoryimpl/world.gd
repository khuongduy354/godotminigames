extends Node2D

@onready var player = $CharacterBody2D
@onready var bag = $Bag
# Called when the node enters the scene tree for the first time.
func _ready():
	player.plug_bag(bag)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
