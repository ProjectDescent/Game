#Usage
#
#Notifications are sent to observers.
#Any object can be an observer.
#Notifications can be sent from anywhere in your code.


#If you need to add an observer or send a notification,
# get the root object:
#
#var nc = get_node("/root/nc") # if you named it nc in
#the autoload settings
#
#OR
#
#var nc = $"/root/nc" # new Godot 3 syntax


#To add an object as observer
#
#nc.add_observer(observer,notificationName,action)
#
#observer is the object added as an observer
#notificationName is the ID of the notification.
#It is a String.
#action is the name of a function that must be defined
#by the observer with 3 parameters:
#func action(observer,notificationName,notificationData):
#
#notificationData can by of any type.
#You can make a dictionary and include every
#needed data in it.
#It is sent with the notification.


#To remove an observer
#
#nc.remove_observer(observer, notificationName)
#
#you MUST remove an observer, at least when it
#leaves the scene. Example:

#func _exit_tree():
#    nc.remove_observer(self, notificationName)

#To send a notification
#
#nc.post_notification(notificationName,notificationData)
#
#Every observer of notificationName will execute its action.

extends Node

var notifications

func _ready():
	notifications = {};

func post_notification(notificationName,notificationData):
	if notifications.has(notificationName):
		var currentObservers=notifications[notificationName].observers
		for i in currentObservers:
			var anObserver =  currentObservers[i]
			if anObserver.object.has_method(anObserver.action):
				anObserver.object.call(anObserver.action,
						anObserver.object,
						notificationName,
						notificationData)

func add_observer(observer,notificationName,action):
	if not notifications.has(notificationName):
		notifications[notificationName]={
			"observers":{}
		}
	var currentObservers=notifications[notificationName].observers
	currentObservers[observer.get_instance_id()]={
		"object":observer,
		"action":action
	}

func remove_observer(observer, notificationName):
	if notifications.has(notificationName):
		var currentObservers=notifications[notificationName].observers
		if currentObservers.has(observer.get_instance_id()):
			currentObservers.erase(observer.get_instance_id())