extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var damage_amount = 10
func _ready():
	$Timer.start()
	$particles.emitting = true
	$Soulscristal_as.play("default")
	pass # Replace with function body.

func _on_area_damage_body_entered(body):
	if body.is_in_group("enemy"):
		body.recibir_danio(damage_amount)

func damageincrease(damage):
	damage_amount = damage
	print("LETSGOOOOOO"+ str(damage_amount))
	pass

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
