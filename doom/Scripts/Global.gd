extends Node


var health = 100
var maxHealth = 200
var armor = 0
var maxArmor = 100
var guns = []
var ammoPistol = 50
var ammoRocket = 0
var ammoShells = 0
var ammoPlasma = 0
var ammoRifle = 100
var maxAmmoPistol = 200
var maxAmmoRocket = 20
var maxAmmoShells = 50
var maxAmmoPlasma = 100
var maxAmmoRifle = 500

var redKey = false
var blueKey = false
var yellowKey = false
var curGun = "Pistol"


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.center_window()


func reset():
	var health = 100
	var maxHealth = 200
	var armor = 0
	var maxArmor = 100
	var guns = []
	var ammoPistol = 50
	var ammoRocket = 0
	var ammoShells = 0
	var ammoPlasma = 0
	var ammoRifle = 100
	var maxAmmoPistol = 200
	var maxAmmoRocket = 20
	var maxAmmoShells = 50
	var maxAmmoPlasma = 100
	var maxAmmoRifle = 500

	var redKey = false
	var blueKey = false
	var yellowKey = false
	var curGun = "Pistol"


func takeDamage(amount):
	if amount > armor:
		amount = amount - armor
		armor = 0
	else:
		changeArmor(-amount)
		return
	changeHealth(-amount)


func changeHealth(amount):
	health += amount
	health = clamp(health, 0, maxHealth)


func changeArmor(amount):
	armor += amount
	armor = clamp(armor, 0, maxArmor)


func changePistolAmmo(amount):
	ammoPistol += amount
	ammoPistol = clamp(ammoPistol, 0, maxAmmoPistol)


func changeRocketAmmo(amount):
	ammoRocket += amount
	ammoRocket = clamp(ammoRocket, 0, maxAmmoRocket)


func changeShellsAmmo(amount):
	ammoShells += amount
	ammoShells = clamp(ammoShells, 0, maxAmmoShells)


func changePlasmaAmmo(amount):
	ammoPlasma += amount
	ammoPlasma = clamp(ammoPlasma, 0, maxAmmoPlasma)


func changeRifleAmmo(amount):
	ammoRifle += amount
	ammoRifle = clamp(ammoRifle, 0, maxAmmoRifle)


func getPistolAmmo():
	return str(ammoPistol)


func getShellsAmmo():
	return str(ammoShells)


func getRocketAmmo():
	return str(ammoRocket)


func getPlasmaAmmo():
	return str(ammoPlasma)


func getHealth():
	return str(health)


func getArmor():
	return str(armor)


func getRifleAmmo():
	return str(ammoRifle)
