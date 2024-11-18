extends Node2D

var global
const DAMAGE_REPEL_RADIUS = 50
const PUSH_FORCE = 200
var enemylist = []
var damage_per_tick = 5
var player = null
var speed = 65
var DAMAGE


func _ready():
#	player = get_tree().get_nodes_in_group("player")[0]
	global = get_node("/root/global")
	$sprite.z_index = -1
	# Connect the timer's timeout signal to the method for spawning the bubble
	# Start the timer
	pass

func _process(delta):
	if global.lvlbubblebool == true:
		damage_per_tick = damage_per_tick + 2 + global.plussoulpower
		global.lvlbubblebool = false
		pass
	
#	if player:
		# Calculate direction to player
#		var direction = (player.global_position - global_position).normalized()
		# Move towards the player
#		if player.global_position == position:
#			pass
#		else:
#			if player.global_position != position:
#				position += direction * speed * delta
		# Update animation based on direction
		
	# Apply damage to each enemy in the area every tick
	for enemy in enemylist:
		if enemy:  # Check if the enemy still exists
			enemy.recibir_danio(damage_per_tick * delta)


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		enemylist.append(body)
		# Calculate the direction from the bubble to the enemy
		# Apply a force to push the enemy away from the bubble
	pass

func _on_Area2D_body_exited(body):
	if body.is_in_group("enemy"):
		enemylist.erase(body)
	pass
