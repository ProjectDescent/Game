extends Node


# DIRECTION #

enum Direction {
	None = 0
	Left = 1
	Right = 2
	}

func face(sprite,direction):
	match direction:
		Direction.Left:
			sprite.flip_h = true
		Direction.Right:
			sprite.flip_h = false



# MOVEMENT #

func move(sprite,motion,direction,maxspeed,speedup, animation, restrictReversalInAir = true):
	var wasMovingRight = motion.x > 0
		
	match direction:
		Direction.Left:
			if !Animator.sprite_is_on_floor(sprite) && wasMovingRight && restrictReversalInAir:
				motion.x = max(motion.x-speedup / 3,-maxspeed)
			else:
				motion.x = max(motion.x-speedup,-maxspeed)
		Direction.Right:
			if !Animator.sprite_is_on_floor(sprite) && !wasMovingRight && restrictReversalInAir:
				motion.x = min(motion.x+speedup / 3,maxspeed)
			else:
				motion.x = min(motion.x+speedup,maxspeed)
		
	if Animator.sprite_is_on_floor(sprite):
		face(sprite, direction)
		Animator.playAnimation(sprite,Animator.animForType(animation))
	
	if Animator.sprite_is_on_ceiling(sprite):
		motion.y = -1
	
	return motion