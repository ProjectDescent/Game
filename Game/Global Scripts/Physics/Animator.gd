extends Node

enum AnimationType {
	Idle = 0
	Walk = 1
	Run = 2
	Fall = 3
	Jump = 4
	Climb = 5
	ClimbIdle = 6
	}

func animForType(type):
	match type:
		AnimationType.Idle:
			return "Idle"
		AnimationType.Walk:
			return "Walk"
		AnimationType.Run:
			return "Run"
		AnimationType.Fall:
			return "Fall"
		AnimationType.Jump:
			return "Jump"
		AnimationType.Climb:
			return "Climb"
		AnimationType.ClimbIdle:
			return "Climb Idle"
		

func typeForAnimation(string):
	match string:
		"Idle":
			return AnimationType.Idle
		"Walk":
			return AnimationType.Walk
		"Run":
			return AnimationType.Run
		"Fall":
			return AnimationType.Fall
		"Jump":
			return AnimationType.Jump
		"Climb":
			return AnimationType.Climb
		"Climb Idle":
			return AnimationType.ClimbIdle
			
			
			
func playAnimation(sprite,animationString):
	sprite.play(animationString)

func playAnimationIfOnFloor(sprite,animationString):
	var obj = sprite
	while(true):
		obj = obj.get_parent()
		if obj == null:
			break
		if obj.has_method("is_on_floor"):
			if obj.is_on_floor():
				playAnimation(sprite, animationString)
			break
			
func sprite_is_on_floor(sprite):
	var obj = sprite
	while(true):
		obj = obj.get_parent()
		if obj == null:
			break
		if obj.has_method("is_on_floor"):
			if obj.is_on_floor():
				return true
			break
	return false
	
func sprite_is_on_ceiling(sprite):
	var obj = sprite
	while(true):
		obj = obj.get_parent()
		if obj == null:
			break
		if obj.has_method("is_on_ceiling"):
			if obj.is_on_ceiling():
				return true
			break
	return false