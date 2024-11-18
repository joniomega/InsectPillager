extends KinematicBody2D
var global
# Variables para el movimiento
var speed = 40  # Adjust as needed
var jump_height = 10.0  # Height of the jump
var jump_speed = 5.0  # Speed at which the jump cycle completes
var jump_time = 0.0  # Time variable to control the jump's vertical offset
var player = null
var playerbody
var exp_orb_scene = preload("res://characters/ExpOrb.tscn")
# Variables para el daño
var damageto = 10
# Variables para la vida del enemigo
var vida = 40

# Variables para AnimatedSprite
var animated_sprite

func _ready():
	self.z_index = 10
	global = get_node("/root/global")
	#AUGMENTAR VIDA I DAÑO SEGUN EL TIEMPO:
	if global.enemylvl > 1:
		vida = vida * global.enemylvl
		damageto = damageto * global.enemylvl
	# Obtener el AnimatedSprite
	animated_sprite = $AnimatedSprite
	# Find the player within the scene
	player = get_tree().get_nodes_in_group("player")[0]  # Assuming there's only one player in the group

func _physics_process(delta):
	if player:
		# Calculate direction to player
		var direction = (player.global_position - global_position).normalized()
		# Move towards the player
		move_and_slide(direction * speed)
		# Update animation based on direction
		update_animation(direction)
		# Make the sprite "jump"
		update_jump(delta)
	if playerbody != null:
		playerbody.recibir_danio(damageto)

func update_animation(direction):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("walk_right")
		else:
			animated_sprite.play("walk_left")
	else:
		if direction.y > 0:
			animated_sprite.play("walk_down")
		else:
			animated_sprite.play("walk_up")

func update_jump(delta):
	# Increment jump time to create the wave effect
	jump_time += delta * jump_speed
	var vertical_offset = sin(jump_time) * jump_height
	
	# Apply the vertical offset to the animated sprite (making it jump)
	$AnimatedSprite.position.y = vertical_offset

	# You can make the sprite slightly smaller during the peak of the jump
	# to simulate a bit of perspective, for example:
	# var scale_factor = 1.0 - (abs(sin(jump_time)) * 0.1)
	# $AnimatedSprite.scale = Vector2(scale_factor, scale_factor)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		playerbody = body
# Método para recibir daño
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		playerbody = null

func recibir_danio(damage):
	vida -= damage
	$AnimatedSprite.modulate = Color(2, 2, 1, 1)
	$damagecolor.start()
	
	if vida <= 0:
		# Liberar el nodo cuando la vida llega a cero
		global.enemitotal = global.enemitotal - 1
		# Spawn exp orb at enemy's position
		#if randi() % 2 == 0:
		if global.exporbtotal < global.exporbmax:
			var exp_orb = exp_orb_scene.instance()
			exp_orb.position = global_position
			get_parent().get_parent().call_deferred("add_child", exp_orb)
			global.exporbtotal = global.exporbtotal + 1
		
		call_deferred("queue_free")

func _on_damagecolor_timeout():
	$AnimatedSprite.modulate = Color(1, 1, 1, 1)
	pass # Replace with function body.
