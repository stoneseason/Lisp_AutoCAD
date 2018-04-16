;;--------------------------------------
;;函数：	c:TopL 
;;--------------------------------------
;;--------------------------------------
;; 说明：    绘制TopLayer
;;        c前缀表示可以从命令行调用
;; 用法：
;;      1. appload， 选择这个lsp
;;      2. 输入命令 TopL
;;      3. 输入命令 re
;;--------------------------------------

(defun c:TopL ()

  (setq om (getvar "osmode"))
  (setvar "osmode" 0)

  
;定义六个图层
  (command "layer" "new" "TopOverLayer" "")
  (command "layer" "new" "TopLayer" "")
  (command "layer" "new" "BottomLayer"  "")
  (command "layer" "new" "BottomOverLayer"  "")
  (command "layer" "new" "MechanicalLayers1" "")
  (command "layer" "new" "MechanicalLayers2" "")

  ;在BottomLayer上画外框
  (command "layer" "set" "TopLayer" "")

  (setq p0 (list 20 20))
  (setq pTA (list 5 104)
	pTB (list 13 13)
	pTC (list 165 165)
	pTD (list 5 105)
	pTE (list 6 104)
	pTF (list 13 103)
	pTG (list 13 104)
  )

	
	(command "RECTANG" pTD pTF "")
	(setq TR1 (entlast))
  	(command "CIRCLE" pTA 1)
	(setq TC1 (entlast))

	(command "TRIM" TC1 TR1 "" (list TC1 pTE) (list TR1 pTA) "")
  
	(command "JOIN" TR1 TC1 "") ;TR1和TC1的顺序不要交换
	(setq TElectrode(entlast))

	(command "RECTANG" pTB pTC)
	(setq TR2 (entlast))

	(command "TRIM" TElectrode TR2 "" (list TElectrode pTG) (list TR2 pTG) "")
	(command "JOIN" TElectrode TR2 "")
  	(setq TCopper (entlast))

  	(command "FILLET" "r" 1)
  	(command "FILLET" "P" (list TCopper pTB) )

	(command "LAYISO" TCopper "") ;关闭顶层以外的所有图层
	(setq ss (ssget "w" '(0 0) pTC))
	(command "move" ss "" "D" p0)	
	(command "LAYON") 

  
  (setvar "osmode" om)
 )