extends KinematicBody2D

const SPEED = 300
var DAMAGE = 15
const INFINITY = 999
var direction = Vector2.ZERO
var target_enemy = null
var global

func _ready():
	global = get_node("/root/global")
	if global.lvlcrossbow >= 1:
		DAMAGE = DAMAGE + global.lvlcrossbow + global.lvlcrossbow
	# Buscar el enemigo más cercano
	var enemies = get_tree().get_nodes_in_group("enemy")
	var closest_enemy = null
	var closest_distance = INFINITY
	for enemy in enemies:
		var distance = enemy.global_position.distance_to(global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	# Establecer el enemigo más cercano como objetivo
	target_enemy = closest_enemy
	if target_enemy:
		# Establecer la dirección de movimiento hacia el enemigo
		direction = global_position.direction_to(target_enemy.global_position)
		rotation = direction.angle()

func _physics_process(delta):
	# Mover la bala en la dirección especificada
	move_and_collide(direction * SPEED * delta)
	# Calcular el ángulo de rotación hacia el enemigo
	var angle = direction.angle_to(Vector2.UP)
	# Rotar el AnimatedSprite según el ángulo calculado
	$AnimatedSprite.rotation_degrees = angle

func _on_Area2D_body_entered(body):
	# Aplicar daño al enemigo si colisiona con él
	if body.is_in_group("enemy"):
		var damage = DAMAGE + global.plussharpness
		body.recibir_danio(damage)
		queue_free()
	# Eliminar la bala después de la colisión
	
func _on_Timer_timeout():
	queue_free()
