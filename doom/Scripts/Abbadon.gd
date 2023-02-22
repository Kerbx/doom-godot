extends KinematicBody


onready var navigation = get_tree().get_nodes_in_group('navigation')[0]
onready var player = get_tree().get_nodes_in_group('player')[0]

var path = []
var pathIndex = 0
var speed = 10
var health = 10
var move = true

func _ready():
	pass


func _physics_process(delta):
	if pathIndex < path.size():
		var direction = (path[pathIndex] - global_transform.origin)
		if direction.length() < 1:
			pathIndex += 1
		else:
			if move:
				$AnimatedSprite3D.play("walking")
				move_and_slide(direction.normalized() * speed, Vector3.UP)

	else:
		findPath(player.global_transform.origin)


func takeDamage(amount):
	health -= amount
	if health <= 0:
		death()
		return
	move = false
	$AnimatedSprite3D.play("getDamage")
	yield($AnimatedSprite3D, "animation_finished")
	move = true


func findPath(target):
	path = navigation.get_simple_path(global_transform.origin, target)
	pathIndex = 0


func death():
	set_process(false)
	set_physics_process(false)
	$CollisionShape.disabled = true
	if health < -20:
		$AnimatedSprite3D.play("die")
	else:
		$AnimatedSprite3D.play('die')
	
	return

func shoot(target):
	pass
