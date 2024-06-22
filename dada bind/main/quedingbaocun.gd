extends Button


# Called when the node enters the scene tree for the first time.

var confirm_dialog: ConfirmationDialog


func _ready():
	pass


#如果提示框弹出，该参数发生改变
var bo=0
var tpwor=''


func kuang():
	# 创建 ConfirmationDialog 节点并将其添加到当前节点
	confirm_dialog = ConfirmationDialog.new()
	confirm_dialog.set_cancel_button_text('no')
	confirm_dialog.set_ok_button_text('yes')
	add_child(confirm_dialog)
	
	# 设置对话框的标题和文本
	confirm_dialog.dialog_text =Baocunwenjian.citiao[Baocunwenjian.suoyin][15]
	#confirm_dialog.dialog_text = "文件名重复，是否覆盖原文件？"
	confirm_dialog.set_title("warning")
	
	# 连接确认和取消信号
	confirm_dialog.get_ok_button().connect("pressed", _on_ConfirmDialog_ok)
	confirm_dialog.get_cancel_button().connect("pressed", _on_ConfirmDialog_cancelled)
	
	# 弹出窗口
	confirm_dialog.popup_centered()



func _on_ConfirmDialog_ok():
	print("Confirmed")
	print(tpwor)
	print(Baocunwenjian.wenj)
	
	save00(tpwor)
	tpwor=''
	$"..".hide()
	#确定写入文件后，将按钮状态还原
	$"../../jc/open".text=Baocunwenjian.citiao[Baocunwenjian.suoyin][0]
	#$"../../jc/open".text='打开'



func _on_ConfirmDialog_cancelled():
	print("Cancelled")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



#允许写入的条件
func save00(filename):
	var qq=0
	var file = FileAccess.open("res://baocunwenjain_t/"+filename, FileAccess.READ)
	#消除定义函数时，open函数FileAccess.READ产生的“未实例化”报错
	if file!=null:
		var content = file.get_as_text()
		for i in range(len(str(Baocunwenjian.wenj))):
			#直接用字符串对比会有问题，所以逐个字符检查
			if str(Baocunwenjian.wenj).substr(i,1)!= content.substr(i,1):
				qq+=1
				file.close()
				break
			pass
		if qq>0:
			var file0 = FileAccess.open("res://baocunwenjain_t/"+filename, FileAccess.WRITE)
			file0.store_string(str(Baocunwenjian.wenj))
			Baocunwenjian.wenj=[]
			file0.close()
			pass
	else :
		var file0 = FileAccess.open("res://baocunwenjain_t/"+filename, FileAccess.WRITE)
		file0.store_string(str(Baocunwenjian.wenj))
		Baocunwenjian.wenj=[]
		file0.close()
		pass
	pass



#按下确定按钮触发
func _on_pressed():
	
	bo=0
	var wor=$"../LineEdit".text
	if int($"..".get_item_count())!=0:
		for i in range(int($"..".get_item_count())):
			if wor==$"..".get_item_text(i):
				tpwor=wor
				kuang()
				bo=1
				break
			elif wor!=$"..".get_item_text(i) and wor.substr(wor.length()-4, 4)!='.txt':
				wor+='.txt'
				pass
		if bo!=1:
			#应在for循环外进行，否则将运行多次
			save00(wor)
			$"..".hide()
			$"../../jc/open".text=Baocunwenjian.citiao[Baocunwenjian.suoyin][0]
			#$"../../jc/open".text='打开'
		return
				
	elif wor.substr(wor.length()-4, 4)!='.txt':
		wor+='.txt'
		pass
	save00(wor)
	$"..".hide()
	$"../../jc/open".text=Baocunwenjian.citiao[Baocunwenjian.suoyin][0]
	#$"../../jc/open".text='打开'
	pass # Replace with function body.
