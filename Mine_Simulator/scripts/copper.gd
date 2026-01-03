extends Area3D
var health = 5
@export var materials_array: Array[Material] = []

func _ready():
	if materials_array.size() > 0:
		# Выбрать случайный материал из массива
		var random_index = randi() % materials_array.size()
		var random_material = materials_array[random_index]
		materials_array.remove_at(random_index)
		$MeshInstance3D.set_surface_override_material(0, random_material)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Node3D) -> void:
	if area. name == "pickaxe":
		health -= global. damage
		if health <= 0:
			queue_free()
			global. rocks -= 1
			var gett = global. copper_gain_base * global. luck_multiplayer
			global. copper += randi_range(gett-1, gett+2) 
			global. save()
		else:
			var random_index = randi() % materials_array.size()
			var random_material = materials_array[random_index]
			materials_array.remove_at(random_index)
			$MeshInstance3D.set_surface_override_material(0, random_material)
	if area.  name. begins_with("rock"):
		global. rocks_connecting = true
		await get_tree().create_timer(0.0001).timeout
		global. rocks_connecting = false


func _on_body_entered(body: Node3D) -> void:
	if body is StaticBody3D:
		global. rocks_connecting = true
		await get_tree().create_timer(0.0001).timeout
		global. rocks_connecting = false
