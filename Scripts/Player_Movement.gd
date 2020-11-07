extends KinematicBody2D

export var speed = 30
var velocity = Vector2()

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x = 7
	if Input.is_action_pressed("ui_left"):
		velocity.x = -7
	if Input.is_action_pressed("ui_up"):
		velocity.y = -7
	if Input.is_action_pressed("ui_down"):
		velocity.y = 7				
	move_and_slide(velocity*speed)
