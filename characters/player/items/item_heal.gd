extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cura = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.curar_dano(cura)
		$potion.emitting = true
		
	pass # Replace with function body.


func _on_Timer_timeout():
	queue_free()
