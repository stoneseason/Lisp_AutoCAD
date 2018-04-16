;;--------------------------------------------;;
;; 函数：      c:THGEM
;;--------------------------------------------;;
;; 说明：    绘制THGEM
;;        c前缀表示可以从命令行调用
;; 用法：
;;      1. appload， 选择这个lsp
;;      2. 输入命令 THGEM
;;      3. 输入命令 re
;;--------------------------------------------;;

(setq ARC     0)
(setq ARCLINE 1)

(setq MIRROR 0)
(setq FRONT  1)
(setq FMBOTH 2)

(setq NODB 0)
(setq   DB 1)

(defun c:THGEM(/ LineO LineT1 LineT2 LineB1 LineB2 Holes GHoles TextP DHoles R DRes c0 tp0 DHole Pitch)
  ;关闭屏幕对命令运行结果的输出
  (setvar "cmdecho" 0)
  ;关闭画图时候的十字辅助线
  (setvar "blipmode" 0)

  (command "layer" "new" "TopOverLayer" "")
  (command "layer" "new" "TopLayer" "")
  (command "layer" "new" "BottomLayer"  "")
  (command "layer" "new" "BottomOverLayer"  "")
  (command "layer" "new" "MechanicalLayers1" "")
  (command "layer" "new" "MechanicalLayers2" "")
 
  ;用Mathematica计算所有的点的位置后
  ;直接画图
(setq LineO  (list 20 59 0.3 20 20 3 353 20 3 353 252 3 20 252 3 20 123 0.3 10 123 0.3 10 115 0.3 20 115 0.3 20 67 0.3 10 67 0.3 10 59 0.3 20 59 0.3 20 20 3))

(setq LineT1  (list 341.5 31. 3 31.5 31. 3 31.5 116 2 11 116 2 11 122 2 31.5 122 2 31.5 241. 3 341.5 241. 3 341.5 31. 3 31.5 31. 3))

(setq LineT2  (list 11 60 2 11 66 2 20 66 2 20 60 2 11 60 2 11 66 2))

(setq LineB1  (list 341.5 31. 3 31.5 31. 3 31.5 60 2 11 60 2 11 66 2 31.5 66 2 31.5 241. 3 341.5 241. 3 341.5 31. 3 31.5 31. 3))

(setq LineB2  (list 11 116 2 11 122 2 20 122 2 20 116 2 11 116 2 11 122 2))

(setq Holes  (list 26 26 79.5 26 133. 26 186.5 26 240. 26 293.5 26 347. 26 347. 81 347. 136 347. 191 347. 246 293.5 246 240. 246 191 246 136 246 81 246 26 246 26 191 26 136 26 81))

(setq GHoles (list 15.5 63. 15.5 119.))

(setq TextP (list 159.75 26 0))

(setq GEMHoles (list 36.5 36. 0))

(setq LX 300 LY 200)

  (setq c0 (list 12 5 0))
  (setq DHoles 6 DRes 1.0)

; frames
  (command "layer" "set" "MechanicalLayers1" "")
  (tm:drawOutLine c0 LineO FMBOTH)
  (tm:drawFixHoles c0 Holes DHoles)
  (tm:drawFixHoles c0 GHoles DRes)

  (command "layer" "set" "TopLayer" "")
  (tm:drawOutLine c0 LineT1 FRONT)
  (tm:drawOutLine c0 LineT2 FRONT)

  (command "layer" "set" "BottomLayer" "")
  (tm:drawOutLine c0 LineB1 MIRROR)
  (tm:drawOutLine c0 LineB2 MIRROR)

; GEM holes
  (setq DHole 0.3 Pitch 0.6)

  (command "layer" "set" "TopOverLayer" "")
  (setq tp0 (tm:AddPos c0 TextP))
  (command "text" tp0 1.5 0 "D=0.3 P=0.6 -- By UCAS")

  (command "layer" "set" "MechanicalLayers2" "")
  (tm:drawHoles c0 GEMHoles LX LY DHole Pitch)

  ;恢复成原来的设置
  (setvar "cmdecho" 1)
  (prin1)
)

(prompt "*****************< THGEM >*****************")
(prin1)

;;--------------------------------------------;;
;; 函数：    tm:drawOutLine
;;--------------------------------------------;;
;; 说明： 本函数绘制THGEM外框
;;        tm前缀为用户自定义的程序
;;--------------------------------------------;;
(defun tm:drawOutLine(c0 LP MRflag / NP R1 R2 i p0 p1 p2)

  (setq NP (- (/ (length LP) 3) 1))
 
  (setq i 1)

  (while (< i NP) 
     (setq p1 (tm:AddPos c0 (list (nth (* i 3) LP)       (nth (1+ (* i 3)) LP) 0)))
     (setq p0 (tm:AddPos c0 (list (nth (* (- i 1) 3) LP) (nth (1+ (* (- i 1) 3)) LP) 0)))
     (setq p2 (tm:AddPos c0 (list (nth (* (+ i 1) 3) LP) (nth (1+ (* (+ i 1) 3)) LP) 0)))
     (setq R1 (nth (+ 2 (* i 3)) LP))
     (setq R2 (nth (+ 2 (* (+ i 1) 3)) LP))
     (tm:DrawTangent p0 p1 p2 R1 R2 ARCLINE MRflag)
     (setq i (1+ i))
  )
)

;;--------------------------------------------;;
;; 函数：    tm:drawFixHoles
;;--------------------------------------------;;
;; 说明：     画定位孔
;;--------------------------------------------;;
(defun tm:drawFixHoles(c0 LH d / p1 r NH i)

  (setq r (/ d 2))
  (setq NH (/ (length LH) 2)) 
  (setq i 0)

  (while (< i NH)
     (setq p1 (tm:AddPos c0 (list (abs (nth (* i 2) LH)) (abs (nth (1+ (* i 2)) LH)) 0)))
     (tm:DrawHole p1 r FMBoth)
     (setq i (1+ i))
  )
)

;;--------------------------------------------;;
;; 函数：    tm:drawHoles
;;--------------------------------------------;;
;; 说明：     画THGEM孔
;;--------------------------------------------;;
(defun tm:drawHoles(c0 offset LX LY d p / p0 nx1 ny1)

  (setq p0 (tm:AddPos c0 offset))
  (setq r (/ d 2))
  (setq nx1 (rtos (1+ (/ (- LX d) (* p (sqrt 3)))) 2 0))
  (setq ny1 (rtos (1+ (/ (- LY d) p)) 2 0))

  (command "circle" p0 r)
  (command "array" (entlast) "" "r" ny1 nx1 p (* p (sqrt 3)))
  (command "circle" (polar p0 (/ pi 6) p) r)
  (command "array" (entlast) "" "r" ny1 nx1 p (* p (sqrt 3)))
  (princ "\nTotal number of holes = ") (princ nx1) (princ "*") (princ ny1)

  (command "circle" (list (* -1 (car p0)) (cadr p0) (caddr p0)) r)
  (command "array" (entlast) "" "r" ny1 nx1 p (* p (sqrt 3) -1))

  (command "circle" (polar (list (* -1 (car p0)) (cadr p0) (caddr p0)) (* (/ pi 6) 5) p) r)
  (command "array" (entlast) "" "r" ny1 nx1 p (* p (sqrt 3) -1))
)




;;--------------------------------------------;;
;; 函数：    tm:DrawTangent
;;          画的是 p0---p1---p2 之间的线段
;;               R: p1这个夹角处的弧半径
;;               d; p1连接到p2处时，p2需要留出来的距离
;;                  比如p2处也是一个弧角，那么就也要留出来p2处一个弧角半径的距离
;;          ALflag: 等于0时不画直线只p1处的画弧 
;;                  其他数值画p1---p2直线也画p1处的圆弧
;;          MRflag: 等于0时只画镜像
;;                  等于1时只画正面
;;                  其他数值镜像和正面都画
;;--------------------------------------------;;
(defun tm:DrawTangent(p0 p1 p2 R d ALflag MRflag / x0 x1 x2 y0 y1 y2 c0 c1 c2 c3)


  (setq x0 (car  p0) x1 (car  p1) x2 (car  p2))
  (setq y0 (cadr p0) y1 (cadr p1) y2 (cadr p2))

  (setq c0 (list 0 0 0))
  (setq c1 (list 0 0 0))
  (setq c2 (list 0 0 0))
  (setq c3 (list 0 0 0))

  (if (and (= x0 x1) (= y1 y2))
      (progn
         (if (and (> y0 y1) (> x1 x2)) ;  2 _| 0
             (progn (setq c0 (list (- x1 R) (+ y1 R) 0))
                    (setq c1 (list    x1    (+ y1 R) 0))
                    (setq c2 (list (- x1 R)    y1    0))
                    (setq c3 (list (+ x2 d)    y1    0))))

         (if (and (> y0 y1) (< x1 x2)) ;  0 |_ 2   reversed
             (progn (setq c0 (list (+ x1 R) (+ y1 R) 0))
                    (setq c1 (list (+ x1 R)    y1    0))
                    (setq c2 (list    x1    (+ y1 R) 0))
                    (setq c3 (list (- x2 d)    y1    0))))

         (if (and (< y0 y1) (> x1 x2)) ;  2 `| 0   reversed
             (progn (setq c0 (list (- x1 R) (- y1 R) 0))
                    (setq c1 (list (- x1 R)    y1    0))
                    (setq c2 (list    x1    (- y1 R) 0))
                    (setq c3 (list (+ x2 d)    y1    0))))

         (if (and (< y0 y1) (< x1 x2)) ;  0 |` 2
             (progn (setq c0 (list (+ x1 R) (- y1 R) 0))
                    (setq c1 (list    x1    (- y1 R) 0))
                    (setq c2 (list (+ x1 R)    y1    0))
                    (setq c3 (list (- x2 d)    y1    0))))
      )
  )

  (if (and (= y0 y1) (= x1 x2))
      (progn
         (if (and (> x0 x1) (< y1 y2)) ;  2 |_ 0
             (progn (setq c0 (list (+ x1 R) (+ y1 R) 0))
                    (setq c1 (list (+ x1 R)    y1    0))
                    (setq c2 (list    x1    (+ y1 R) 0))
                    (setq c3 (list    x1    (- y2 d) 0))))

         (if (and (> x0 x1) (> y1 y2)) ;  2 |` 0   reversed
             (progn (setq c0 (list (+ x1 R) (- y1 R) 0))
                    (setq c1 (list    x1    (- y1 R) 0))
                    (setq c2 (list (+ x1 R)    y1    0))
                    (setq c3 (list    x1    (+ y2 d) 0))))

         (if (and (< x0 x1) (< y1 y2)) ;  0 _| 2   reversed
             (progn (setq c0 (list (- x1 R) (+ y1 R) 0))
                    (setq c1 (list    x1    (+ y1 R) 0))
                    (setq c2 (list (- x1 R)    y1    0))
                    (setq c3 (list    x1    (- y2 d) 0))))

         (if (and (< x0 x1) (> y1 y2)) ;  0 `| 2
             (progn (setq c0 (list (- x1 R) (- y1 R) 0))
                    (setq c1 (list (- x1 R)    y1    0))
                    (setq c2 (list    x1    (- y1 R) 0))
                    (setq c3 (list    x1    (+ y2 d) 0))))
      )
  )

  (tm:DrawArc c0 c2 c1 MRflag)

  (if (= ALflag ARCLINE)
      (progn (if (= (car  c2) (car  c3)) (tm:DrawLine c2 c3 MRflag) )
             (if (= (car  c1) (car  c3)) (tm:DrawLine c1 c3 MRflag) )
             (if (= (cadr c2) (cadr c3)) (tm:DrawLine c2 c3 MRflag) )
             (if (= (cadr c1) (cadr c3)) (tm:DrawLine c1 c3 MRflag) ))
  )
)

;;--------------------------------------------;;
;; 函数：    tm:DrawArc
;;--------------------------------------------;;
(defun tm:DrawArc(p0 p1 p2 MRflag)
  (if (OR (= MRFlag FMBoth) (= MRflag FRONT )) (command "arc" "c" p0 p1 p2))

  (if (OR (= MRflag FMBoth) (= MRflag MIRROR)) (tm:DrawArcMirror p0 p1 p2) )
)
;;--------------------------------------------;;
;; 函数：    tm:DrawArcMirror
;;--------------------------------------------;;
(defun tm:DrawArcMirror(p0 p1 p2)
  (command "arc" "c" (list (* (car p0) -1) (cadr p0) (caddr p0))
                     (list (* (car p2) -1) (cadr p2) (caddr p2))
                     (list (* (car p1) -1) (cadr p1) (caddr p1)))
)
;;--------------------------------------------;;
;; 函数：    tm:DrawLine
;;--------------------------------------------;;
(defun tm:DrawLine(p0 p1 MRflag)

  (if (OR (= MRFlag FMBoth) (= MRflag FRONT )) (command "line" p0 p1 "") )

  (if (OR (= MRflag FMBoth) (= MRflag MIRROR)) (tm:DrawLineMirror p0 p1) )
)
;;--------------------------------------------;;
;; 函数：    tm:DrawLineMirror
;;--------------------------------------------;;
(defun tm:DrawLineMirror(p0 p1)
  (command "line" (list (* (car p0) -1) (cadr p0) (caddr p0))
                  (list (* (car p1) -1) (cadr p1) (caddr p1)) "")
)
;;--------------------------------------------;;
;; 函数：    tm:DrawHole
;;--------------------------------------------;;
(defun tm:DrawHole(p0 r MRflag)
  (if (OR (= MRFlag FMBoth) (= MRflag FRONT )) (command "circle" p0 r) )

  (if (OR (= MRflag FMBoth) (= MRflag MIRROR)) (tm:DrawHoleMirror p0 r) )
)
;;--------------------------------------------;;
;; 函数：    tm:DrawHoleMirror
;;--------------------------------------------;;
(defun tm:DrawHoleMirror(p0 r)
  (command "circle" (list (* (car p0) -1) (cadr p0) (caddr p0)) r)
)

;;--------------------------------------------;;
;; 函数：    tm:AddPos
;;--------------------------------------------;;
;; 说明：    平移一个坐标
;;       第一个为被移动坐标 第二个为移动量
;;--------------------------------------------;;
(defun tm:AddPos(p0 p1 / _x _y _z)
  (setq _x (+ (car p0) (car p1)))
  (setq _y (+ (cadr p0) (cadr p1)))
  (setq _z (+ (caddr p0) (caddr p1)))
  (list _x _y _z)
)
