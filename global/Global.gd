extends Node

onready var root: = get_tree().get_root()
onready var current_scene: = root.get_child(root.get_child_count() - 1)

func _ready():
    randomize()

# queues a scene change at the end of the process loop
func goto_scene(scene: Resource):
    call_deferred("_goto_scene_deferred", scene)

# initiates a scene change
func _goto_scene_deferred(scene: Resource):
    # now in idle time so it's ok to delete the current scene
    root.remove_child(current_scene)
    current_scene.free()
    current_scene = scene.instance()
    root.add_child(current_scene)
