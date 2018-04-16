

(defun c:testtrim ()

  (setq om (getvar "osmode"))

  (command "circle" "0,0" 40)
  (command "line" "50,11" "31,11" "31.-11" "50,-11" ""£©
  (command "zoom" "e")
  (command "trim" "All" "" "40,0" "50,11" "50,-11" "")

  (setvar "osmode" om)

)
