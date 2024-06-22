extends Node2D


var undo_redo:UndoRedo=UndoRedo.new()
@onready var uen=preload("res://yuansu/yuansu.tscn")

# 显示文件夹内容的列表节点
@onready var item_list: ItemList = $liebiao
@onready var baocun_list: ItemList = $baocunliebiao
@onready var yuyan_list: MenuButton = $jc/yuyan


#翻译重组
func chongzu():
	$jc/open.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][0]
	$jc/xuanqu.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][2]
	$jc/fuzhi.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][4]
	$jc/add_bg.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][7]
	$jc/zidongsaomiao.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][8]
	$jc/anjiansheng.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][10]
	$jc/tingzhi.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][11]
	$jc/yinyuan.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][12]
	$baocunliebiao/Button.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][13]
	$jc/sudulabel.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][14]
	$yinyuanliebiao/dakaimulu.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][17]
	$shiyong/shuoming.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][18]
	pass


#获取popup的索引，并传递到语言判定文件
func yuyanfunc(index):
	#清空任务
	Baocunwenjian.wenj=[]
	Baocunwenjian.suoyin=index
	#重新加载按钮
	$jc/yuyan.text=Baocunwenjian.yuyan[index]
	chongzu()
	var file = FileAccess.open("res://baocunwenjain_t/diudiu.piupiu", FileAccess.WRITE)
	file.store_string(Baocunwenjian.yuyan[index])
	file.close()


#进入游戏的语言判定
func yuyanpd():
	if $jc/yuyan.text in Baocunwenjian.yuyan:
		Baocunwenjian.suoyin=Baocunwenjian.yuyan.find($jc/yuyan.text)
		chongzu()



func _ready():
	#重新加载音源列表
	Baocunwenjian.save00(Baocunwenjian.load00(),['.mp3','.wav'])
	do_shuominng()
	key_bianhua()
	yuyanpd()
	#设置窗口最大尺寸
	DisplayServer.window_set_max_size(Vector2i(1200,650))
	#将窗口大小设为1200,650像素	#可以在“项目”中设置
	DisplayServer.window_set_size(Vector2i(1200,650))
	#将窗口大小设置不可调整
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	#将按键透明度设为0
	$"消除输入法".modulate.a = 0
	#点击列表时，执行函数_on_FileList_item_selected()
	#绑定信号，点击列表时触发函数
	item_list.item_selected.connect(_on_FileList_item_selected)
	yuyan_list.get_popup().connect('index_pressed',yuyanfunc)
	$jc/top.modulate.a=0
	pass 


#将文件名称列表写入场景列表中
#点击列表，根据所选文件，生成元素
func _on_FileList_item_selected(index: int):
	# 获取选中的文件名
	var file_name = item_list.get_item_text(index)
	var neirong=str(Baocunwenjian.read_file("res://baocunwenjain_t/" + file_name))
	print(neirong)
	geshi_chuli(neirong)
	#取消选中状态
	$liebiao.deselect_all()
	pass



func _process(_delta):
	if Baocunwenjian.sy==1:
		shiyong0()
	#消除输入法的按键跟随鼠标
	var mm=get_global_mouse_position()
	$liebiao.position=$jc.position+Vector2(0,-510)
	$yinyuanliebiao.position=$jc.position+Vector2(-430,-510)
	$baocunliebiao.position=$jc.position+Vector2(350,-510)
	$"消除输入法".position=mm-Vector2(10,15)
	$"Label调".position=mm-Vector2(40,15)
	$"Label阶".position=mm-Vector2(0,15)
	$"音源".position=mm-Vector2(5,-5)
	$"增幅".position=mm-Vector2(-10,0)
	#移动状态为1时
	if $jc/xuanqu.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][3]:
	#if $jc/xuanqu.text=='完成':
		$jihuoxuanqu.show()
		$jihuoxuanqu.position=mm
		
	else:
		$jihuoxuanqu.hide()
		$jihuoxuanqu.position+=Vector2(0,3000)
		
	if $jc/fuzhi.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][4]:
	#if $jc/fuzhi.text=='扫描':
		$baocunliebiao.hide()
		$jc/zidongsaomiao.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][8]
		#$jc/zidongsaomiao.text='自动扫描'
		
	if $jc/open.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][0]:
	#if $jc/open.text=='打开':
		$jc/fuzhi.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][4]
		#$jc/fuzhi.text='扫描'
	if qinjian==1:
		Baocunwenjian.qinjian=1
	else:
		Baocunwenjian.qinjian=0
		
	#$bgarea/CollisionShape2D.position=$jc.position
	pass


var xiangpicha=0
var yinyuan=0
var dakai=0
var baocun=0
var qinjian=0


#输入控制，有部分写在yinyuan.gd里
func _input(event):
	var jie=[0,1,2,3,4,5,6,7,8]
	var kk=[KEY_Z,KEY_X,KEY_C,KEY_V,KEY_B,KEY_N,KEY_M,KEY_COMMA,KEY_PERIOD]
	var diao=['A', 'B', 'C', 'D', 'E', 'F', 'G', '#A', '#C', '#D', '#F', '#G']
	var kkk=[KEY_1,KEY_2,KEY_3,KEY_4,KEY_5,KEY_6,KEY_7,KEY_Q,KEY_W,KEY_E,KEY_R,KEY_T]
	var allyf=["A0", "#A0", "B0", "C1", "#C1", "D1", "#D1", "E1", "F1", "#F1", "G1", 
	"#G1", "A1", "#A1", "B1", "C2", "#C2", "D2", "#D2", "E2", "F2", "#F2", "G2", "#G2", 
	"A2", "#A2", "B2", "C3", "#C3", "D3", "#D3", "E3", "F3", "#F3", "G3", "#G3", "A3", 
	"#A3", "B3", "C4", "#C4", "D4", "#D4", "E4", "F4", "#F4", "G4", "#G4", "A4", "#A4", 
	"B4", "C5", "#C5", "D5", "#D5", "E5", "F5", "#F5", "G5", "#G5", "A5", "#A5", "B5", 
	"C6", "#C6", "D6", "#D6", "E6", "F6", "#F6", "G6", "#G6", "A6", "#A6", "B6", "C7", 
	"#C7", "D7", "#D7", "E7", "F7", "#F7", "G7", "#G7", "A7", "#A7", "B7", "C8"]
	var key_connect=[KEY_F1,KEY_F2,KEY_F3,KEY_F4,KEY_F5,KEY_F6,KEY_SPACE]
	var b_list=[$jc/yinyuan,$jc/tingzhi,$jc/xuanqu,$jc/open,
	$jc/fuzhi,$jc/add_bg,$jc/zidongbofang]
	
	
	var a0=$"Label调".text+$"Label阶".text
	var a00=allyf.find(a0)
	
	#允许将元素加入场景的条件
	var add_tj=[dakai==0 and yinyuan==0 and baocun==0 and qinjian==0 and Baocunwenjian.sy==0]
	# 检测输入事件是否为鼠标点击事件
	if event is InputEventMouseButton:
		if event.is_pressed():
			if qinjian==1:
				inin()
			if a0 not in allyf:
				$"Label调".text="A"
				$"Label阶".text="4"
			#将元素加入
			if event.button_index == MOUSE_BUTTON_LEFT:
				if add_tj[0]:
					#将元素添加到场景中
					ininin()
				#将位置移动到读条位置
				if dutiao==1:
					var adm=(get_global_mouse_position()-$jc/dutiao.global_position).x
					$jc.position.x=float($jc/dutiaotext.text)/500*adm
				if top==1:
					$jc.position.x=int($jc/dutiaotext.text)
				pass
			if event.button_index == MOUSE_BUTTON_RIGHT:
				#在shubiao.gd中
				pass
				
			if qinjian==0:
				#中键向上滚动
				if event.button_index == MOUSE_BUTTON_WHEEL_UP:
					if a00>-1 and a00<87:
						#索引加一，选取字符串
						var a000=allyf[a00+1]
						#选取字符串中，除了最后一个字符的内容
						$"Label调".text=a000.substr(0, a000.length() - 1)
						$"Label阶".text=a000[-1]
						pass
					pass
				#中键向下滚动
				if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					if a00>0 and a00<88:
						#索引减一，选取字符串
						var a000=allyf[a00-1]
						#选取字符串中，除了最后一个字符的内容
						$"Label调".text=a000.substr(0, a000.length() - 1)
						$"Label阶".text=a000[-1]
					pass
			else :
				pass
				
	if event is InputEventKey:
		if event.is_pressed():
			#音阶调整
			for i in kk:
				if event.keycode==i:
					$"Label阶".text=str(jie[kk.find(i)])
				pass
			#音调调整
			for i in kkk:
				if event.keycode==i:
					$"Label调".text=str(diao[kkk.find(i)])
				pass
				
			for i in range(7):
				if event.keycode==key_connect[i]:
					b_list[i].emit_signal('pressed')
				pass
			
			if event.keycode==KEY_9:
				undo_redo.undo()
			if event.keycode==KEY_0:
				undo_redo.redo()


var qqq=1
#场景实例化和手感调整
func ininin():
	var mm=get_global_mouse_position()
	#将元素实例化
	var ystemp=uen.instantiate()
	#将鼠标提示标签的文本，赋值给yuansuti的标签
	ystemp.get_node('yuansuti').get_node('阶').text=$"Label阶".text
	ystemp.get_node('yuansuti').get_node('调').text=$"Label调".text
	ystemp.get_node('yuansuti').get_node('leixing').text=$"音源".text
	ystemp.get_node('yuansuti').get_node('yinliang').text=$"增幅".text
	ystemp.position=mm
	#限制元素生成的区域
	if ystemp.position.x>=-50:
		if ystemp.position.x<0:
			ystemp.position.x=0
		if ystemp.position.y<=70 and ystemp.position.y>=-350 and ystemp.position.x<9000000:
			#上边界
			if ystemp.position.y<-300 and ystemp.position.y>-350 :
				ystemp.position.y=-300
			#下边界
			if ystemp.position.y<70 and ystemp.position.y>50 :
				ystemp.position.y=50
			#创建undoredo活动
			undo_redo.create_action('addchild')
			undo_redo.add_do_method(self.add_child.bind(ystemp))
			undo_redo.add_do_reference(ystemp)
			#remove重置，move是移动
			undo_redo.add_undo_method(self.remove_child.bind(ystemp))
			#启用undoredo活动
			undo_redo.commit_action()
			#设置读条数字
			if ystemp.position.x>int($"jc/dutiaotext".text):
				$"jc/dutiaotext".text=str(int(ystemp.position.x))
	pass


func inin():
	var r=randf_range(-300,50)
	var yskey=uen.instantiate()
	yskey.get_node('yuansuti').get_node('阶').text=$"Label阶".text
	yskey.get_node('yuansuti').get_node('调').text=$"Label调".text
	yskey.get_node('yuansuti').get_node('leixing').text=$"音源".text
	yskey.get_node('yuansuti').get_node('yinliang').text=$"增幅".text
	#生成带正负的随机浮点数
	yskey.position=Vector2($jc.position.x,r)
	#创建undoredo活动
	undo_redo.create_action('addchild')
	undo_redo.add_do_method(self.add_child.bind(yskey))
	undo_redo.add_do_reference(yskey)
	#remove重置，move是移动
	undo_redo.add_undo_method(self.remove_child.bind(yskey))
	#启用undoredo活动
	undo_redo.commit_action()
	#设置读条数字
	if yskey.position.x>int($"jc/dutiaotext".text):
		$"jc/dutiaotext".text=str(int(yskey.position.x))
	pass


#当检测杆碰到yuansu组中元素触发
#将碰到的元素内容注入wenj列表中,准备写入
func _on_area_2d_body_entered(body):
	#碰到的是yuansu组中的元素，以及复制状态==1时才触发
	#获取在yuansu组的元素位置，以及元素中‘调’和‘阶’的文本，并加入数组yinfu
	if body.is_in_group('yuansu') and $jc/fuzhi.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][5]:
	#if body.is_in_group('yuansu') and $jc/fuzhi.text=='保存':
		Baocunwenjian.yinfu.append(body.global_position)
		Baocunwenjian.yinfu.append(body.get_node('调').text)
		Baocunwenjian.yinfu.append(body.get_node('阶').text)
		Baocunwenjian.yinfu.append(body.get_node('leixing').text)
		Baocunwenjian.yinfu.append(body.get_node('yinliang').text)
		#将数组yinfu加入数组wenj中
		Baocunwenjian.wenj.push_back(Baocunwenjian.yinfu)
		Baocunwenjian.yinfu=[]
	pass # Replace with function body.



#扫描状态检测
func _on_luzhi_pressed():
	$jc/fuzhi.release_focus()
	if $jc/fuzhi.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][4]:
	#if $jc/fuzhi.text=='扫描':
		$jc/fuzhi.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][5]
		#$jc/fuzhi.text='保存'
		$jc/open.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][1]
		#$jc/open.text='取消'
		#打开按钮变为取消时隐藏列表
		$liebiao.hide()
		baocun_list.clear()
		#加载指定位置文件列表
		update_folder_contents("res://baocunwenjain_t/",baocun_list)
		$baocunliebiao.show()
		return
	if $jc/fuzhi.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][5]:
	#if $jc/fuzhi.text=='保存':
		#保存按钮按下时激发确定按钮
		$baocunliebiao/Button.emit_signal('pressed')

		pass
	pass 


#打开按钮按下时
func _on_open_pressed():
	$jc/open.release_focus()
	if $jc/open.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][1]:
	#if $jc/open.text=='取消':
		$jc/open.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][0]
		#$jc/open.text='打开'
		$jc/fuzhi.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][4]
		#$jc/fuzhi.text='扫描'
		$jc/add_bg.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][6]
		#$jc/add_bg.text='复制'
		#每次取消，清空扫描数据
		Baocunwenjian.wenj=[]
		return
		
	if $jc/open.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][0]:
	#if $jc/open.text=='打开':
		if $liebiao.visible==false:
			#清空列表重新加载
			item_list.clear()
			#加载指定位置文件
			update_folder_contents("res://baocunwenjain_t/",item_list)
			$liebiao.show()
		else :
			$liebiao.hide()
		pass


# 获取保存文件的文件夹内容并更新列表
func update_folder_contents(dir_path: String,list):
	var dir = DirAccess.open(dir_path)
	if dir != null:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.substr(file_name.length()-4, 4) =='.txt':
				list.add_item(file_name)
			else:
				pass
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open directory: %s" % dir_path)


#打开和加载文件并生成元素
func open_and_load():
	#使用baocunwenjian中的函数
	var bb=Baocunwenjian.load00()
	return bb


#处理格式之后将元素添加到场景
func geshi_chuli(bb):
	var nnode=Node2D.new()
	var bb0=bb.split('],')
	#存放处理好的数据，二维数组
	var bb1=[]
	for i in bb0:
		#数据符号处理
		for j in ['[',']','\\','"',' ','(',')']:
			i=i.replace(j,'')
		#数据分割
		i=i.split(',')
		#子数组长度小于6返回
		if len(i)<6:
			return
		var vec=Vector2(float(i[0])+float($jc/weizhi.text),float(i[1]))
		var k=[vec,i[2],i[3],i[4],i[5]]
		bb1.push_back(k)
		
	for i in bb1:
		var ystemp0=uen.instantiate()
		ystemp0.position=i[0]+Vector2($jc.position.x,0)
		ystemp0.get_node('yuansuti').get_node('调').text=i[1]
		ystemp0.get_node('yuansuti').get_node('阶').text=i[2]
		ystemp0.get_node('yuansuti').get_node('leixing').text=i[3]
		ystemp0.get_node('yuansuti').get_node('yinliang').text=i[4]
		if int(i[3])<Baocunwenjian.yinyuan_count:
			#将排列好的元素加入场景
			nnode.add_child(ystemp0)
		#设置读条数字
		if ystemp0.position.x>int($"jc/dutiaotext".text):
			$"jc/dutiaotext".text=str(int(ystemp0.position.x))
	nnode.position.x=$jc.position.x
	#创建undoredo活动
	undo_redo.create_action('addchild')
	undo_redo.add_do_method(self.add_child.bind(nnode))
	undo_redo.add_do_reference(nnode)
	#remove重置，move是移动
	undo_redo.add_undo_method(self.remove_child.bind(nnode))
	#启用undoredo活动
	undo_redo.commit_action()
	pass 


#选取状态检测
func _on_xuanqu_pressed():
	$jc/xuanqu.release_focus()
	#选取
	if $jc/xuanqu.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][2]:
		#完成
		$jc/xuanqu.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][3]
		#复制
		$jc/add_bg.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][6]
		return
	#完成
	if $jc/xuanqu.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][3]:
		$jc/xuanqu.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][2]
		#粘贴
		$jc/add_bg.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][7]
		#调整透明度为1，使元素不可移动
		connect_group_a('yuansu')
	pass 


var templist=[]
var yinfu0=[]
#控制分组元素透明度
func connect_group_a(group_name: String):
	#获取在场景中的元素，获取在‘yuansu’组内的元素
	var group_nodes = get_tree().get_nodes_in_group(group_name)
	for n in group_nodes:
		#如果节点是Node类型就继续
		if n is Node:
			#果透明度为0.5，则改为1
			if n.modulate.a ==0.5:
				#控制透明度为0.5时元素可移动（在元素场景中体现）
				#设置为1后元素不能通过ad和左右键控制移动
				n.modulate.a =1



#复制粘贴的复制
func fzzhantie(group_name):
	#清除上次复制的内容
	templist=[]
	var group_nodes = get_tree().get_nodes_in_group(group_name)
	for n in group_nodes:
		#如果节点是Node类型就继续
		if n is Node:
			#果透明度为0.5，则改为1
			if n.modulate.a ==0.5:
				yinfu0.append(n.global_position-Vector2($jc.position.x,0))
				yinfu0.append(n.get_node('yuansuti').get_node('调').text)
				yinfu0.append(n.get_node('yuansuti').get_node('阶').text)
				yinfu0.append(n.get_node('yuansuti').get_node('leixing').text)
				yinfu0.append(n.get_node('yuansuti').get_node('yinliang').text)
				#将数组yinfu加入数组wenj中
				templist.push_back(yinfu0)
				yinfu0=[]
				pass
	pass


func _on_zidongsaomiao_pressed():
	$jc/zidongsaomiao.release_focus()
	if $jc/zidongsaomiao.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][8]:
	#if $jc/zidongsaomiao.text=='自动扫描':
		if $jc/fuzhi.text!=Baocunwenjian.citiao[Baocunwenjian.suoyin][5]:
		#if $jc/fuzhi.text!='保存':
			$jc/fuzhi.emit_signal('pressed')
		$jc/zidongsaomiao.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][9]
		#$jc/zidongsaomiao.text='暂停'
		return
	if $jc/zidongsaomiao.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][9]:
	#if $jc/zidongsaomiao.text=='暂停':
		$jc/zidongsaomiao.text=Baocunwenjian.citiao[Baocunwenjian.suoyin][8]
		#$jc/zidongsaomiao.text='自动扫描'
	pass # Replace with function body.


func _on_yuyan_pressed():
	#获取menubutton中的popup元素实体
	var nn=$jc/yuyan.get_popup()
	nn.clear()
	for i in range(len(Baocunwenjian.yuyan)):
		nn.add_item(Baocunwenjian.yuyan[i])
	pass 


func _on_add_bg_pressed():
	#复制
	if $jc/add_bg.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][6]:
		fzzhantie('yuansu')
	#粘贴
	if $jc/add_bg.text==Baocunwenjian.citiao[Baocunwenjian.suoyin][7]:
		geshi_chuli(str(templist))
	pass # Replace with function body.



func _on_zidongbofang_pressed():
	$jc/zidongbofang.release_focus()
	if $jc/zidongbofang.text=='>>>':
		$jc/zidongbofang.text='^^'
		return
	if $jc/zidongbofang.text=='^^':
		$jc/zidongbofang.text='>>>'
	pass # Replace with function body.


#鼠标进入音源列表时调整信号，禁止元素加入场景
func _on_yinyuanliebiao_mouse_entered():
	yinyuan=1
	pass # Replace with function body.


func _on_yinyuanliebiao_mouse_exited():
	yinyuan=0
	pass # Replace with function body.


func _on_liebiao_mouse_entered():
	dakai=1
	pass # Replace with function body.


func _on_liebiao_mouse_exited():
	dakai=0
	pass # Replace with function body.


func _on_baocunliebiao_mouse_entered():
	baocun=1
	pass # Replace with function body.


func _on_baocunliebiao_mouse_exited():
	baocun=0
	pass # Replace with function body.


func _on_xuniqinpan_mouse_entered():
	qinjian=1
	pass # Replace with function body.


func _on_xuniqinpan_mouse_exited():
	qinjian=0
	pass # Replace with function body.
	

var baijian=[ 
   "A0", "B0", "C1", "D1", "E1", "F1", "G1", "A1", 
	"B1", "C2", "D2", "E2", "F2", "G2", "A2", "B2", "C3", 
	"D3", "E3", "F3", "G3", "A3", "B3", "C4", "D4", "E4", 
	"F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", 
	"A5", "B5", "C6", "D6", "E6", "F6", "G6", "A6", "B6", 
	"C7", "D7", "E7", "F7", "G7", "A7", "B7", "C8"]

var heijian=[
	"#A0", "#C1", "#D1", "#F1", "#G1", "#A1", "#C2", "#D2",
	 "#F2", "#G2", "#A2", "#C3", "#D3", "#F3", "#G3", "#A3", 
	 "#C4", "#D4", "#F4", "#G4", "#A4", "#C5", "#D5", "#F5", 
	 "#G5", "#A5", "#C6", "#D6", "#F6", "#G6", "#A6", "#C7", 
	 "#D7", "#F7", "#G7", "#A7"]


var anjian=0
#批量绑定事件
func key_bianhua():
	var group_bj = get_tree().get_nodes_in_group('baijian')
	var group_hj = get_tree().get_nodes_in_group('heijian')
	for i in group_bj:
		var j=i.get_index()
		#连接带参数的函数需要使用bind方法
		i.connect('mouse_entered',bjn.bind(j))
		i.connect('mouse_exited',bjn0)
	for i in group_hj:
		var j=i.get_index()
		i.connect('mouse_entered',hjn.bind(j))
		i.connect('mouse_exited',hjn0)
	pass

func bjn(i):
	qinjian=1
	$"Label调".text=baijian[i].substr(0,1)
	$"Label阶".text=baijian[i].substr(1,1)
	
func bjn0():
	qinjian=0
	
func hjn(i):
	qinjian=1
	$"Label调".text=heijian[i].substr(0,2)
	$"Label阶".text=heijian[i].substr(2,1)
	
func hjn0():
	qinjian=0
	
	

var dutiao=0
func _on_dutiao_mouse_entered():
	dutiao=1
	pass # Replace with function body.


func _on_dutiao_mouse_exited():
	dutiao=0
	pass # Replace with function body.


var top=0
func _on_top_mouse_entered():
	top=1
	pass # Replace with function body.


func _on_top_mouse_exited():
	top=0
	pass # Replace with function body.



func _on_shuoming_pressed():
	shiyong0()
	if $shiyong.visible==false:
		$shiyong.visible=true
		return
	if $shiyong.visible==true:
		$shiyong.visible=false
		return
	pass # Replace with function body.
	
	

var shiyong=0
func shiyong0():
	if shiyong==0:
		$shiyong/shuoming.show()
	else:
		$shiyong/shuoming.hide()
	if shiyong==1:
		$shiyong/a0.show()
	else:
		$shiyong/a0.hide()
	if shiyong==2:
		$shiyong/a1.show()
	else:
		$shiyong/a1.hide()
	if shiyong==3:
		$shiyong/a2.show()
	else:
		$shiyong/a2.hide()
	if shiyong==4:
		$shiyong/a3.show()
	else:
		$shiyong/a3.hide()
	if shiyong==5:
		$shiyong/a4.show()
	else:
		$shiyong/a4.hide()


func _on_button_pressed():
	if shiyong>0:
		shiyong-=1
	pass # Replace with function body.

func _on_button_2_pressed():
	if shiyong<5:
		shiyong+=1
	pass # Replace with function body.
	
	

func _on_shiyong_draw():
	Baocunwenjian.sy=1
	qinjian=0
	pass # Replace with function body.

func _on_shiyong_hidden():
	Baocunwenjian.sy=0
	pass # Replace with function body.

func _on_close_pressed():
	$shiyong.hide()
	pass # Replace with function body.


func do_shuominng():
	var content=''
	var bin=FileAccess.open("res://baocunwenjain/1.txt",FileAccess.READ)
	if bin!=null:
		content = bin.get_as_text()
		print(content)
		bin.close()
	else :
		var bin0=FileAccess.open("res://baocunwenjain/1.txt",FileAccess.WRITE)
		bin0.store_string('0')
		bin0.close()
	if int(content)==0:
		#将按钮状态设为true
		$shiyong/CheckBox.button_pressed=true
		$shiyong.show()
	else :
		$shiyong/CheckBox.button_pressed=false
		$shiyong.hide()
	

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		var bin=FileAccess.open("res://baocunwenjain/1.txt",FileAccess.WRITE)
		bin.store_string('0')
		bin.close()
		return
	else:
		var bin=FileAccess.open("res://baocunwenjain/1.txt",FileAccess.WRITE)
		bin.store_string('1')
		bin.close()
	pass # Replace with function body.'''


