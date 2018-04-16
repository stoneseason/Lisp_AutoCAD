;;--------------------------------------
;;������	c:CopperLayer 
;;--------------------------------------
;;--------------------------------------
;; ˵����    ����THGEM
;;        cǰ׺��ʾ���Դ������е���
;; �÷���
;;      1. appload�� ѡ�����lsp
;;      2. �������� THGEM
;;      3. �������� re
;;--------------------------------------

(defun c:Copperplus ()

  (setq om (getvar "osmode"))
  (setvar "osmode" 0)

;��������ͼ��
  (command "layer" "new" "TopOverLayer" "")
  (command "layer" "new" "TopLayer" "")
  (command "layer" "new" "BottomLayer"  "")
  (command "layer" "new" "BottomOverLayer"  "")
  (command "layer" "new" "MechanicalLayers1" "")
  (command "layer" "new" "MechanicalLayers2" "")

;��BottomLayer�ϻ����
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
