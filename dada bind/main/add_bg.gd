extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	# 创建一个新的主题
	var theme0 = Theme.new() 
	# 创建并配置 StyleBoxFlat
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0, 0, 0, 0)  # 设置背景颜色为透明 
	# 设置 LineEdit 的样式
	theme0.set_stylebox("normal", "LineEdit", style_box)
	# 应用主题到 LineEdit 控件
	$"../dutiaotext".theme = theme0
	pass # Replace with function body.



func _process(_delta):
	if int($"../dutiaotext".text)>9000000:
		$"../dutiaotext".text=9000000
	
	pass


#打开文件夹
func open_file_browser():
	var os=OS
	os.shell_open(ProjectSettings.globalize_path("res://"))  # 打开项目根目录
	pass
	
	
func save01():
	var aac=load01()
	var file = FileAccess.open("res://baocunwenjain/yinyuanliebiao.gd", FileAccess.WRITE)
	file.store_string(str(aac)+'1')
	print(aac)
	file.close()
	
func load01():
	var file = FileAccess.open("res://baocunwenjain/yinyuanliebiao.gd", FileAccess.READ)
	var content = file.get_as_text()
	return content


