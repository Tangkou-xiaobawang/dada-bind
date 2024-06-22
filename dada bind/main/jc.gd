extends CharacterBody2D



func get_input():
	var speed = int($sudu.text)
	#当元素为选取状态时，检测杆静止，速度为0
	if $xuanqu.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][3] or Baocunwenjian.sy==1:
	#if $xuanqu.text=='完成':
		speed=0
		return
	if $zidongbofang.text=='^^':
		velocity = Vector2(1,0) * speed
		$zidongsaomiao.hide()
		return
	else :
		$zidongsaomiao.show()
		
	if $zidongsaomiao.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][8]:
	#if $zidongsaomiao.text=='自动扫描':
		var input_direction = Input.get_vector("go_a", "go_d", "null", "null")
		velocity = input_direction * speed
		return
	if $zidongsaomiao.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][9]:
	#if $zidongsaomiao.text=='暂停':
		velocity = Vector2(1,0) * speed
	


var zuobiao=0
#将delta函数改为_delta，表示从不使用该参数
func _physics_process(_delta):
	$weizhi.text='|'+str(int($".".global_position.x))
	$weizhi2.text='|'+str(int($weizhi2.global_position.x))
	$weizhi3.text='|'+str(int($weizhi3.global_position.x))
	$weizhi4.text='|'+str(int($weizhi4.global_position.x))
	$weizhi5.text='|'+str(int($weizhi5.global_position.x))
	$weizhi6.text='|'+str(int($weizhi6.global_position.x))
	$weizhi_1.text='|'+str(int($weizhi_1.global_position.x))
	$weizhi_2.text='|'+str(int($weizhi_2.global_position.x))
	$weizhi_3.text='|'+str(int($weizhi_3.global_position.x))
	$weizhi_4.text='|'+str(int($weizhi_4.global_position.x))
	$weizhi_5.text='|'+str(int($weizhi_5.global_position.x))
	
	get_input()
	#该物体如果与其他物体发生碰撞，则会沿着对方滑动（默认只在地板上滑动），不会立即停止移动
	move_and_slide()
	#限制自身移动起点及终点
	if self.position.x<-100:
		self.position.x=-100
	if self.position.x>9000000:
		self.position.x=9000000
	if zuobiao==0:
		$zuobiao.text=str($".".position.x)
		pass


func _on_sudu_mouse_exited():
	#禁止修改文本
	$sudu.editable=false
	pass # Replace with function body.


func _on_sudu_mouse_entered():
	$sudu.editable=true
	pass # Replace with function body.


func _on_消除输入法_pressed():
	print('pressed')
	pass # Replace with function body.


func _on_wenjian_mouse_entered():
	$wenjian.editable=true
	pass # Replace with function body.


func _on_wenjian_mouse_exited():
	$wenjian.editable=false
	pass # Replace with function body.


func _on_fullscreen_pressed():
	if $fullscreen.text=='[{}]':
		#全屏
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		$fullscreen.text='[}{]'
		return
	if $fullscreen.text=='[}{]':
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$fullscreen.text='[{}]'
	pass # Replace with function body.


func _on_zuobiao_mouse_entered():
	zuobiao=1
	pass # Replace with function body.


func _on_zuobiao_mouse_exited():
	zuobiao=0

	pass # Replace with function body.


@onready var polygon: Polygon2D = $huakuai
func _ready():
	# 设置多边形的顶点
	var vertices = [
		Vector2(0, 0),
		Vector2(-3, 10),
		Vector2(3, 10),
	]
	polygon.polygon = vertices
	# 设置多边形的颜色
	polygon.color = Color(1, 0, 0) # 红色



func _process(_delta):
	var temp=float($dutiaotext.text)/500
	if temp!=0:
		polygon.position.x=$".".position.x/temp+20
	if int($zuobiao.text)<9000001 and zuobiao==1:
		$".".position.x=int($zuobiao.text)
	if polygon.position.x<20:
		polygon.position.x=20
	if polygon.position.x>520:
		polygon.position.x=520
	$"../shiyong".position.x=$".".position.x-430
	pass
	
