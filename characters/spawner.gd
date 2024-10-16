extends Node2D

var enemy_warrior_scene = preload("res://characters/enemies/enemy_warrior1.tscn")
var enemy_maggot_scene = preload("res://characters/enemies/enemy_maggot.tscn")
var enemy_elite_scene = preload("res://characters/enemies/enemy_elite.tscn")
var enemy_big_scene = preload("res://characters/enemies/enemy_big.tscn")
var minutes = 0
var max_enemies = 100
var total_enemies = 0
var global
var enemy_to_spawn = null  # Variable to hold the enemy scene

onready var spawn_area = $SpawnArea
onready var spawn_node = $spawn
onready var spawn_timer = $spawn/spawntimer

func _ready():
	global = get_node("/root/global")
	if get_parent().name == "spawners2":
		enemy_warrior_scene = preload("res://characters/enemies/enemy_elite.tscn")
		enemy_maggot_scene = preload("res://characters/enemies/enemy_elite.tscn")
	if get_parent().name == "spawners1":
		$SpawnArea/CollisionShape2D.scale.x = 0.8
		enemy_warrior_scene = preload("res://characters/enemies/enemy_slime.tscn")
		enemy_elite_scene = preload("res://characters/enemies/enemy_maggot.tscn")
	if get_parent().name == "spawners3":
		$SpawnArea/CollisionShape2D.scale.y = 1.5
		enemy_elite_scene = preload("res://characters/enemies/enemy_slime.tscn")
	# Start the initial spawn
	_on_Timer_timeout()

func _on_Timer_timeout():
	if global.enemitotal <= global.enemimax:
		if global.minute != minutes:
			spawn_enemy_delayed(enemy_big_scene)
			if $Timer.wait_time >0.5:
				$Timer.wait_time = $Timer.wait_time -0.1
				print(str($Timer.wait_time))
				minutes = global.minute
		else:
			var random_value = randf()
			if random_value <= 0.23:
				spawn_enemy_delayed(enemy_warrior_scene)
			elif random_value <= 0.66:
				spawn_enemy_delayed(enemy_maggot_scene)
			else:
				spawn_enemy_delayed(enemy_elite_scene)
		global.enemitotal = global.enemitotal + 1
	else:
		pass

	# Restart the timer for the next spawn
	$Timer.start()

func spawn_enemy_delayed(enemy_scene):
	# Debugging: Print a message to confirm this function is being called
	print("Spawning enemy delayed...")

	# Set the spawn node at the intended spawn location
	var random_position = generate_random_position_within_spawn_area()
	spawn_node.global_position = spawn_area.global_position + random_position

	# Store the enemy scene in the global variable for later instantiation
	enemy_to_spawn = enemy_scene

	# Debugging: Print the chosen position
	print("Spawn node position set to: ", spawn_node.global_position)

	# Start the spawn timer
	spawn_timer.start()

func _on_spawntimer_timeout():
	# Debugging: Print a message to confirm this function is being called
	print("Spawn timer timeout, creating enemy...")

	# Instantiate the enemy when the timer runs out
	if enemy_to_spawn:
		var new_enemy = enemy_to_spawn.instance()
		new_enemy.position = spawn_node.global_position
		get_parent().call_deferred("add_child", new_enemy)

		# Debugging: Confirm the enemy is being added
		print("Enemy spawned at position: ", new_enemy.position)

		# Reset the enemy_to_spawn after spawning
		enemy_to_spawn = null
	else:
		# Debugging: In case the enemy scene is not found
		print("No enemy scene found to spawn!")

func generate_random_position_within_spawn_area() -> Vector2:
	# Get the radius based on the size of the CollisionShape2D in SpawnArea
	var shape = spawn_area.get_node("CollisionShape2D").shape

	var radius = 0.0
	if shape is CircleShape2D:
		radius = shape.radius
	elif shape is RectangleShape2D:
		# If it's a rectangle, use half of the diagonal as the effective radius
		radius = shape.extents.length()
	# (You can add more shape checks here if using other shapes)

	# Generate a random angle between 0 and 2*PI
	var angle = randf() * PI * 2
	
	# Generate a random distance within the calculated radius
	var distance = randf() * radius
	
	# Convert polar coordinates (angle, distance) to Cartesian coordinates (x, y)
	var offset_x = cos(angle) * distance
	var offset_y = sin(angle) * distance
	
	return Vector2(offset_x, offset_y)
