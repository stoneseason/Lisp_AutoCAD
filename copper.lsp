;;--------------------------------------
;;函数：	c:CopperLayer 
;;--------------------------------------
;;--------------------------------------
;; 说明：    绘制THGEM
;;        c前缀表示可以从命令行调用
;; 用法：
;;      1. appload， 选择这个lsp
;;      2. 输入命令 THGEM
;;      3. 输入命令 re
;;--------------------------------------

(defun c:CopperLayer ()

  (setq om (getvar "osmode"))

;定义六个图层
  (command "layer" "new" "TopOverLayer" "")
  (command "layer" "new" "TopLayer" "")
  (command "layer" "new" "BottomLayer"  "")
  (command "layer" "new" "BottomOverLayer"  "")
  (command "layer" "new" "MechanicalLayers1" "")
  (command "layer" "new" "MechanicalLayers2" "")

;在BottomLayer上画外框
  (command "layer" "set" "BottomLayer" "")
  (setq p1 (list 0 0)
        p2 (list 10 10)
  )
  (setq p0 (list 0 0)
	r0 (distance '(0 0) p0)
	a0 (angle '(0 0) p0)
	p1 (polar p1 a0 r0)
	p2 (polar p2 a0 r0)
  )
  
  (command "RECTANG" p1 p2 "")
  (setq Frame1 (entlast))
  ;(setq L1 (ssget ":E:S" ))
  ;(setq L2 (ssget ":E:S" ))
  (setq L1 (ssget "c" '(-1 4) '(1 6) '((0 . "LINE"))))
  (setq L2 (ssget "c" '(4 -1) '(6 1) '((0 . "LINE"))))
  ;(setq L1 (ssget "c" '(0 5) '(0 5) ))
  ;(setq L2 (ssget "c" '(5 0) '(5 0) ))
  (command "FILLET" "r" 3)
  (command "FILLET" "P" (list Frame1 '(0 5)) )
  
  (setvar "osmode" om)

)
