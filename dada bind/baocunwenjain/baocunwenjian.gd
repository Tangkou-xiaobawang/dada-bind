extends Node2D


var suoyin=0
var yuyan=['中文','English','русский','한국어','日本語','français','Deutsch']
var citiao=[#0-18
	["打开", "取消", "选取", "完成", "扫描", "保存", "复制", "粘贴", "自动扫描", "暂停", "按键音", 
	"停止", "查看音源", "确定", "速度:","文件名重复，是否覆盖原文件？","关闭","打开目录",
	'''简单操作说明：
鼠标左键点击，在点击位置生成音符；滚动鼠标中键切换音调；单机鼠标右键出现/隐藏橡皮擦。
键盘 ' 1234567qwert ' 切换音色，' zxcvbnm , . ' 切换音阶。
主键盘数字键的 ' -+ ' 控制音量；' [ ] ' 键切换音源。
按钮快捷键有F1、F2、F3、F4、F5、F6以及空格。
emmmmm，大体就这些了。'''],
	["Open", "Cancel","Select", "Complete", "Scan", "Save", "Copy", "Paste", "Auto Scan", 
	"Pause", "Button Sound", "Stop", "Source", "OK", 
	"Speed:","The file name is duplicate. Do you want to overwrite the original file?",
	"close","Directory",
	'''Simple operation instructions:
Left click with the mouse to generate notes at the click location; Scroll the middle mouse button to switch tones; Right click on the standalone mouse to show/hide the eraser.
Keyboard '1234567qwert' switches voice, 'zxcvbnm , .' Switch scales.
The '-+' number keys on the main keyboard control the volume The '[ ]' key switches the audio source.
The button shortcuts include F1, F2, F3, F4, F5, F6, and spaces.
emmmmm， That's all for the most part.'''],
	["Открыть "," Отменить "," Выбрать "," завершить "," Сканирование "," Сохранить ",
	" Копировать "," Вставить "," Автоскан "," Приостановить "," Звук клавиш ",
	"Стоп", "Источники звука", "Определить", "Скорость:",
	 "Файл имя повторяется , Покрыть оригинал файл? "," Закрыть "," Каталог ",
	'''Простые инструкции:
Щёлкните левой кнопкой мыши, чтобы создать ноту в положении щелчка; Переключить тон средней кнопки мыши; Правая кнопка мыши появляется / скрывает ластик.
Клавиатура '1234567qwert' Переключить звук, 'zxcvbnm , .' Переключить громкость.
Главная клавиша цифровой клавиши '- +' управляет громкостью; '[ ]' Клавиша переключает источник звука.
Комбинации клавиш включают F1, F2, F3, F4, F5, F6 и пробелы.
emmmmm， В основном это все.'''],
	['열기', '취소', '선택', '완료', '스캔',' 저장', '복사', '붙여넣기',' 자동 스캔', '일시정지', 
	'키 소리','중지', '음원', '확인','속도:', '파일 이름이 중복됩니다. 원래 파일을 덮어쓰시겠습니까?',
	 '닫기', '디렉토리',
	'''간단한 작업 지침:
마우스 왼쪽 버튼을 클릭하여 클릭 위치에 음표를 생성합니다.마우스 가운데 버튼을 스크롤하여 톤 전환;지우개가 마우스 오른쪽 버튼으로 나타나거나 숨겨집니다.
키보드'1234567qwert'음색 전환,'zxcvbnm'음계를 바꾸다.
기본 키보드 숫자 키의'-+'음량 조절; '[ ]'키로 음원을 전환합니다.
버튼 바로 가기에는 F1, F2, F3, F4, F5, F6 및 공백이 있습니다.
emmmmm，대체로 이 정도이다.'''],
	['開く','キャンセル','選択','完了','スキャン','保存','コピー','貼り付け','自動スキャン','一時停止',
	'キートーン','停止','音源','OK','速度：','ファイル名が重複していますが、元のファイルを上書きしますか？',
	'閉じる','カタログ',
	'''簡単な操作の説明：
マウスの左ボタンをクリックして、クリック位置に音符を生成します。マウスの中ボタンをスクロールしてトーンを切り替えます。スタンドアロンマウスの右ボタンで消しゴムが表示/非表示になります。
キーボード'1234567 qwert'音色を切り替え、'zxcvbnm，.'音階を切り替えます。
プライマリキーの数字キーの'-+'は音量を制御します; '[ ]' キー切り替え音源。
ボタンのショートカットには、F 1、F 2、F 3、F 4、F 5、F 6とスペースがあります。'''],
	["Ouvrir", "annuler", "sélectionner", "terminer", "Scan", "Enregistrer", "copier", 
	"coller", "AUTO SCAN", "pause", "tonalité","Stop", "soundsource", "OK", "Speed:", 
	"file name repeat, are the original overlay?", "OFF", "répertoire",
	'''Instructions d'utilisation simples:
Cliquez avec le bouton gauche de la souris pour générer des notes en position de clic; Faites défiler le bouton central de la souris pour changer de tonalité; Le bouton droit de la souris d'une machine apparaît / masque la gomme.
Clavier '1234567qwert' pour changer de ton, 'zxcvbnm , .' Commutez les gammes.
'- +' contrôle le volume des touches numériques du clavier principal; ' [ ] 'touche pour changer la source sonore.
Les raccourcis de bouton sont F1, F2, F3, F4, F5, F6 et espace.
emmmmm， C'est tout, en gros.'''],
	["Öffnen", "Abbrechen", "Auswählen", "Beenden", "Scannen", "Speichern", "Kopieren",
	 "Einfügen", "Auto Scan", "Pause", "Button Sound", "Stop", "Source", "OK", "Geschwindigkeit:",
	 "Dateiname ist dupliziert, möchten Sie die Originaldatei überschreiben?", "Schließen", 
	"Verzeichnis",
	'''Einfache Bedienung:
Linksklick mit der Maus, um Notizen an der Klickstelle zu generieren; Scrollen Sie mit der mittleren Maustaste, um Töne zu wechseln; Klicken Sie mit der rechten Maustaste auf die eigenständige Maus, um den Radiergummi ein-/auszublenden.
Tastatur '1234567qwert' schaltet Stimme, 'zxcvbnm,.' Waage wechseln.
Die '-+'-Nummerntasten auf der Haupttastatur steuern die Lautstärke Die ' [ ] ' Taste schaltet die Audioquelle um.
Die Tastenkombinationen umfassen F1, F2, F3, F4, F5, F6 und Leerzeichen.
emmmmm， Das ist zum größten Teil alles.''']
]

#读取语言文件并设置
func shezhiyuyan():
	var file = FileAccess.open("res://baocunwenjain_t/diudiu.piupiu", FileAccess.READ)
	if file!=null:
		var content = file.get_as_text()
		file.close()
		if content	in yuyan:
			get_tree().get_first_node_in_group('yuyan').text=content
		else :
			var file0 = FileAccess.open("res://baocunwenjain_t/diudiu.piupiu", FileAccess.WRITE)
			file0.store_string('中文')
			file0.close()
	else:
		var file0 = FileAccess.open("res://baocunwenjain_t/diudiu.piupiu", FileAccess.WRITE)
		file0.store_string('中文')
		file0.close()
		pass

var yinyuan_count=0
var sy=0
var qinjian=0
var anjianyin=1
var wenj=[]
var yinfu=[]

var a=[1,2,3,4,5,6,7,8,9]
# Called when the node enters the scene tree for the first time.
func _ready():
	shezhiyuyan()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
#
func saveyinfu(content,filename:String):
	var file = FileAccess.open("res://baocunwenjain_t/"+filename, FileAccess.WRITE)
	file.store_string(str(content))
	file.close()


#写入
func save00(_content,arr):
	var qq=0
	for i in range(len(liebiaochuli(_content,arr))):
		#直接用字符串对比会有问题，所以逐个字符检查
		if liebiaochuli(_content,arr).substr(i,1) != load00().substr(i,1):
			qq+=1
			break
		pass
	if qq>0:
		var file = FileAccess.open("res://baocunwenjain/yinyuanliebiao.gd", FileAccess.WRITE)
		file.store_string(liebiaochuli(_content,arr))
		file.close()
		pass
	else :
		pass
	pass


#获取列表中的文件，并将内容格式化
func liebiaochuli(_content,arr):
	#将内容写入文件
	var file_name := ""
	var files := 'extends Node'+'\n'+'const a=['
	var path="res://yinyuan/"
	var dir := DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		file_name = dir.get_next()
		while file_name != "":
			#打印固定文件格式文件名
			if file_name.substr(file_name.length()-4, 4).to_lower() in arr:
				var name00 = 'preload('+ '\'' + path + file_name  +'\'' + ')' + ','
				#在数组末尾加入元素
				files += name00
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open:"+path)
		return
	files=files.substr(0,len(files)-1)
	files+=']'
	return files



#读取文件
func load00():
	var file = FileAccess.open("res://baocunwenjain/yinyuanliebiao.gd", FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content


#获取音源文件名称并筛选
func get_file_and_sift(arr:Array):
	var file_name := ""
	var files := []
	var path="res://yinyuan/"
	var dir := DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				var sub_path = path  + file_name
				#在数组末尾加入元素,与push_back作用相同
				files.append(sub_path) 
				#打印固定文件格式文件名
			elif file_name.substr(file_name.length()-4, 4).to_lower() in arr:
				var name00 = 'preload('+path + file_name+')'
				#在数组末尾加入元素
				files.push_back(name00)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open:"+path)
	return files
	
	
func read_file(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file!=null:
		var content = file.get_as_text()
		file.close()
		print("Content of %s:\n%s" % [file_path, content])
		return content
		
	else:
		print("Failed to read file: %s" % file_path)

