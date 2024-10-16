extends Node2D
var global

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var exp_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	$sound.play()
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		global.exporbtotal = global.exporbtotal-1
		body.add_exp(1)
		queue_free()
