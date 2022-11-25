extends Area

export var velocity = 45
export var damage = 50

var dir = Vector3()

func _ready() -> void:
	set_as_toplevel(true)
	
func _process(delta: float) -> void:
	translation -=transform.basis.x * velocity * delta
	
func _on_AreaBullet_body_entered(body: Node) -> void:
	if body.is_in_group("Enemy"):
		body.take_damage(damage)
		queue_free()
	else: 
		queue_free()
	
func _on_BulletTimer_timeout() -> void:
	queue_free()
