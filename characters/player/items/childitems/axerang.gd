extends KinematicBody2D

# Variables
const SPEED = 140
const MAX_BOUNCES = 3
const ROTATION_SPEED = 180  # Degrees per second for continuous rotation

var damage = 15
var direction = Vector2.ZERO
var target_position = Vector2.ZERO
var enemies_hit = 0
var bounce_positions = []
var has_target = false
var global

func _ready():
	global = get_node("/root/global")
	if global.lvlcrossbow >= 1:
		damage += global.lvlcrossbow + global.lvlcrossbow
	_update_enemy_list()
	_set_next_target()

func _update_enemy_list():
	# Find all enemies
	bounce_positions.clear()
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		if enemy and not enemy.is_queued_for_deletion():
			bounce_positions.append(enemy.global_position)
	bounce_positions.sort_custom(self, "_distance_comparator")

func _distance_comparator(a, b):
	return a.distance_to(global_position) < b.distance_to(global_position)

func _set_next_target():
	if bounce_positions.size() > 0:
		target_position = bounce_positions.pop_front()  # Get the next target position
		direction = global_position.direction_to(target_position)
		has_target = true
	else:
		queue_free()  # No more positions to target

func _physics_process(delta):
	if has_target:
		var collision = move_and_collide(direction * SPEED * delta)
		
		# Continuous rotation
		$AnimatedSprite.rotate(ROTATION_SPEED * delta)

		# Check if close enough to target_position
		if global_position.distance_to(target_position) < 10 or collision:
			_on_target_reached()

func _on_Area2D_body_entered(body):
	if body and body.is_in_group("enemy") and not body.is_queued_for_deletion():
		body.recibir_danio(damage)
		enemies_hit += 1
		if enemies_hit >= MAX_BOUNCES:
			queue_free()
		else:
			_update_enemy_list()  # Rebuild the enemy list
			_set_next_target()    # Set the next target position

func _on_target_reached():
	has_target = false
	if enemies_hit < MAX_BOUNCES:
		_set_next_target()
	else:
		queue_free()

func _on_Timer_timeout():
	queue_free()
