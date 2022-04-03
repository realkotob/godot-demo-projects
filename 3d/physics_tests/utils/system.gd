extends Node


enum PhysicsEngine {
	BULLET,
	GODOT_PHYSICS,
	OTHER,
}

var _engine = PhysicsEngine.OTHER


func _enter_tree():
	process_mode = Node.PROCESS_MODE_ALWAYS

	get_tree().debug_collisions_hint = true

	var engine_string = ProjectSettings.get_setting("physics/3d/physics_engine")
	match engine_string:
		"DEFAULT":
			_engine = PhysicsEngine.BULLET
		"Bullet":
			_engine = PhysicsEngine.BULLET
		"GodotPhysics3D":
			_engine = PhysicsEngine.GODOT_PHYSICS
		_:
			_engine = PhysicsEngine.OTHER


func _process(_delta):
	if Input.is_action_just_pressed(&"toggle_full_screen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	if Input.is_action_just_pressed(&"toggle_debug_collision"):
		var debug_collision_enabled = not _is_debug_collision_enabled()
		_set_debug_collision_enabled(debug_collision_enabled)
		if debug_collision_enabled:
			Log.print_log("Debug Collision ON")
		else:
			Log.print_log("Debug Collision OFF")

	if Input.is_action_just_pressed(&"toggle_pause"):
		get_tree().paused = not get_tree().paused

	if Input.is_action_just_pressed(&"exit"):
		get_tree().quit()


func get_physics_engine():
	return _engine


func _set_debug_collision_enabled(enabled):
	get_tree().debug_collisions_hint = enabled


func _is_debug_collision_enabled():
	return get_tree().debug_collisions_hint