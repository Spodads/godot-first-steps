extends CharacterBody2D

const SPEED = 120.0

var max_hp: int = 5
var hp: int = 5

@onready var player = get_tree().get_first_node_in_group("player")
@onready var hp_label = $HpLabel

func _ready():
	update_hp_label()

func _physics_process(_delta):
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()

func take_damage(amount: int):
	hp -= amount
	update_hp_label()
	if hp <= 0:
		queue_free()

func update_hp_label():
	hp_label.text = str(hp) + "/" + str(max_hp)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
