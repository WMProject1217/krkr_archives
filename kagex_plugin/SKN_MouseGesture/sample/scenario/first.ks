@env init

@position layer=message1 top=400 visible
@linemode mode=free
@current layer=message0

;���E�N���b�N����Ƌ����\�ɂȂ�܂���
@rclick call storage=first.ks target=*RCLICK

;���}�E�X�W�F�X�`���o�^
; ���uenabled�v�́uenabled=true�v�Ƃ��Ȃ�
@setgesture gesture=2 enabled exp="kag.onExitMenuItemClick()"
@setgesture gesture=4 enabled exp="kag.onShowHistoryMenuItemClick()"
@setgesture gesture=8 enabled exp="kag.onAutoModeMenuItemClick()"
@setgesture gesture=6 enabled exp="kag.onSkipToNextStopMenuItemClick()"
@setgesture gesture=2684 enabled exp="Debug.console.visible = !Debug.console.visible"
@setgesture gesture=86 enabled call target=*MG_UR storage=first.ks

;���}�E�X�W�F�X�`����t�J�n
@mousegesture enabled limit=5



;���ȉ��T���v���p�e�L�X�g�̌J��Ԃ�
*START

�}�E�X�W�F�X�`���̃T���v���ł�

�u���v�ŏI���m�F
�u���v�Ŋ��ǃX�L�b�v
�u���v�ŃI�[�g���[�h
�u���v�ŗ���\��
�u���������v�ŃR���\�[���\��
�u�����v�Ń}�E�X�W�F�X�`���T�u���[�`��
�E�N���b�N�ŉE�N���b�N�T�u���[�`���ł��B

�ŏ��ɃW�����v���܂��B

@next target=*START


*RCLICK
; �E�N���b�N�T�u���[�`��
	@call target=*routine_start
	@nowait
		�E�N���b�N���[�`���ɓ���܂����B[r]
		�N���b�N�Ŗ߂�܂��B
	@endnowait
	[p][er]

	@call target=*routine_end
@return

*MG_UR
; �}�E�X�W�F�X�`���T�u���[�`��
	@call target=*routine_start

	@nowait
		�}�E�X�W�F�X�`���T�u���[�`���ɓ���܂����B[r]
		�N���b�N�Ŗ߂�܂��B
	@endnowait
	[p][er]

	@call target=*routine_end
@return


*routine_start
; �T�u���[�`���̊J�n����
	@linemode mode=none
	@current layer=message1
	@rclick enabled=false
	;���}�E�X�W�F�X�`����t��~
	@mousegesture enabled=false
@return

*routine_end
; �T�u���[�`���̏I������
	@linemode mode=free
	@current layer=message0
	@rclick enabled
	;���}�E�X�W�F�X�`����t�ĊJ
	@mousegesture enabled
@return
