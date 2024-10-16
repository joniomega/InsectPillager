extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var global
var damage = 15
onready var area = get_node("scythe_trail/Area2D")
onready var sprite = get_node("scythe_trail/sprite")
onready var scythe = get_node("scythe_trail")
onready var timer = get_node("Timer")
onready var animated_sprite = get_node("scythe_trail/sprite")

var directions = [Vector2(0, -1), Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0)] # Up, Right, Down, Left
var animations = ["move_up", "move_right", "move_down", "move_left"]
var rotations = [PI, -PI/2, 0, PI/2] # 180, -90, 0, 90 degrees
var current_direction_index = 0
var speed = 150 # Adjust the speed as needed

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.lvlscythebool == true:
		damage = damage + 5
		print(str("SCYTHE DAMAGE: ",damage))
		global.lvlscythebool = false
		pass
	scythe.move_and_slide(directions[current_direction_index] * speed)
	play_animation_for_direction(current_direction_index)

func _on_Timer_timeout():
	# Reset the scythe to its original position
	scythe.global_position = global_position

	# Move to the next direction
	current_direction_index = (current_direction_index + 1) % directions.size()

	# Restart the timer
	timer.start()

func play_animation_for_direction(direction_index):
#	match direction_index:
#		0:
#			animated_sprite.play("up")
#		1:
#			animated_sprite.play("right")
#		2:
#			animated_sprite.play("down")
#		3:
#			animated_sprite.play("left")
	
	# Rotate the area based on the direction
	area.rotation = rotations[direction_index]
	animated_sprite.rotation = rotations[direction_index]


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.recibir_danio(damage)
	pass # Replace with function body.
