extends Spatial


onready var sprite = $CanvasLayer/Control/AnimatedSprite
onready var rays = $Rays.get_children()

var damage = 5
var canShoot = true


func _ready():
	sprite.play("idle")


func checkHit():
	for ray in rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemy"):
				ray.get_collider().takeDamage(damage)


func _physics_process(delta):
	if Input.is_action_just_pressed("shoot") and canShoot:
		sprite.play("shoot")
		checkHit()
		canShoot = false

		yield (sprite, "animation_finished")

		canShoot = true
		sprite.play("idle")
