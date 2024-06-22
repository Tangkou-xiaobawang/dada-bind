extends CharacterBody2D

var aa=0

func _input(event):
	# 检测输入事件是否为鼠标点击事件
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_RIGHT and aa==0:
				aa=1
			else :
				aa=0
				
	
		
func _process(_delta):
	if Baocunwenjian.qinjian==0:
		#点击右键时出现橡皮擦，并跟踪鼠标
		if aa==1:
			var mouse_position = get_global_mouse_position()
			$".".position=mouse_position
			$".".show()
		else:
			$".".hide()
			$".".position.y=-2000
			pass
	else :
		aa=0
		$".".hide()
		$".".position.y=-2000
