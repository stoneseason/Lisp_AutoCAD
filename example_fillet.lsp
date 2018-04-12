(defun c:WQ10 ( / #os1 aa l1 l2 p1 p2 p3 p4 p5 p6 p7 p8)
(setq #os1 (getvar "osmode"))
(setq p1 (getpoint "\n请选择基点"))
(if (/= p1 nil)
 (progn
  (setq p2 (polar p1 pi 208)
        p3 (polar p1 pi 288)
        p4 (polar p2 (* 0.5 pi) 420)
        p5 (polar p4 0 418)
        p6 (polar p1 0 208)
        p7 (polar p1 0 288)
        p8 (polar p1 (* pi 0.5) 90)
   )
   (setvar "osmode" 0);关闭捕捉才可以绘制图元，否则会不正确
   (command "LINE" p2 p4 "")
   (setq L1 (entlast))
   (command "LINE" p6 p5 "")
   (setq L2 (entlast))
   (command "ARC" p7 p8 p3)
   (setq AA (entlast))
   (command "fillet" "r" 50)
   (command "fillet" (list AA p7) (list L2 p5))
   (entdel AA)
   (command "ARC" p7 p8 p3)
   (setq AA (entlast))
   (command "fillet" (list AA p3) (list L1 p4));加圆角的时候有选择点
   (entdel AA);删除已经倒圆角的弧，在高版本里面圆弧会断线这个改变的圆弧要删除
   (command "ARC" p7 p8 p3);绘制圆弧
   (setvar "osmode" #os1)
  )
 )
 (prin1)
);在高版本里面，直线也会变短达到你要绘制的要求。