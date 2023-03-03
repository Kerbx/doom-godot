extends MeshInstance


export var opened = false
onready var anim = $DoorAnimation


func open():
	opened = true
	anim.play("open")
	yield(get_tree().create_timer(1.0), "timeout")
	yield(get_tree().create_timer(2.0), "timeout")
	anim.play("close")
	yield(get_tree().create_timer(1.0), "timeout")
	anim.stop()
	opened = false
