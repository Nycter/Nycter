extends MeshInstance


var velocity = Vector3()

func _ready():
	velocity.y = -600
	
func _physics_process(delta):
	move_and_slide()
	
