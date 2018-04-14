extends KinematicBody2D

export (int) var walkSpeed = 50
export (int) var topRunSpeed = 125
export (int) var runSpeedup = 15
export (int) var jumpHeight = 300

export var life = 3

var motion = Vector2(0,0)

onready var currentMaxSpeed = walkSpeed
onready var sprite = get_node("AnimatedSprite")

var climbingMode = VerticalMover.ClimbingMode.CannotClimb
var moveForwardAnimation = Animator.AnimationType.Walk
var friction = false

var numberOfClimbableAreasInhabited = 0


# LOOP #

func _process(delta):
	activateRunIfNeeded()
	applyDirectionalInputIfNeeded()
	
	if friction == true:
		motion.x = lerp(motion.x, 0, 0.2)
	move_and_slide(motion, Vector2(0,-1))



# INPUT #

func applyDirectionalInputIfNeeded():
	var direction = LateralMover.Direction.None
	if Input.is_action_pressed("ui_left"):
		direction = LateralMover.Direction.Left
		friction = false
	elif Input.is_action_pressed("ui_right"):
		direction = LateralMover.Direction.Right
		friction = false
	else:
		moveForwardAnimation = Animator.AnimationType.Idle
		friction = true
	
	motion = LateralMover.move(sprite, 
			motion,
			direction, 
			currentMaxSpeed,  
			runSpeedup,
			moveForwardAnimation)
			
	motion = VerticalMover.move(sprite, 
			motion, 
			climbingMode, 
			walkSpeed, 
			jumpHeight)



# LATERAL MOVEMENT #

func activateRunIfNeeded():
	if Input.is_action_pressed("ui_accept") && is_on_floor():
		currentMaxSpeed = topRunSpeed
		moveForwardAnimation = Animator.AnimationType.Run
	elif is_on_floor():
		currentMaxSpeed = walkSpeed
		moveForwardAnimation = Animator.AnimationType.Walk


# CLIMBING #
	

func _on_Area2D_area_entered(area):
	if area.get_name().begins_with("Climbable"):
		numberOfClimbableAreasInhabited += 1
		climbingMode = VerticalMover.ClimbingMode.CanClimb


func _on_Area2D_area_exited(area):
	if area.get_name().begins_with("Climbable"):	
		numberOfClimbableAreasInhabited -= 1
		if numberOfClimbableAreasInhabited == 0:
			climbingMode = VerticalMover.ClimbingMode.CannotClimb
