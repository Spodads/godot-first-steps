extends CharacterBody2D

const SPEED = 300.0

@onready var sprite = $AnimatedSprite2D
@onready var attack_area = $AttackArea

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	update_animation(direction)
	update_attack_position(direction)
	check_attack_input()
	
func update_animation(direction):
	if direction == Vector2.ZERO:
		return
	if direction.y < 0:
		sprite.play("up")
		sprite.flip_h = false
	else:
		sprite.play("down")
		sprite.flip_h = direction.x < 0
		
func update_attack_position(direction):
	if direction.x > 0:
		attack_area.position = Vector2(40, 0)
	elif direction.x < 0:
		attack_area.position = Vector2(-40, 0)
	elif direction.y < 0:
		attack_area.position = Vector2(0, -40)
	elif direction.y > 0:
		attack_area.position = Vector2(0, 40)
		
func check_attack_input():
	if Input.is_action_just_pressed("ui_accept"):
		attack()
				
func attack():
	for body in attack_area.get_overlapping_bodies():
		if body == self:
			continue
		if body.is_in_group("enemy"):
			body.take_damage(2)
