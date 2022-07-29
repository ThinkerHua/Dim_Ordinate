(defun c:ET	(/				default_file_name
			 file_name		mode		   information
			 file			selction	   selction_name
			 selction_type	selction_data  txt
			 option
			)
	(setq default_file_name
			 (strcat (getenv "userprofile")
					 "\\Documents\\exported.txt"
			 )
	)
	(if	(= file_name nil)
		(setq file_name default_file_name)
	)
	(if	(= mode nil)
		(setq mode "A")
	)
	(setq information
			 (strcat
				 "******���ߣ�Thinker(ThinkerHua@hotmail.com)******"
				 "\n�����ļ���"
				 file_name
				 "\nд��ģʽ��"
				 (cond
					 ((= mode "A") "׷��")
					 ((= mode "W") "����")
				 )
			 )
	)
	(princ information)
	(setq loop T)
	(while (= loop T)
		(initget "F M S")
		(setq option
				 (getkword "\n�����ļ�(F)/д��ģʽ(M)/ѡȡ����(S)<S>��")
		)
		(cond
			((= option "F")
			 (progn
				 (setq
					 file_name (getfiled "ָ�������ļ�"
										 file_name
										 "txt"
										 1
							   )
				 )
				 (cond
					 ((= file_name nil)
					  (princ "\nδָ�������ļ���")
					 )
					 (T (princ (strcat "\n��ǰ�����ļ���" file_name)))
				 )
			 )
			)
			((= option "M")
			 (progn
				 (initget 1 "A W")
				 (setq mode
						  (getkword	(strcat
										"\nд��ģʽ��[׷��(A)/����(W)]<"
										mode
										">��"
									)
						  )
				 )
				 (princ (strcat "\n��ǰд��ģʽ��" mode))
			 )
			)
			((= option "S")
			 (progn
				 (setq selction (ssget '((0 . "TEXT,MTEXT"))))
				 (setq loop nil)
			 )
			)
		)
	)
	(setq file (open file_name mode))
	(if	(= file nil)
		(princ "\n�ļ���ʧ��!")
		(progn
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
			(princ (strcat "\n��ɣ��������ļ�: " file_name))
		)
	)
	(prin1)
)