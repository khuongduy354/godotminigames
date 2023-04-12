extends CharacterBody2D

var holding_item:Item = null
var ItemClass = preload("res://Item.tscn")
var bag:Bagg =null 

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func _ready():
	pass 
#var gravity = 400
func get_input_direction():
	var input_dir: Vector2 = Vector2.ZERO
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_dir.normalized()

func _physics_process(delta):
	var direction =get_input_direction() 
	
	if direction:
		velocity = direction * SPEED
	else: 
		velocity =Vector2.ZERO

	move_and_slide()

func put_item_to_hand(item:Item):
	item.position = $item_pos.position
	add_child(item)
	holding_item=item
	
func _handle_slot_change(new_slot): 
	var active_slot:Slot = bag.get_children()[new_slot]
	if active_slot.item != null: 
		var new_item = active_slot.item.duplicate()
		put_item_to_hand(new_item)
	
func plug_bag(new_bag:Bagg): 
	bag = new_bag 
	bag.connect("active_slot_changed",Callable(self,"_handle_slot_change"))
	put_item_to_hand(bag.get_child(0).item)
