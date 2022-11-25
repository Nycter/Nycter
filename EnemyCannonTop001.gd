extends MeshInstance

func _process(delta):
	var fan = $"../../KinematicBody".transform.origin
	
	look_at(fan, Vector3.UP)
	rotation_degrees.x = ($"../../EnemyCannon1".rotation_degrees.x) * delta 
