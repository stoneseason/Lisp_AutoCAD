;;--------------------------------------
;;函数：	c:MechanicalL1 
;;--------------------------------------
;;--------------------------------------
;; 说明：    绘制MechanicalLayers1
;;        c前缀表示可以从命令行调用
;; 用法：
;;      1. appload， 选择这个lsp
;;      2. 输入命令 THGEM
;;      3. 输入命令 re
;;--------------------------------------

(defun c:MechanicalL1 ()

  (setq om (getvar "osmode"))
  (setvar "osmode" 0)

  
;定义六个图层
  (command "layer" "new" "TopOverLayer" "")
  (command "layer" "new" "TopLayer" "")
  (command "layer" "new" "BottomLayer"  "")
  (command "layer" "new" "BottomOverLayer"  "")
  (command "layer" "new" "MechanicalLayers1" "")
  (command "layer" "new" "MechanicalLayers2" "")

  ;在MechanialLayer1上画PCB板外框,定位孔，电极过孔
  (command "layer" "set" "MechanicalLayers1" "")

  (setq p0 (list 20 20))
  (setq pM1C1 (list 5 5)
	pM1C2 (list 47 5)
	pM1C3 (list 89 5)
	pM1C4 (list 131 5)
	pM1C5 (list 173 5)
	pM1C6 (list 5 47)
	pM1C7 (list 5 89)
	pM1C8 (list 5 131)
	pM1C9 (list 5 173)
	pM1C10 (list 173 47)
	pM1C11 (list 173 89)
	pM1C12 (list 173 131)
	pM1C13 (list 173 173)
	pM1C14 (list 47 173)
	pM1C15 (list 89 173)
	pM1C16 (list 131 173) ;16个定位孔的中心
	pM1R1 (list 0 0)
	pM1R2 (list 178 178) ;PCB外边缘定位孔
	pM1H1 (list 5 74)
	pM1H2 (list 5 104)  ;电极过孔
  )
	;画定位孔
 	(command "CIRCLE" pM1C1 2.6)
	(command "CIRCLE" pM1C2 2.6)
	(command "CIRCLE" pM1C3 2.6)
	(command "CIRCLE" pM1C4 2.6)
	(command "CIRCLE" pM1C5 2.6)

	(command "CIRCLE" pM1C6 2.6)
	(command "CIRCLE" pM1C7 2.6)
	(command "CIRCLE" pM1C8 2.6)
	(command "CIRCLE" pM1C9 2.6)

	(command "CIRCLE" pM1C10 2.6)
	(command "CIRCLE" pM1C11 2.6)
	(command "CIRCLE" pM1C12 2.6)
	(command "CIRCLE" pM1C13 2.6)

	(command "CIRCLE" pM1C14 2.6)
	(command "CIRCLE" pM1C15 2.6)
	(command "CIRCLE" pM1C16 2.6)
	
	;画边缘
	(command "RECTANG" pM1R1 pM1R2 "")
	(setq M1R1 (entlast))

	;做圆角
	(command "FILLET" "r" 1)
  	(command "FILLET" "P" (list M1R1 pM1R1))

	;画过孔
	(command "CIRCLE" pM1H1 0.5)
	(command "CIRCLE" pM1H2 0.5)
  	
	;(setq GOP (SSGET "X" '((8 . "MechanicalLayers1"))))
	
	(command "LAYISO" M1R1 "") ;关闭机械层1以外的所有图层

	(setq ss (ssget "w" pM1R1 pM1R2)) ;pM1R1和pM1R2构造矩形，选择完全属于该矩形（矩形边缘也属于矩形）的所有对象
	(command "move" ss "" "D" p0)
	(command "mirror" ss "" '(0 0) '(0 100) "N")  ;对选择的对象进行镜像
	
	(command "LAYON")
	
  
  (setvar "osmode" om)
 )