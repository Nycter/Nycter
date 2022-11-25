extends KinematicBody

export var speed := 10.0
export var jump_strength := 20.0
export var gravity := 50.0
export var mouse_sensitivity := 0.01
export var bullet = preload("res://AreaBulletPlayer.tscn")

var can_shoot : bool = true
var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

onready var _spring_arm: SpringArm = $SpringArm
onready var _model: Spatial = $Player
onready var _animator := $"Player/AnimationPlayer"


func _physics_process(delta: float) -> void:
	
	var move_direction := Vector3.ZERO
	
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	
	if _velocity.length() == 0:
		_animator.play("Idle")
		
	
	if  _velocity.length() > 0.2:
		_animator.play("Walking")
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()	+PI/2
		
func _process(_delta: float) -> void:
	_spring_arm.translation = translation
	
	#Shooting conditions
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		
func shoot():
	_animator.play("Shooting")
	can_shoot = false
	$ShootTimer.start()
	
	var b = bullet.instance()
	b.rotation_degrees = $"Player/BodyController/PlayerBarrel/Position3D".global_transform.basis.get_euler()
	$"Player/BodyController/PlayerBarrel/Position3D".add_child(b)
	var c = bullet.instance()
	c.rotation_degrees = $"Player/BodyController/PlayerBarrel/Position3D2".global_transform.basis.get_euler()
	$"Player/BodyController/PlayerBarrel/Position3D2".add_child(c)
	var d = bullet.instance()
	d.rotation_degrees = $"Player/BodyController/PlayerBarrel/Position3D3".global_transform.basis.get_euler()
	$"Player/BodyController/PlayerBarrel/Position3D3".add_child(d)
	var e = bullet.instance()
	e.rotation_degrees = $"Player/BodyController/PlayerBarrel/Position3D4".global_transform.basis.get_euler()
	$"Player/BodyController/PlayerBarrel/Position3D4".add_child(e)
	
func _on_ShootTimer_timeout() -> void:
	can_shoot = true
