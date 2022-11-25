extends Area

export var velocity = 15
export var damage = 25

var dir = Vector3()

func _ready() -> void:
	set_as_toplevel(true)
	
func _process(delta: float) -> void:
	translation -=transform.basis.z * velocity * delta
	
func _on_AreaBullet_body_entered(body: Node) -> void:
	if body.is_in_group("Ally"):
		body.take_damage(damage)
		queue_free()
	else: 
		queue_free()
	
func _on_BulletTimer_timeout() -> void:
	queue_free()
