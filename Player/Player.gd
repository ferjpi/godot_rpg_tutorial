extends KinematicBody2D

const SPEED = 90
const FRICTION = 170
const ACCELERATION = 250
var velocity = Vector2.ZERO

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var animationPlayer = null
var animationTree = null
var animationState = null

# onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer = $AnimationPlayer
	animationTree = $AnimationTree
	animationState = animationTree.get("parameters/playback")
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		#velocity += input_vector * ACCELERATION * delta
		#velocity = velocity.clamped(SPEED)
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	#move_and_collide(velocity)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func attack_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_move_finished():
	state = MOVE
	
