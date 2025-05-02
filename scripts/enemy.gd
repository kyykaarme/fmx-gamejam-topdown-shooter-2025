extends CharacterBody3D

var speed = 0.5
var health = 30
var damage = 10
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		if is_colliding_with_player():
			player.take_damage(damage)
			
func take_damage(amount):
	health -= amount
	print("Enemy hit, health: ", health)
	if health <= 0:
		queue_free()

func is_colliding_with_player():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("player"):
			return true
	return false
