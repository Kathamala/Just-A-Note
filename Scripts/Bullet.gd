extends RigidBody2D

var bullet_note = ""

func _ready():
	$Timer.start()
	
func _process(_delta):
	if(!$VisibilityNotifier2D.is_on_screen()):
		kill_bullet()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullet_Limit") or body.is_in_group("Enemy"):
		kill_bullet()

func _on_Timer_timeout():
	kill_bullet()

func kill_bullet():
	queue_free()
	GameEvents.bullet_count -= 1
