extends Button


@onready var yinyuan_list: ItemList = $"../../yinyuanliebiao"

# Called when the node enters the scene tree for the first time.
func _ready():
	jiazaiyinyuan("res://yinyuan/")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(num)
	pass
	

func _input(event):	
	if event is InputEventKey:
		if event.is_pressed():
			var yy=int($"../../音源".text)
			var yl=int($"../../增幅".text)
			#音源调整
			if event.keycode==KEY_BRACKETLEFT:
				if yy>0:
					yy-=1
					$"../../音源".text=str(yy)
				pass
			
			if event.keycode==KEY_BRACKETRIGHT:
				if yy<num-1:
					yy+=1
					$"../../音源".text=str(yy)
				pass
				
			if event.keycode==KEY_MINUS:
				if yl>-50:
					yl-=5
					$"../../增幅".text=str(yl)
				pass
			
			if event.keycode==KEY_EQUAL:
				if yl<50:
					yl+=5
					$"../../增幅".text=str(yl)
				pass
			pass


func _on_pressed():
	$".".release_focus()
	if $".".text==Baocunwenjian.citiao[Baocunwenjian.suoyin][12]:
	#if $".".text=='查看音源':
		yinyuan_list.clear()
		$".".text=Baocunwenjian.citiao[Baocunwenjian.suoyin][16]
		#$".".text='关闭'
		Baocunwenjian.save00(Baocunwenjian.load00(),['.mp3','.wav'])
		jiazaiyinyuan("res://yinyuan/")
		$"../../yinyuanliebiao".show()
		return
		
	if $".".text==Baocunwenjian.citiao[Baocunwenjian.suoyin][16]:
	#if $".".text=='关闭':
		$"../../yinyuanliebiao".hide()
		$".".text=Baocunwenjian.citiao[Baocunwenjian.suoyin][12]
		#$".".text='查看音源'
	pass # Replace with function body.


var num=0
#获取音源文件列表
func jiazaiyinyuan(dir_path: String):
	var dir = DirAccess.open(dir_path)
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		num=0
		while file_name != "":
			if file_name.substr(file_name.length()-4, 4).to_lower() in ['.mp3','.wav']:
				yinyuan_list.add_item(str(num)+': '+file_name)
				num+=1
			else:
				pass
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open directory: %s" % dir_path)
	Baocunwenjian.yinyuan_count=num


func _on_dakaimulu_pressed():
	# 使用相对路径打开文件夹
	var relative_path = "res://yinyuan/"
	var absolute_path = ProjectSettings.globalize_path(relative_path)
	OS.shell_open(absolute_path)
	pass # Replace with function body.


func _on_anjiansheng_toggled(toggled_on):
	if toggled_on:
		Baocunwenjian.anjianyin=1
	else:
		Baocunwenjian.anjianyin=0
	pass # Replace with function body.
