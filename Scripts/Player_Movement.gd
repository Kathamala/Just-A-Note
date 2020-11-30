extends KinematicBody2D

var speed = 100
export var slow_speed = 75
export var fast_speed = 150
var velocity = Vector2()

var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")

var knockback = Vector2.ZERO
export var knockback_power = 0.25

signal collision(body)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	move(delta)
	
	if GameEvents.current_weapon != "Empty_Hand":
		speed = slow_speed
		if Input.is_action_just_pressed("Shoot_A"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("A#")
			else:
				shoot("A")
		if Input.is_action_just_pressed("Shoot_B"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("B#")
			else:
				shoot("B")		
		if Input.is_action_just_pressed("Shoot_C"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("C#")
			else:
				shoot("C")			
		if Input.is_action_just_pressed("Shoot_D"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("D#")
			else:
				shoot("D")	
		if Input.is_action_just_pressed("Shoot_E"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("E#")
			else:
				shoot("E")	
		if Input.is_action_just_pressed("Shoot_F"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("F#")
			else:
				shoot("F")
		if Input.is_action_just_pressed("Shoot_G"):
			if Input.is_action_pressed("Sharp_Note"):
				shoot("G#")
			else:
				shoot("G")
	else:
		speed = fast_speed

func move(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		$CollisionShape2D/Sprite.flip_h = false
		velocity.x = 7
	if Input.is_action_pressed("ui_left"):
		$CollisionShape2D/Sprite.flip_h = true
		velocity.x = -7
	if Input.is_action_pressed("ui_up"):
		velocity.y = -7
	if Input.is_action_pressed("ui_down"):
		velocity.y = 7
	move_and_slide(velocity*speed)	

func shoot(note):
	#check bullet count
	if GameEvents.bullet_count > GameEvents.max_bullet_count:
		return
		
	#check if note exists
	var can_go = false
	for i in range(0, GameEvents.notes_unlocked.size()):
		if GameEvents.notes_unlocked[i] == note[0]:
			can_go = true
	if !can_go:
		return
	
	play_audio(note)
	
	var bullet_instance = bullet.instance()
	GameEvents.bullet_count += 1
	bullet_instance.bullet_note = note
	bullet_instance.position = get_global_position()
	if $CollisionShape2D/Sprite.flip_h == false:
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0))
	else:
		bullet_instance.position -= Vector2(20, 0)
		bullet_instance.apply_impulse(Vector2(), Vector2(-bullet_speed, 0))
	
	get_tree().get_root().call_deferred("add_child", bullet_instance)

func play_audio(note):
	if note == "A":
		$A.play()
	if note == "A#":
		$AS.play()
	if note == "C":
		$C.play()
	if note == "C#":
		$CS.play()

func _on_Area2D_area_entered(area):
	if area.is_in_group("Enemy"):
		if area.get_parent().position.x > position.x:
			knockback = (Vector2(area.position.x - position.x, area.position.y - position.y)) * knockback_power
		elif area.get_parent().position.x < position.x:
			knockback = -(Vector2(area.position.x - position.x, area.position.y - position.y)) * knockback_power
			
	emit_signal("collision", area)
