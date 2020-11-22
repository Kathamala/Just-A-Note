extends Node

var current_parchment = "A"
var current_weapon = "Empty_Hand"

var notes_unlocked = []
var weapons_unlocked = []
var parchments_unlocked = []

var bullet_count = 0
var max_bullet_count = 5

func _ready():
	weapons_unlocked.append(current_weapon)
	weapons_unlocked.append("Guitar")
	print(current_weapon)
	
func _process(delta):
	if Input.is_action_just_pressed("Change_Weapon"):
		if weapons_unlocked.size() <= 1:
			return
		weapon_change()

			
func weapon_change():
	for i in range(0, weapons_unlocked.size()):		
		if current_weapon == weapons_unlocked[i]:
			if(i < weapons_unlocked.size()-1):
				current_weapon = weapons_unlocked[i+1]
				return
			elif(i == weapons_unlocked.size()-1):
				current_weapon = weapons_unlocked[0]
				return