extends Camera2D


# Initial position
var initial_position = Vector2(500, 360)
# Target position when moving right
var right_position = Vector2(1200, 500)
# Target position when moving left
var left_position = Vector2(-150, 400)
#DEFINE THE POSITIONS
var location = 0
# Duration for the movement
var move_duration = 0.5

func _ready():
	global_position = initial_position
	

func _on_right_button_pressed():
	# Smoothly move the camera to the right position
	if location == 1:
		move_camera_to(left_position)
		location = 2
	elif location == 0:
		move_camera_to(right_position)
		location = 1
	elif location == 2:
		move_camera_to(initial_position)
		location = 0
	

func _on_left_button_pressed():
	# Smoothly move the camera back to the initial position
	if location == 2:
		move_camera_to(right_position)
		location = 1
	elif location == 0:
		move_camera_to(left_position)
		location = 2
	elif location == 1:
		move_camera_to(initial_position)
		location = 0

func move_camera_to(target_position: Vector2):
	$buttonsound.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_position, move_duration)
