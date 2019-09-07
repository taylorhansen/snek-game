extends Node

# queues a scene change at the end of the process loop
func goto_scene(scene: Resource):
    call_deferred("_goto_scene_deferred", scene)

# initiates a scene change
func _goto_scene_deferred(scene: Resource):
    var tree = get_tree()
    # now in idle time so it's ok to delete the current scene
    tree.current_scene.free()
    tree.current_scene = scene.instance()
