extends ColorRect

var texts_displayed = 0
var displayed_damage_taken = false
var displayed_enemy_dead = false
var displayed_door = false

func _ready():
# warning-ignore:return_value_discarded
	get_parent().get_parent().get_child(1).connect("collision", self, "_on_Player_Collision")
# warning-ignore:return_value_discarded
	get_parent().get_parent().get_child(3).get_child(0).connect("dead", self, "_on_Enemy_Dead")
# warning-ignore:return_value_discarded
	get_parent().get_parent().get_child(4).get_child(4).connect("player_in_area", self, "_on_Player_In_Area")
# warning-ignore:return_value_discarded
	get_parent().get_parent().get_child(4).get_child(5).connect("player_in_area", self, "_on_Player_In_Area")
	$TutorialText.text = "HEY MINDUIM, WELCOME TO 'JUST A NOTE'. \n THERE IS MUCH TO EXPLAIN, BUT FOR NOW, \n LET'S JUST GET OUT OF HERE \n GO RIGHT =======>"
	texts_displayed += 1

func _process(_delta):
	if GameEvents.parchments_unlocked.size() > 0 and texts_displayed <= 2:
		$TutorialText.text = "YOU FOUND YOUR FIRST PARCHMENT. WITH THIS, YOU NOW KNOW HOW TO ATTACK YOUR ENEMYS. \n EACH ENEMY HAS A NOTE. ALWAYS ATTACK ENEMYS WITH THE PREVIOUS NOTE ON THE PARCHMENT. \n IT WILL WORK, TRUST ME!"
		texts_displayed += 1
	elif GameEvents.notes_unlocked.size() > 0 and texts_displayed <= 3:
		$TutorialText.text = "YOU GOT AN 'A' NOTE. \n YOU CAN SHOOT IT TO KILL 'B' ENEMYS. \n YOU NEED A GUITAR FIRST, THOUGH. \n TRY GETTING THAT GUITAR AT THE TOP."
		texts_displayed += 1
	elif GameEvents.weapons_unlocked.size() > 1 and texts_displayed <= 4:
		$TutorialText.text = "YOU HAVE A GUITAR. IF YOU HAVE THE NOTE AND THE PARCHMENT YOU CAN ATTACK THE ENEMY NOW! \n SHOOOOOOOOOOOOOOOT \n PRESS R TO SHOOT."
		texts_displayed += 1
	elif get_parent().get_parent().get_child(1).position.y < 500 and texts_displayed == 5:
		$TutorialText.text = "YOU CAN PRESS TAB ANYTIME TO CHANGE YOUR WEAPON \n WITH THE EMPTY HAND YOU'LL BE FASTER, BUT YOU CAN'T USE YOUR GUITAR. \n CHOSE YOUR WEAPON WISELY."
		texts_displayed += 1
	elif get_parent().get_parent().get_child(1).position.x > 2400 and texts_displayed == 6:
		$TutorialText.text = "THIS IS A D# ENEMY, YOU CAN'T ATTACK HIM RIGHT NOW. \n JUST RUN PAST HIM!"
		texts_displayed += 1
	elif get_parent().get_parent().get_child(1).position.x > 4004 and get_parent().get_parent().get_child(1).position.y > 3438 and texts_displayed == 7:
		$TutorialText.text = "YOU CAN SHOOT SHARP NOTES BY HOLDING THE LEFT SHIFT BUTTON, AND THEN SHOOTING. \n TRY SHOOTING THE 'A#' WITH TAB+R"
		texts_displayed += 1		
	elif GameEvents.notes_unlocked.size() == 2 and texts_displayed == 8:
		$TutorialText.text = "NICE, NOW YOU CAN SHOOT THE 'C' NOTE. \n USE THE 'C#' TO KILL THOSE 'D#' ENEMYS."
		texts_displayed += 1
	elif GameEvents.game_moment == 1:
		$TutorialText.text = "OKAY, OKAY, KEEP CALM... \n RUUUUUUUUUUUUUN!"
		texts_displayed += 1		

func _on_Player_Collision(area):
	if area.is_in_group("Enemy"):
		if !displayed_damage_taken:
			$TutorialText.text = "OUCH, GET AWAY FROM HIM!!!"
			displayed_damage_taken = true

func _on_Enemy_Dead():
	if !displayed_enemy_dead:
		$TutorialText.text = "NICE, YOU REALLY GOT HIM. \n KEEP GOING!"
		displayed_enemy_dead = true	

func _on_Player_In_Area():
	if GameEvents.notes_unlocked.size() <= 1:
		$TutorialText.text = "YOU CAN'T OPEN THIS DOOR RIGHT NOW, \n JUST KEEP GOING"
	elif GameEvents.notes_unlocked.size() == 2 and !displayed_door:
		$TutorialText.text = "PLAY THE NOTE SEQUENCE TO OPEN THIS DOOR \n YOU HAVE 1 SECOND BETWEEN NOTES."
		displayed_door = true

func _on_Green_Guitar_Pick_tree_exiting():
	$TutorialText.text = "NICE, YOU GOT A GREEN PICK. \n A GREAT MUSICIAN SHOULD ALWAYS HAVE A GUITAR PICK WITH HIM."
