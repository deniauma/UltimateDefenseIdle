extends KinematicBody2D

signal die

export (int) var hp = 50
export (int) var damage = 1
export (int) var speed = 50
export (Vector2) var target = Vector2()
var velocity = Vector2()

func _ready():
	add_to_group("enemies")


func _physics_process(delta):
	#target = get_global_mouse_position()
	velocity = (target - position).normalized() * speed
	rotation = Vector2(0, 1).angle_to(velocity)
	#print(str(rotation))
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
		
func take_damage(damage):
	hp = max(hp - damage, 0)
	if hp == 0:
		emit_signal("die")
		GameState.destroyed_enemies += 1
		queue_free()

