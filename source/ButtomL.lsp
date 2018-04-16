;;--------------------------------------
;;函数：	c:BottomL 
;;--------------------------------------
;;--------------------------------------
;; 说明：    绘制BottomLayer
;;        c前缀表示可以从命令行调用
;; 用法：
;;      1. appload， 选择这个lsp
;;      2. 输入命令 BottomL
;;      3. 输入命令 re
;;--------------------------------------

(defun c:BottomL ()

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
  (command "layer" "set" "BottomLayer" "")

  (setq p0b (list -20 20))
  (setq pBA (list -5 74)
	pBB (list -13 13)
	pBC (list -165 165)
	pBD (list -5 75)
	pBE (list -6 74)
	pBF (list -13 73)
	pBG (list -13 74)
  )

	
	(command "RECTANG" pBD pBF "")
	(setq BR1 (entlast))
  	(command "CIRCLE" pBA 1)
	(setq BC1 (entlast))

	(command "TRIM" BC1 BR1 "" (list BC1 pBE) (list BR1 pBA) "")

  
	(command "JOIN" BR1 BC1 "") ;BR1和BC1的顺序不要交换
	(setq BElectrode(entlast))

	(command "RECTANG" pBB pBC)
	(setq BR2 (entlast))

	(command "TRIM" BElectrode BR2 "" (list BElectrode pBG) (list BR2 pBG) "")
	(command "JOIN" BElectrode BR2 "")
  	(setq BCopper (entlast))

  	(command "FILLET" "r" 1)
  	(command "FILLET" "P" (list BCopper pBB) )

	(command "LAYISO" BCopper "") ;关闭底层以外的所有图层
	(setq ss (ssget "w" '(0 0) pBC))
	(command "move" ss "" "D" p0b)	
	(command "LAYON")  

  (setvar "osmode" om)
 )