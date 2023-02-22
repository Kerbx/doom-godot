extends KinematicBody


var velocity = Vector3()
export var ROTATION = 0.01
export var SPEED = 1000
export var GRAVITY = -20
export var health = 100

var rotationX = 0
var rotationY = 0

onready var pistol = preload("res://Scenes/Guns/Pistol.tscn")
onready var shotgun = preload("res://Scenes/Guns/Shotgun.tscn")
var currentGun = 0
onready var guns = [pistol, shotgun]


func _ready():
	pass


func _physics_process(delta):
	var direction = Vector3()

	if Input.is_action_just_released("nextGun"):
		currentGun += 1
		if currentGun > len(guns) - 1:
			currentGun = 0
			changeGun(currentGun)
	elif Input.is_action_just_released("prevGun"):
		currentGun -= 1
		if currentGun < 0:
			currentGun = len(guns) - 1
			changeGun(currentGun)

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_pressed("move_forward"):
		direction.z = -1
	if Input.is_action_pressed("move_backward"):
		direction.z = 1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1

	if direction:
		direction *= SPEED * delta
		direction = direction.rotated(Vector3.UP, rotation.y)

	velocity.x = direction.x
	velocity.z = direction.z

	velocity.y += GRAVITY * delta

	velocity = move_and_slide(velocity, Vector3.UP)


func _input(e):
	# dont fucking say it.
	if e is InputEventMouseMotion:
		rotationX -= e.relative.y * ROTATION
		rotationY -= e.relative.x * ROTATION

		if rotationX < -1.5:
			rotationX = -1.5
		elif rotationX > 1.5:
			rotationX = 1.5

		transform.basis = Basis(Vector3.UP, rotationY)
		$Pivot/Camera.transform.basis = Basis(Vector3.RIGHT, rotationX)


func getDamage(damageAmount):
	pass


func die():
	pass


func changeGun(gun):
	$Pivot/Camera/Gun.get_child(0).queue_free()
	var new = guns[gun].instance()
	$Pivot/Camera/Gun.add_child(new)
