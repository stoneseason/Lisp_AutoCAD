;;--------------------------------------
;;函数：	c:MechanicalL2 
;;--------------------------------------
;;--------------------------------------
;; 说明：    绘制MechanicalLayers2
;;        c前缀表示可以从命令行调用
;; 用法：
;;      1. appload， 选择这个lsp
;;      2. 输入命令 MechanicalL2
;;      3. 输入命令 re
;;--------------------------------------

(defun c:MechanicalL2 ()

  (setq om (getvar "osmode"))
  (setvar "osmode" 0)

  
;定义六个图层
  (command "layer" "new" "TopOverLayer" "")
  (command "layer" "new" "TopLayer" "")
  (command "layer" "new" "BottomLayer"  "")
  (command "layer" "new" "BottomOverLayer"  "")
  (command "layer" "new" "MechanicalLayers1" "")
  (command "layer" "new" "MechanicalLayers2" "")

  
  (setq p0 (list 20 20)
	diameter 0.3
	pitch 0.6
	length 150
	height 150
  )
  (setq nrow (fix (/ height (* pitch (sqrt 3))))
	ncol (fix (/ length pitch))
  )
	

  ;在TopOverLayer上打印文字
  (command "layer" "set" "TopOverLayer" "")
	(setq pTO(list 110 5))
	(command "text" "m" pTO 1.5 0 (strcat "D=" (rtos diameter 2 1) " P=" (rtos pitch 2 1) " -- By UCAS"))
        
	
	(setq TT (entlast))

	(command "LAYISO" TT "") ;关闭机械层TopOverLayer以外的所有图层
	(setq ss (ssget "w" '(0 0) '(180 180))) ;p1和p2构造矩形，选择完全属于该矩形（矩形边缘也属于矩形）的所有对象
	(command "move" ss "" "D" p0)
	(command "LAYON")

  ;在MechanicalLayers2上打孔
  (command "layer" "set" "MechanicalLayers2" "")
	(setq pM2H1 (list 14 14))
	(setq pM2H2 (polar pM2H1 (/ pi 3) pitch))

	(command "CIRCLE" pM2H1 (/ diameter 2))
	(setq M2H1 (entlast))	
	(command "ARRAYRECT" M2H1 "" "C" (+ nrow 1) (+ ncol 1) "S" (* pitch (sqrt 3)) pitch "")
	
	(command "CIRCLE" pM2H2 (/ diameter 2))
	(setq M2H2 (entlast))
	(command "ARRAYRECT" M2H2 "" "C" (+ nrow 1) ncol "S" (* pitch (sqrt 3)) pitch "")
	(setq M2A2 (entlast))
	
	(command "LAYISO" M2A2 "") ;关闭机械层2以外的所有图层
	(setq ss (ssget "w" '(0 0) '(180 180))) ;p1和p2构造矩形，选择完全属于该矩形（矩形边缘也属于矩形）的所有对象
	(command "move" ss "" "D" p0)
	(command "mirror" ss "" '(0 0) '(0 100) "N")  ;对选择的对象进行镜像
	(command "LAYON")

	

  	
  
  (setvar "osmode" om)
 )