extends Node

enum Declaration {
	Undefined = 0
	Climbable = 1
	}

func declarationForName(string):
	match string:
		"Climbable":
			return Declaration.Climbable
	return Declaration.Undefined

func declarationForType(type):
	match type:
		Declaration.Climbable:
			return "Climbable"
	return ""
