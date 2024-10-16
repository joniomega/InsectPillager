extends Area2D

onready var big_circle = $BigCircle
onready var small_circle = $BigCircle/SmallCircle

onready var max_distance = $CollisionShape2D.shape.radius - 20

var touched = false
var joystick_direction = Vector2()

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(big_circle.global_position)
		if event.pressed:
			if not touched and distance < max_distance:
				touched = true
		else:
			if touched:
				touched = false
				small_circle.position = Vector2(0, 0)
				joystick_direction = Vector2()
	elif event is InputEventScreenDrag and touched:
		var direction = event.position - big_circle.global_position
		joystick_direction = direction.normalized()
		small_circle.global_position = big_circle.global_position + direction.clamped(max_distance)

func _process(delta):
	if touched:
		var direction = get_global_mouse_position() - big_circle.global_position
		joystick_direction = direction.normalized()
		small_circle.global_position = big_circle.global_position + direction.clamped(max_distance)
	else:
		joystick_direction = Vector2()
		small_circle.position = Vector2(0, 0)

