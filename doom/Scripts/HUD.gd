extends Control


onready var armor = $CanvasLayer/MarginContainer/Stats/Values/ArmorValue
onready var health = $CanvasLayer/MarginContainer/Stats/Values/HealthValue
onready var ammo = $CanvasLayer/MarginContainer/Stats/Ammo/AmmoValue


func _physics_process(delta):
	var currentGun = Global.curGun

	armor.text = Global.getArmor()
	health.text = Global.getHealth()

	if currentGun == 'Pistol':
		ammo.text = Global.getPistolAmmo()
	if currentGun == 'Shotgun':
		ammo.text = Global.getShellsAmmo()
	if currentGun == 'AK47':
		ammo.text = Global.getRifleAmmo()

