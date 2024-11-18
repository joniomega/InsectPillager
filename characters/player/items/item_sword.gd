extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sword_damage = 5
var global
# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	$Timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.lvlswordbool == true:
		sword_damage = sword_damage + 2
		print(str("SWORD DAMAGE: ",sword_damage))
		global.lvlswordbool = false
		pass

func _on_Timer_timeout():
	yield(get_tree(), "idle_frame")  # Wait for the current frame to finish processing
	$AnimatedSprite.play("swipe")
	$sound.play()
	$Area2D.monitorable = true
	$Area2D.monitoring = true
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.play("default")
	$Area2D.monitorable = false
	$Area2D.monitoring = false
	
	
	$Timer.start()

# Método llamado cuando el área 2D de la derecha detecta una colisión
func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		var damage = sword_damage + global.plussharpness
		body.recibir_danio(damage)
	for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("enemy"):
				var damage = sword_damage + global.plussharpness
				body.recibir_danio(damage)
	pass
