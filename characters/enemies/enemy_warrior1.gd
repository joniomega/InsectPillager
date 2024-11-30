extends KinematicBody2D

# Variables para el movimiento
var global
var speed = 20  # Adjust as needed
var player = null
var playerbody
var exp_orb_scene = preload("res://characters/ExpOrb.tscn")
# Variables para el daño
var damage = 17
# Variables para la vida del enemigo
var vida = 50

# Variables para AnimatedSprite
var animated_sprite

func _ready():
	self.z_index = 10
	global = get_node("/root/global")
	#AUGMENTAR VIDA I DAÑO SEGUN EL TIEMPO:
	if global.enemylvl >= 1:
		vida = vida +(global.enemylvl *4)
		damage = damage + (global.enemylvl*2)
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
	if playerbody != null:
		playerbody.recibir_danio(damage)

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


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		playerbody = body
# Método para recibir daño
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		playerbody = null
	pass # Replace with function body.

func recibir_danio(damage):
	vida -= damage
	animated_sprite.modulate = Color(2, 2, 1, 1)
	$damagecolor.start()
	
	if vida <= 0:
		# Liberar el nodo cuando la vida llega a cero
		global.enemitotal = global.enemitotal - 1
		# Spawn exp orb at enemy's position
		if global.exporbtotal < global.exporbmax:
			var exp_orb = exp_orb_scene.instance()
			exp_orb.position = global_position
			get_parent().get_parent().call_deferred("add_child", exp_orb)
			global.exporbtotal = global.exporbtotal + 1
		
		call_deferred("queue_free")


func _on_damagecolor_timeout():
	animated_sprite.modulate = Color(1, 1, 1, 1)
	pass # Replace with function body.
