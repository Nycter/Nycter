extends MeshInstance

export var bullet = preload("res://AreaBullet.tscn")

var can_shoot : bool = true

onready var _animator := $"AnimationPlayer"
onready var _model: Spatial = $"../Spatial"

func _process(delta: float) -> void:
	var fan = $"../../../KinematicBody".transform.origin
	
	look_at(fan, Vector3.UP)
	self.rotation_degrees.x = clamp(rotation_degrees.x, -20, 30)
	self.rotation_degrees.x = ($"../../../EnemyCannon1".rotation_degrees.x) * delta
	
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		
func shoot():
	_animator.play("Shooting")
	can_shoot = false
	$ShootTimer.start()
	
	var b = bullet.instance()
	b.rotation_degrees = $MuzzleLeft.global_transform.basis.get_euler()
	$MuzzleLeft.add_child(b)
	var c = bullet.instance()
	c.rotation_degrees = $MuzzleRight.global_transform.basis.get_euler()
	$MuzzleRight.add_child(c)
	
func _on_ShootTimer_timeout() -> void:
	can_shoot = true
