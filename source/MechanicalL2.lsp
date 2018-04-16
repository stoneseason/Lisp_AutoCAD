;;--------------------------------------
;;������	c:MechanicalL2 
;;--------------------------------------
;;--------------------------------------
;; ˵����    ����MechanicalLayers2
;;        cǰ׺��ʾ���Դ������е���
;; �÷���
;;      1. appload�� ѡ�����lsp
;;      2. �������� MechanicalL2
;;      3. �������� re
;;--------------------------------------

(defun c:MechanicalL2 ()

  (setq om (getvar "osmode"))
  (setvar "osmode" 0)

  
;��������ͼ��
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
	

  ;��TopOverLayer�ϴ�ӡ����
  (command "layer" "set" "TopOverLayer" "")
	(setq pTO(list 110 5))
	(command "text" "m" pTO 1.5 0 (strcat "D=" (rtos diameter 2 1) " P=" (rtos pitch 2 1) " -- By UCAS"))
        
	
	(setq TT (entlast))

	(command "LAYISO" TT "") ;�رջ�е��TopOverLayer���������ͼ��
	(setq ss (ssget "w" '(0 0) '(180 180))) ;p1��p2������Σ�ѡ����ȫ���ڸþ��Σ����α�ԵҲ���ھ��Σ������ж���
	(command "move" ss "" "D" p0)
	(command "LAYON")

  ;��MechanicalLayers2�ϴ��
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
	
	(command "LAYISO" M2A2 "") ;�رջ�е��2���������ͼ��
	(setq ss (ssget "w" '(0 0) '(180 180))) ;p1��p2������Σ�ѡ����ȫ���ڸþ��Σ����α�ԵҲ���ھ��Σ������ж���
	(command "move" ss "" "D" p0)
	(command "mirror" ss "" '(0 0) '(0 100) "N")  ;��ѡ��Ķ�����о���
	(command "LAYON")

	

  	
  
  (setvar "osmode" om)
 )