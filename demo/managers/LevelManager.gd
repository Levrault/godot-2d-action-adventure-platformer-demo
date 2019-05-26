extends Node

var loader: ResourceInteractiveLoader
var wait_frames: int
var time_max: int = 100 # msec
var current_scene: Node
var loading_screen_scene: Resource = preload('res://interfaces/loading/LoadingScreen.tscn')
var loading_screen: Node
var root: Node


func _ready() -> void:
	root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	loading_screen = loading_screen_scene.instance()


func show_error() -> void:
	print('Scene was not loaded')


func goto_scene(path: String) -> void: # game requests to switch to this scene
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
		show_error()
		return
	set_process(true)
	current_scene.queue_free() # get rid of the old scene
	
	# start your "loading..." animation
	root.add_child(loading_screen)
	wait_frames = 1


# warning-ignore:unused_argument
func _process(time: float) -> void:
	if loader == null:
		 # no need to process anymore
		set_process(false)
		return
		
	if wait_frames > 1: # wait for frames to let the "loading" animation show up
		wait_frames -= 1
		return
		
	var t := OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control for how long we block this thread

		# poll your loader
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			update_progress(1)
			var resource = loader.get_resource()
			loader = null
			loading_screen.set_resource(resource)
			break
		elif err == OK:
			update_progress(float(loader.get_stage()) / loader.get_stage_count())
		else: # error during loading
			show_error()
			loader = null
			break


func update_progress(value: float) -> void:
	# Update your progress bar?
	loading_screen.set_progress(round(value * 100))


func set_new_scene(scene_resource: Resource) -> void:
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)