extends CSGCombiner3D

@onready var rocks = get_node_or_null("rocks")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global. load_game()
	var rocks_spawn_per_onec = global. rocks_spawn_per_onec
	global.rocks_spawn_per_onec = global. start_amoun_rocks
	create_rock(false)
	global. rocks_spawn_per_onec = rocks_spawn_per_onec
	create_rock()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func create_rock(couldown := true) -> void:
	if rocks and global. rocks <= global. max_rocks:
		print("Creating rocks..."+str(global. rocks_spawn_per_onec))
		var stone_rock := 0
		var stone_copper := 0
		var chances = global. chances
		for rock in global. rocks_spawn_per_onec:
			var chance_for_stone = randf()
			var new_rock
			if chance_for_stone <= chances. rock:
				new_rock = load("res://scenes/rock.tscn"). instantiate()
				stone_rock += 1
			elif chance_for_stone <= chances. copper:
				new_rock = load("res://scenes/copper.tscn"). instantiate()
				
				stone_copper += 1
			rocks. add_child(new_rock)
			new_rock. position = random_position()
			await get_tree().create_timer(0.000001).timeout
			while global. rocks_connecting:
				new_rock.position = random_position()
				await get_tree().create_timer(0.0000001).timeout
			new_rock.name = "rock"
			global. rocks += 1
		print(global. rocks)
		print("rocks: "+str(stone_rock))
		print("coppers: "+str(stone_copper))
		print()
	if couldown:
		rock_couldown()

func rock_couldown() -> void:
	await get_tree().create_timer(global. rocks_spawn_couldown).timeout
	create_rock()

func random_position() -> Vector3:
	var rock_position = Vector3(randf_range(randf_range(-45, -35), randf_range(35, 45)), 1.3, randf_range(randf_range(-45, -35), randf_range(35, 45)))
	return rock_position
