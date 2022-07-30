;;;ȫ�ֱ���_ET_file_name_, _ET_mode_
(vl-load-com)
(princ "\n�������ET")
(princ " �ı��������ı��ĵ�(*.txt)")
(princ " BY Thinker(ThinkerHua@hotmail.com)")
(princ)
(defun c:ET	(/				 default_file_name
			 information	 err_msg		 file
			 selction		 selction_name	 selction_type
			 selction_data	 txt			 option
			)
	(defun *Error* (msg)
		(if	(or	(= msg "Function cancelled")
				(= msg "quit / exit abort")
			)
			(princ err_msg)
			(progn
				(princ (strcat "\n������Ϣ��" msg))
				(setq *Error* nil)
			)
		)
	)
	(setq default_file_name
			 (strcat (getenv "userprofile")
					 "\\Documents\\exported.txt"
			 )
	)
	(if	(= _ET_file_name_ nil)
		(setq _ET_file_name_ default_file_name)
	)
	(if	(= _ET_mode_ nil)
		(setq _ET_mode_ "A")
	)
	(setq information
			 (strcat
				 "��ǰ������  �����ļ���"
				 _ET_file_name_
				 "  д��ģʽ��"
				 (cond
					 ((= _ET_mode_ "A") "׷��")
					 ((= _ET_mode_ "W") "����")
				 )
			 )
	)
	(princ information)
	(setq selction
			 (ssget_with_keyword
				 "F M"
				 "\nѡȡ���ֻ� [�����ļ�(F)/д��ģʽ(M)] <F>��"
				 '(0 . "TEXT,MTEXT")
			 )
	)
	(if	(= selction nil)
		(progn
			(setq err_msg "\nѡ��Ϊ��!")
			(quit)
		)
	)
;;;	(setq loop T)
;;;	(while (= loop T)
;;;		(initget "F M S")
;;;		(setq option
;;;				 (getkword "\n�����ļ�(F)/д��ģʽ(M)/ѡȡ����(S)<S>��")
;;;		)
;;;		(cond
;;;			((= option "F")
;;;			 (progn
;;;				 (setq
;;;					 _ET_file_name_
;;;						(getfiled "ָ�������ļ�"
;;;								  _ET_file_name_
;;;								  "txt"
;;;								  1
;;;						)
;;;				 )
;;;				 (cond
;;;					 ((= _ET_file_name_ nil)
;;;					  (princ "\nδָ�������ļ���")
;;;					 )
;;;					 (T
;;;					  (princ (strcat "\n��ǰ�����ļ���" _ET_file_name_))
;;;					 )
;;;				 )
;;;			 )
;;;			)
;;;			((= option "M")
;;;			 (progn
;;;				 (initget 1 "A W")
;;;				 (setq _ET_mode_
;;;						  (getkword	(strcat
;;;										"\nд��ģʽ��[׷��(A)/����(W)]<"
;;;										_ET_mode_
;;;										">��"
;;;									)
;;;						  )
;;;				 )
;;;				 (princ (strcat "\n��ǰд��ģʽ��" _ET_mode_))
;;;			 )
;;;			)
;;;			((= option "S")
;;;			 (progn
;;;				 (setq selction (ssget '((0 . "TEXT,MTEXT"))))
;;;				 (setq loop nil)
;;;			 )
;;;			)
;;;		)
;;;	)
	(setq file (open _ET_file_name_ _ET_mode_))
	(if	(= file nil)
		(progn
			(setq err_msg "\n�ļ���ʧ��!")
			(quit)
		)
	)
	(setq i 0)
	(repeat	(sslength selction)
		(setq selction_name (ssname selction i))
		(setq selction_data (entget selction_name))
		(setq selction_type (cdr (assoc 0 selction_data)))
		(if	(or	(= selction_type "TEXT")
				(= selction_type "MTEXT")
			)
			(progn
				(setq txt (cdr (assoc 1 selction_data)))
				(princ txt file)
				(princ "\n" file)
			)
		)
		(setq i (1+ i))
	)
	(close file)
	(princ (strcat "\n��ɣ��������ļ�: " _ET_file_name_))
)

(defun ssget_with_keyword (key_list msg arg / sel)
	(princ msg)
;;;	(setvar 'nomutt 1)
	(if	(= arg nil)
		(setq sel (vl-catch-all-apply 'ssget))
		(setq sel (vl-catch-all-apply 'ssget (list (list arg))))
	)
;;;	(setvar 'nomutt 0)
	(if	(not (vl-catch-all-error-p sel))
		sel
	)
)
