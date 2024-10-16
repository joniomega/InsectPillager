extends Node2D

# Variables
var bullet_scene = preload("res://characters/player/items/childitems/axerang.tscn")
var speed = 1200  # Speed of the boomerang
var max_bounces = 3  # Maximum enemies to bounce to

# Timer for cooldown
onready var waiting_timer = $Timer
onready var detection_area = $Area2D


# Tiempo entre cada spawn de bala (en segundos)
const SPAWN_INTERVAL = 3
# Timer para controlar el spawn de balas
var spawn_timer
var canshoot = false

func _ready():
	# Crear y configurar el temporizador
	spawn_timer = Timer.new()
	spawn_timer.wait_time = SPAWN_INTERVAL
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	add_child(spawn_timer)
	spawn_timer.start()
func _process(delta):
	# Check if any physics body is currently overlapping with the Area2D
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemy"):
			canshoot = true
			break

func _on_spawn_timer_timeout():
	# Instanciar la bala y agregarla al escenario
	if canshoot == true:
		var new_bullet = bullet_scene.instance()
		new_bullet.position = $Node2D.global_position
		get_parent().get_parent().get_parent().add_child(new_bullet)
		canshoot = false
	else:
		pass
