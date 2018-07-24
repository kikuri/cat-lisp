;;; main.lisp
(in-package :cl-user)
(defpackage :cl-cat
  (:use cl)
  (:export :cat))  ; 今回作成する関数(まだない)をパッケージ外部に公開
(in-package :cl-cat)

(defun cat (input-stream output-stream)
  (loop
     for line = (read-line input-stream nil :eof)
     until (eq line :eof)
     do (write-line line output-stream)))

#|-*- mode:lisp -*-|#
#|
exec ros -Q -- $0 "$@"
|#
(progn ;;init forms
  (ros:ensure-asdf)
  #+quicklisp (ql:quickload '(:cl-cat) :silent t)  ; cl-catをロード
  )

(defpackage :ros.script.ls.3720612639
  (:use :cl))
(in-package :ros.script.ls.3720612639)

(defun main (&rest argv)  ; roswellスクリプトのエントリポイント
  (declare (ignorable argv))
  (if (>= (length argv) 1)   ; 引数があるとき
      (with-open-file (in (first argv))  ; 一つめの引数をファイル名として入力ストリームを開き
        ; 入力を開いたファイル、出力を標準出力ストリームにしてcatする
        (cl-cat:cat in *standard-output*))
      ; 引数がないので、標準入力と標準出力を指定してcatする
      (cl-cat:cat *standard-input* *standard-output*))) ; 
;;; vim: set ft=lisp lisp:
