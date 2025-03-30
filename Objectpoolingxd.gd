#extends Node2D

#const sceneToInstantiate = preload("res://scenes/enemy_slime.tscn")
#
#func _physics_process(delta):
	#for i in 75:
		#var instance = sceneToInstantiate.instantiate()
		## var instance = ObjectPool.instantiate(sceneToInstantiate)
		#add_child(instance)
		#instance.queue_free()
		## turns into ObjectPool.returnInstance(instance, sceneToInstantiate)
		
		# reset your animations at the end, and return objects...?
	

extends Node

var instances : Dictionary #PackedScene -> array[scene instances]

func instantiate(scene : PackedScene):
	var existingInstances = instances.get(scene, null)
	if existingInstances:
		var instance = existingInstances.pop_back()
		if existingInstances.size() == 0:
			instances.erase(scene)
		instance.request_ready()
		if "poolingHandle" in instance:
			instance.poolingHandle = scene
		return instance
	else:
		var instance = scene.instantiate()
		instance.prepare()
		if "poolingHandle" in instance:
			instance.poolingHandle = scene
		return instance
