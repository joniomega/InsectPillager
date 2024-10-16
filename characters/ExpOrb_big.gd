extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var exp_amount = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$blood.emitting = true
	$sound.play()
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.add_exp(3)
		queue_free()
