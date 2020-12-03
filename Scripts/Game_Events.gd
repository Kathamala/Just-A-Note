extends Node

export var max_amount = 100
onready var current = max_amount

var current_parchment = "A"
var current_weapon = "Empty_Hand"

var notes_unlocked = []
var weapons_unlocked = []
var parchments_unlocked = []
var collectables_unlocked = []

var E_Parchment = ["E", "F#", "G#", "A", "B", "C#", "D#"]

var bullet_count = 0
var max_bullet_count = 5

var win = false

var game_moment = 0

func _ready():
	game_moment = 0
	weapons_unlocked.append(current_weapon)
	
	#unlock everything
	#notes_unlocked.append("A")
	#notes_unlocked.append("C")
	#parchments_unlocked.append("E")
	#weapons_unlocked.append("Guitar")
	
	
func _process(_delta):
	if Input.is_action_just_pressed("Change_Weapon"):
		if weapons_unlocked.size() <= 1:
			return
		weapon_change()
	
	if current == 0:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
			
func weapon_change():
	for i in range(0, weapons_unlocked.size()):		
		if current_weapon == weapons_unlocked[i]:
			if(i < weapons_unlocked.size()-1):
				current_weapon = weapons_unlocked[i+1]
				return
			elif(i == weapons_unlocked.size()-1):
				current_weapon = weapons_unlocked[0]
				return
