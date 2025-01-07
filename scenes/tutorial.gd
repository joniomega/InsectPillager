extends Node2D

var global
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/global")
	if self.name == "tutorial":
		$state0.visible = false
		$state1.visible = false
		$state2.visible = false
		if global.sstate == 0:
			$state0.visible = true
			pass
		elif global.sstate == 1:
			$state1.visible = true
			pass
		elif global.sstate == 2:
			$state2.visible = true
			pass # Replace with function body.
	if self.name == "tutoriallvl":
		
		tutoriallvl()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.name == "tutorial":
		if global.sstate == 2:
			$state2.visible = true
			$state0.visible = false
			$state1.visible = false
	pass
func tutoriallvl():
	$ui/tip1/Label2.text = tr("tutorialtip1")
	$ui/tip2/Label2.text = tr("tutorialtip2")
	$ui/tip3/Label2.text = tr("tutorialtip3")
	$ui/tip4/Label2.text = tr("tutorialtip4")
	if global.sstate == 1:
		$ui/tip1.visible = true
		$ui/Timer.start()
	pass

func _on_Timer_timeout():
	if $ui/tip1.visible == true:
		$ui/tip1.visible = false
		$ui/tip2.visible = true
		$ui/Timer.start()
	elif $ui/tip2.visible == true:
		$ui/tip2.visible = false
		$ui/tip3.visible = true
		$ui/Timer.start()
	elif $ui/tip3.visible == true:
		$ui/tip3.visible = false
		$ui/tip4.visible = true
		$ui/Timer.start()
	elif $ui/tip4.visible == true:
		$ui/tip4.visible = false
	pass # Replace with function body.
