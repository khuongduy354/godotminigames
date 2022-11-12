# godot-cheatsheet


### 8 ways movements

[movements](https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html)

```python
extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("right"):
        velocity.x += 1
    if Input.is_action_pressed("left"):
        velocity.x -= 1
    if Input.is_action_pressed("down"):
        velocity.y += 1
    if Input.is_action_pressed("up"):
        velocity.y -= 1
    velocity = velocity.normalized() * speed

func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)

```


## advanced Keyboard input
- look_at(get_global_mouse_position()) // rotate according to mouse 
- movement see above
- for custom input:

```python
unc _unhandled_input(event: InputEvent) -> void:
    # mouse 
    if event is InputEventMouseMotion:	
    # press 
    if event.is_action_pressed("click"):		
    if event.is_pressed(): #any key pressed 
    if event.is_echo(): #last key hold 
```


# Grid
### tilemap grid 
```python
extends TileMap

enum { EMPTY = -1, ACTOR, OBSTACLE, OBJECT}

func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
		
func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		OBJECT:
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn, cell_start, cell_target)
		ACTOR:
			var pawn_name = get_cell_pawn(cell_target).name
			print("Cell %s contains %s" % [cell_target, pawn_name])

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, EMPTY)
	return map_to_world(cell_target) + cell_size / 2
```
