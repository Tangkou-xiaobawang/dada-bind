extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pressed():
	$".".release_focus()
	var group_nodes = get_tree().get_nodes_in_group('yuansu')
	for n in group_nodes:
		#如果节点是Node类型就继续
		if n is CharacterBody2D:
			#停止所有音频播放
			n.get_node('bofang').stop()
			#.stream_paused = true为暂停
			pass
	pass # Replace with function body.
