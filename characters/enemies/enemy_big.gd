extends KinematicBody2D

# Variables para el movimiento
var global
var speed = 35  # Adjust as needed
var player = null
var playerbody
var exp_orb_scene = preload("res://characters/player/items/object.tscn")
# Variables para el daño
var damage = 30
# Variables para la vida del enemigo
var vida = 800

# Variables para AnimatedSprite
var animated_sprite

func _ready():
	self.z_index = 10
	global = get_node("/root/global")
	#AUGMENTAR TOTAL ENEMIGOS GRANDESSS
	global.enemibigtotal = global.enemibigtotal + 1
	#AUGMENTAR VIDA I DAÑO SEGUN EL TIEMPO:
	if global.enemylvl >= 1:
		vida = vida + (global.enemylvl * 6)
		damage = damage + (global.enemylvl *2)
	# Obtener el AnimatedSprite
	if get_parent().name == "spawners1":
		animated_sprite = $AnimatedSprite2
	elif get_parent().name == "spawners3":
		animated_sprite = $AnimatedSprite3
	elif get_parent().name == "spawners4":
		animated_sprite = $AnimatedSprite1
	elif get_parent().name == "spawners2":
		animated_sprite = $AnimatedSprite1

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
	$damagesound.play()
	vida -= damage
	$blood.restart()
	$blood.emitting = true
	animated_sprite.modulate = Color(2, 2, 1, 1)
	$damagecolor.start()
	
	if vida <= 0:
		# Liberar el nodo cuando la vida llega a cero
		global.enemitotal = global.enemitotal - 1
		global.enemibigtotal = global.enemibigtotal - 1
		# Spawn exp orb at enemy's position
		var exp_orb = exp_orb_scene.instance()
		exp_orb.position = global_position
		get_parent().get_parent().call_deferred("add_child", exp_orb)
		
		call_deferred("queue_free")


func _on_damagecolor_timeout():
	animated_sprite.modulate = Color(1, 1, 1, 1)
	pass # Replace with function body.
