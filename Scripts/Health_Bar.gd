extends ProgressBar

func _process(_delta):
	value = GameEvents.current
	
	if GameEvents.current_weapon == "Guitar":
		$Current_Weapon.play("Guitar")
	elif GameEvents.current_weapon == "Empty_Hand":
		$Current_Weapon.play("Empty_Hand")
	
	if GameEvents.parchments_unlocked.size() > 0:
		$Parchment.visible = true
	else:
		$Parchment.visible = false
