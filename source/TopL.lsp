;;--------------------------------------
;;������	c:TopL 
;;--------------------------------------
;;--------------------------------------
;; ˵����    ����TopLayer
;;        cǰ׺��ʾ���Դ������е���
;; �÷���
;;      1. appload�� ѡ�����lsp
;;      2. �������� TopL
;;      3. �������� re
;;--------------------------------------

(defun c:TopL ()

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
  
	(command "JOIN" TR1 TC1 "") ;TR1��TC1��˳��Ҫ����
	(setq TElectrode(entlast))

	(command "RECTANG" pTB pTC)
	(setq TR2 (entlast))

	(command "TRIM" TElectrode TR2 "" (list TElectrode pTG) (list TR2 pTG) "")
	(command "JOIN" TElectrode TR2 "")
  	(setq TCopper (entlast))

  	(command "FILLET" "r" 1)
  	(command "FILLET" "P" (list TCopper pTB) )

	(command "LAYISO" TCopper "") ;�رն������������ͼ��
	(setq ss (ssget "w" '(0 0) pTC))
	(command "move" ss "" "D" p0)	
	(command "LAYON") 

  
  (setvar "osmode" om)
 )