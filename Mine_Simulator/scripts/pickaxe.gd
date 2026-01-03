extends Area3D

var can_mine = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input. is_action_pressed("mine") and can_mine:
		can_mine = false
		await mine()
		await get_tree().create_timer(0.0).timeout
		
		$CollisionShape3D.disabled = true
		can_mine = true
func mine() -> void:
	$CollisionShape3D.disabled = false
	$MeshInstance3D/AnimationPlayer. play("mine")
	await $MeshInstance3D/AnimationPlayer. animation_finished



func _on_area_entered(area: Area3D) -> void:
	if area. name. begins_with("rock"):
		call_deferred("disable_collision")
		
func disable_collision() -> void:
	$CollisionShape3D.disabled = true
