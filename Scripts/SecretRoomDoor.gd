extends KinematicBody2D

export var sequence = ["A", "A#", "C", "C#"]
export var time_between_notes = 1
var notes_right = 0

var open = false

var player_in_area = false

signal player_in_area

func _ready():
	$Timer.wait_time = time_between_notes
	
	$ColorRect/GuideText.text = "| "
	for i in range(sequence.size()):
		$ColorRect/GuideText.text += sequence[i] + " | "
	$ColorRect.modulate.a = 0
	
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/NerkoOne-Regular.ttf")
	dynamic_font.size = float($ColorRect.rect_size.x) / sequence.size()
	$ColorRect.rect_size.x = $ColorRect/GuideText.rect_size.x*2
	$ColorRect.rect_size.y = dynamic_font.size*1.25
	$ColorRect/GuideText.add_font_override("font", dynamic_font)

func _process(_delta):
	if open:
		$Sprite.visible = false
		$OpenSprite.visible = true
		$CollisionShape2D.disabled = true
		$LeftSide.disabled = false
		$RightSide.disabled = false
		$CollisionShape2D.disabled = true
		$ColorRect.visible = false
	else:
		$Sprite.visible = true
		$OpenSprite.visible = false
		$CollisionShape2D.disabled = false
		$LeftSide.disabled = true
		$RightSide.disabled = true
		$CollisionShape2D.disabled = false
	
	if GameEvents.game_moment == 1:
		open = false
	
	if player_in_area and GameEvents.current_weapon != "Empty_Hand":
		if Input.is_action_just_pressed("Shoot_A"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("A#")
			else:
				check_note_in_array("A")
		if Input.is_action_just_pressed("Shoot_B"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("B#")
			else:
				check_note_in_array("B")		
		if Input.is_action_just_pressed("Shoot_C"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("C#")
			else:
				check_note_in_array("C")			
		if Input.is_action_just_pressed("Shoot_D"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("D#")
			else:
				check_note_in_array("D")	
		if Input.is_action_just_pressed("Shoot_E"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("E#")
			else:
				check_note_in_array("E")	
		if Input.is_action_just_pressed("Shoot_F"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("F#")
			else:
				check_note_in_array("F")
		if Input.is_action_just_pressed("Shoot_G"):
			if Input.is_action_pressed("Sharp_Note"):
				check_note_in_array("G#")
			else:
				check_note_in_array("G")	

func _on_Play_Area_body_entered(body):
	if "Player" in body.name:
		emit_signal("player_in_area")
		if !open:
			$ColorRect.modulate.a = 0.5
		player_in_area = true
		
func _on_Play_Area_body_exited(body):
	if "Player" in body.name:
		$ColorRect.modulate.a = 0
		player_in_area = false


var chars_changes = 0

func check_note_in_array(note):
	var note_existst = false
	
	for i in range (GameEvents.notes_unlocked.size()):
		if note[0] == GameEvents.notes_unlocked[i]:
			note_existst = true
			break
	
	if !note_existst:
		return
	
	if sequence[notes_right] == note:
		$Timer.start()
		notes_right += 1
		
		var word = $ColorRect/GuideText.text
		var already_changed = false
		var just_changed = false
		$ColorRect/GuideText.text = ""
		for i in range(word.length()):
			if word[i] == note[0] and !already_changed and i > chars_changes*4:
				$ColorRect/GuideText.push_color(Color.blue)
				chars_changes += 1
				already_changed = true
				just_changed = true
				
			else:
				$ColorRect/GuideText.push_color(Color(0.82745, 0.59215, 0.31764))
				
				if word[i] == "#" and just_changed:
					$ColorRect/GuideText.push_color(Color.blue)
				just_changed = false
				
			$ColorRect/GuideText.add_text(word[i])
	else:
		reset_sequence()

	if notes_right == sequence.size():
		if !open:
			$DoorUnlocked.play()
		open = true

func _on_Timer_timeout():
	reset_sequence()

func reset_sequence():
	#reset
	if notes_right > 0:
		notes_right = 0
		if !open:
			$Buzz.play()
	
		chars_changes = 0
		var word = $ColorRect/GuideText.text
		$ColorRect/GuideText.text = ""
		$ColorRect/GuideText.push_color(Color(0.82745, 0.59215, 0.31764))
		for i in range(word.length()):
			$ColorRect/GuideText.add_text(word[i])
