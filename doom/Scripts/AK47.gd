extends Spatial


onready var sprite = $CanvasLayer/Control/AnimatedSprite
onready var rays = $Rays.get_children()
onready var blood = preload("res://Scenes/Objects/BloodParticle.tscn")

var damage = 5
var canShoot = true


func _ready():
	sprite.play("idle")


func checkHit():
	for ray in rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemy"):
				ray.get_collider().takeDamage(damage)
				var newBlood = blood.instance()
				get_node('/root/World').add_child(newBlood)
				newBlood.global_transform.origin = ray.get_collision_point()
				newBlood.emitting = true


func _physics_process(delta):
	if Input.is_action_pressed("shoot") and canShoot and Global.ammoRifle > 0:
		sprite.play("shoot")
		checkHit()
		Global.ammoRifle -= 1
		canShoot = false

		yield (sprite, "animation_finished")

		canShoot = true
		sprite.play("idle")


func _on_Timer_timeout():
	canShoot = true
