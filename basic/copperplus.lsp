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

(defun c:Copperplus ()

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
  (setq p1 (list 0 0)
        p2 (list 10 10)
	p3 (list 4 10)
	p4 (list 6 16)
	p5 (list 5 10)
  )
  (setq p0 (list 0 0)
	r0 (distance '(0 0) p0)
	a0 (angle '(0 0) p0)
	p1 (polar p1 a0 r0)
	p2 (polar p2 a0 r0)
	p3 (polar p3 a0 r0)
	p4 (polar p4 a0 r0)
	p5 (polar p5 a0 r0)
  )

  (command "RECTANG" p1 p2 "")
  (setq Frame1 (entlast))
  
  (command "RECTANG" p3 p4 )
  (setq Frame2 (entlast))
  
  (command "trim" Frame1 Frame2 "" p5 p5 "")
   
  (command "JOIN" Frame1 Frame2 "")
  (setq Frame (entlast))
  (command "FILLET" "r" 0.5)
  (command "FILLET" "P" (list Frame '(0 5)) )
  (setvar "osmode" om)

)
