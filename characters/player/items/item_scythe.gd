extends Node2D

# Variables
var bullet_scene = preload("res://characters/player/items/childitems/scythe_trail.tscn")
var damage = 15  # Base damage of the scythe
var speed = 100  # Speed of the scythe
var spawn_directions = [Vector2(-1, 0), Vector2(1, 0)]  # Up, Down, Left, Right
var current_spawn_index = 0  # Tracks which direction to spawn next
var global

# Timer for spawning the scythe trails
onready var spawn_timer = $Timer

func _ready():
	# Set up the spawn timer
	spawn_timer.wait_time = 3.0  # Time between spawns
	spawn_timer.one_shot = false
	spawn_timer.start()

func spawn_scythe_trail(direction):
	var new_scythe = bullet_scene.instance()
	new_scythe.position = global_position
	#new_scythe.damage = damage
	new_scythe.speed = speed
	new_scythe.set_direction(direction)  # Pass the direction to the scythe trail
	get_parent().get_parent().get_parent().add_child(new_scythe)


func _on_Timer_timeout():
	# Spawn the scythe trail in the current direction
	var direction = spawn_directions[current_spawn_index]
	spawn_scythe_trail(direction)

	# Update the direction for the next spawn
	current_spawn_index = (current_spawn_index + 1) % spawn_directions.size()
	# Spawn the scythe trail in the current direction
	direction = spawn_directions[current_spawn_index]
	spawn_scythe_trail(direction)

	# Update the direction for the next spawn
	current_spawn_index = (current_spawn_index + 1) % spawn_directions.size()
	pass # Replace with function body.
