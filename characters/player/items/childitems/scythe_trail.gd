extends Node2D

# Variables
export var damage = 13  # Base damage for the trail
export var speed = 70  # Speed of movement
var direction = Vector2(0, -1)  # Default direction is up
var global

# Direction to animation mapping
var animations = {
	Vector2(0, -1): "up",
	Vector2(0, 1): "down",
	Vector2(-1, 0): "left",
	Vector2(1, 0): "right"
}

# Nodes
onready var area = $Area2D
onready var timer = $Timer
onready var sprite = $sprite  # Reference to AnimatedSprite

func _ready():
	global = get_node("/root/global")
	damage = damage + global.lvlscythe + global.lvlscythe + global.plussoulpower
	timer.start()
	update_animation()

func _process(delta):
	# Move the scythe trail in the current direction
	position += direction * speed * delta

func _on_Timer_timeout():
	# Destroy the scythe after some time
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.recibir_danio(damage)  # Apply damage to the enemy

func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()
	update_animation()

func update_animation():
	# Set the animation based on the direction
	var anim = animations.get(direction, "up")  # Default to "up" if direction not found
	$sprite.play(anim)
	if anim == "up":
		$Area2D.rotation_degrees = 180
		
	if anim == "left":
		$Area2D.rotation_degrees = 90
		$Area2D/air.angle = 0
	if anim == "right":
		$Area2D.rotation_degrees = -90
		$Area2D/air.angle = 180
