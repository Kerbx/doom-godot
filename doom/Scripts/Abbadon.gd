extends KinematicBody


onready var navigation = get_tree().get_nodes_in_group('navigation')[0]
onready var player = get_tree().get_nodes_in_group('player')[0]
onready var ray = $Visual

var path = []
var pathIndex = 0
export var speed = 10
export var health = 10
export var move = true


var searching = false
var shooting = false
var dead = false


func _ready():
	pass


func _physics_process(delta):
	if dead:
		return
	lookAtPlayer()
	if searching and not shooting:
		if pathIndex < path.size():
			var direction = (path[pathIndex] - global_transform.origin)
			if direction.length() < 1:
				pathIndex += 1
			else:
				if move:
					$AnimatedSprite3D.play("walking")
					move_and_slide(direction.normalized() * speed * delta, Vector3.UP)
	else:
		if not shooting:
			$AnimatedSprite3D.play("idle")


func lookAtPlayer():
	ray.look_at(player.global_transform.origin, Vector3.UP)
	if ray.is_colliding():
		if ray.get_collider().is_in_group("player"):
			searching = true

		else:
			searching = false
			var checkNear = $Ear.get_overlapping_bodies()

			for body in checkNear:
				if body.is_in_group("player"):
					searching = true


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
	dead = true
	set_process(false)
	set_physics_process(false)
	$CollisionShape.disabled = true
	if health < -20:
		$AnimatedSprite3D.play("die")
	else:
		$AnimatedSprite3D.play('die')

	return

func shoot():
	if searching and not dead and not shooting:
		$AnimatedSprite3D.play("attack")
		shooting = true
		yield ($AnimatedSprite3D, "frame_changed")
		if ray.is_colliding():
			if ray.get_collider().is_in_group("player"):
				Global.changeHealth(-5)
		yield ($AnimatedSprite3D, "animation_finished")
		shooting = false


func _on_Timer_timeout():
	findPath(player.global_transform.origin)


func _on_Ear_body_entered(body):
	if body.is_in_group("player"):
		searching = true


func _on_ShootingTimer_timeout():
	shoot()
