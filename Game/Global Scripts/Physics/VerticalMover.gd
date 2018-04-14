extends Node

enum ClimbingMode {
	CannotClimb = 0
	CanClimb = 1
	}

enum Direction {
	None = 0
	Up = 1
	Down = 2
	}
	

func isFalling(motion, specialRelativity = null):
	if specialRelativity != null:
		return motion.y > specialRelativity
	else:
		return motion.y > Universe.GRAVITY
	
func jumpOrFall(sprite, motion, jump):
	return cannotClimbHandleVertical(sprite, 
			motion, 
			jump)
	
func climb(sprite, motion, climbSpeed):
	return canClimbHandleVertical(sprite, 
			motion, 
			climbSpeed)
	
func move(sprite, motion, climbingMode, climbSpeed, jump):
	match climbingMode:
		VerticalMover.ClimbingMode.CannotClimb:
			return jumpOrFall(sprite, 
					motion, 
					jump)
		VerticalMover.ClimbingMode.CanClimb:
			return climb(sprite, 
					motion, 
					climbSpeed)

func cannotClimbHandleVertical(sprite, 
		motion, 
		jump):
	if Animator.sprite_is_on_floor(sprite):
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -(jump + abs(motion.x))
			Animator.playAnimation(sprite, 
					Animator.animForType(Animator.AnimationType.Jump))
	else:
		Animator.playAnimation(sprite, 
				Animator.animForType(Animator.AnimationType.Fall))
		motion.y = min(motion.y + Universe.GRAVITY, Universe.MAX_GRAVITY)
	return motion

func canClimbHandleVertical(sprite, 
		motion, 
		climbSpeed):
	if Animator.sprite_is_on_floor(sprite):
		if Input.is_action_pressed("ui_up"):
			motion.y = -climbSpeed
			Animator.playAnimation(sprite, 
					Animator.animForType(Animator.AnimationType.Climb))
	else:
		if Input.is_action_pressed("ui_up"):
			motion.y = -climbSpeed
			Animator.playAnimation(sprite, 
					Animator.animForType(Animator.AnimationType.Climb))
		elif Input.is_action_pressed("ui_down"):
			motion.y = climbSpeed
			Animator.playAnimation(sprite, 
					Animator.animForType(Animator.AnimationType.Climb))
		else:
			motion.y = 0
			Animator.playAnimation(sprite, 
					Animator.animForType(Animator.AnimationType.ClimbIdle))
	return motion
