@wait time=200
@env init
@linemode mode=free
; EditLayer.tjs ���ꕔ�ύX���Ă܂��B
; �Q�l:http://kasekey.blog101.fc2.com/blog-entry-105.html

@iscript
	// �ϐ��̏���
	tf.test = ["�Ă���", "password", "", "�I�������Ƃ��̐F�ύX", "TEST", "", "", "�F�ύX"];
@endscript

@laycount messages=3

*SHOW
@nowait
	; �������e�X�g
	@current layer=message0 page=fore
	@position visible left=10 top=10 width=620 height=220 marginl=0 margint=0 marginr=0 marginb=0
	�����̃G�f�B�^
	@locate x=300
	@edit exp=tf.test[0] length=300 color=0xFFFF00 bgcolor=0x999999
	�p�X���[�h���̓e�X�g
	@locate x=300
	@edit exp=tf.test[1] length=300 password passwordmark="��"
	placeholder �̃e�X�g
	@locate x=300
	@edit exp=tf.test[2] length=300 placeholder="�Ȃ񂩓��͂��Ă�������"
	�n�C���C�g�̃e�X�g
	@locate x=300
	@edit exp=tf.test[3] length=300 highlightbgcolor=0x00FF00 highlightcolor=0x0000FF caretcolor=0xFF0000
@endnowait

@nowait
	; �c�����e�X�g
	@current layer=message1 page=fore
	@position visible left=10 top=250 width=310 height=220 marginl=0 margint=0 marginr=0 marginb=0 vertical
	�����̃G�f�B�^[r]
	@edit exp=tf.test[4] length=200 color=0xFF00FF bgcolor=0x009999
	�p�X���[�h����[r]
	@edit exp=tf.test[5] length=200 password passwordmark="��"
	placeholder[r]
	@edit exp=tf.test[6] length=200 placeholder="�Ȃ񂩓��͂��Ă�������" placeholdercolor=0x996699
	�n�C���C�g[r]
	@edit exp=tf.test[7] length=200 highlightbgcolor=0xFF0000 highlightcolor=0x00FFFF caretcolor=0x00FF00
	
@endnowait

@nowait
	; ���ʕ\����
	@current layer=message2 page=fore
	@position visible left=330 top=160 width=310 height=320 marginl=0 margint=0 marginr=0 marginb=0
	@button normal=commit target=*COMMIT
	0:[emb exp="tf.test[0]"][r]\
	1:[emb exp="tf.test[1]"][r]\
	2:[emb exp="tf.test[2]"][r]\
	3:[emb exp="tf.test[3]"][r]\
	4:[emb exp="tf.test[4]"][r]\
	5:[emb exp="tf.test[5]"][r]\
	6:[emb exp="tf.test[6]"][r]\
	7:[emb exp="tf.test[7]"]\
@endnowait
@s

*COMMIT
@current layer=message0
@commit
@current layer=message1
@commit
@trace exp=tf.test[0]
@next target=*SHOW