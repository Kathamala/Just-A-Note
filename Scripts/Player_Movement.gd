extends KinematicBody2D

export var max_health = 1000
var current_health = 1000

var speed = 100
export var slow_speed = 75
export var fast_speed = 150
var velocity = Vector2()

var bullet_speed = 2000
var bullet = preload("res://Scenes/Bullet.tscn")

func _physics_process(delta):
	move(delta)
	
	if GameEvents.current_weapon != "Empty_Hand":
		speed = slow_speed
		if Input.is_action_pressed("Shoot_A"):
			shoot("A")
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
	if GameEvents.bullet_count > GameEvents.max_bullet_count:
		return
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

func died():
	get_tree().reload_current_scene()
