extends Spatial


func _process(delta: float) -> void:
	var fan = $"../../../../KinematicBody".transform.origin
	
	look_at(fan, Vector3.UP)
	self.rotation_degrees.x = clamp(rotation_degrees.x, -20, 30)
	self.rotation_degrees.x = ($"../../../../EnemyCannon1".rotation_degrees.x) * delta
