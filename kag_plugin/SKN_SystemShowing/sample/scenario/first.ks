; SKN_SystemShowing�v���O�C���̃T���v��

; ���v���O�C���Ǎ� ���̑������ݒ�
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
@call storage="SKN_SystemShowing.ks"

; �����\�������b�Z�[�W���C���y�єw�i�̐ݒ�
@history enabled="false"
@position layer="message0" page="fore" opacity="128" color="0x000000"
@image layer="base" storage="bg"




; ���T���v��
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
@systemShow text="�T���v���J�n"


@eval exp="tf.bgimage = true"
;���w�i�摜���\������Ă��邩

; �X�^�[�g��ʂɖ߂邾���̃}�N��
@macro name="�߂�"
	@jump target="*�X�^�[�g"
@endmacro


;���X�^�[�g���
*�X�^�[�g
[nowait]
	[link target="*���x���`"]�����N�`[endlink]
	[r]
	[link target="*���x���a"]�����N�a[endlink]
	[r]
	[link target="*���x���b"]�����N�b[endlink]
	[r]
	[link target="*�g�����W�V����"]�g�����W�V����[endlink]
	[r]
	[link target="*�X�N���[��"]�X�N���[���g�����W�V����(�s�����)[endlink]
[endnowait]
@s


;�������N�`�������ꂽ�Ƃ�
*���x���`
@cm
@systemShow text="�����N�`���I������܂���"
@�߂�

;�������N�a�������ꂽ�Ƃ�
*���x���a
@cm
@systemShow text="�����N�a���I������܂���"
@�߂�

;�������N�b�������ꂽ�Ƃ�
*���x���b
@cm
@systemShow text="�����N�b���I������܂���"
@systemShow text="�����ɂ����ł��\�����邱�Ƃ��ł��܂�"
@systemShow text="��������w�肷�邾���ł��Ƃ͏���ɕ\������܂�"
@�߂�


;���g�����W�V�����������ꂽ�Ƃ�
*�g�����W�V����
@cm

@backlay

; �w�i�摜���\������Ă��������
; �w�i�摜���\������Ă��Ȃ�������\��
@if exp="tf.bgimage"
	@freeimage layer="base" page="back"
	@eval exp="tf.bgimage = false"
@else
	@image layer="base" page="back" storage="bg"
	@eval exp="tf.bgimage = true"
@endif

; �g�����W�V�����ŕ\��
@systemShow text="�g�����W�V�����e�X�g�J�n"
@trans method="crossfade" time="1000"
@wt
@systemShow text="�g�����W�V�����e�X�g�I��"

@�߂�

;���X�N���[���g�����W�V�����������ꂽ�Ƃ�
*�X�N���[��
@cm

@backlay

; �w�i�摜���\������Ă��������
; �w�i�摜���\������Ă��Ȃ�������\��
@if exp="tf.bgimage"
	@freeimage layer="base" page="back"
	@eval exp="tf.bgimage = false"
@else
	@image layer="base" page="back" storage="bg"
	@eval exp="tf.bgimage = true"
@endif


; �g�����W�V�����ŕ\��
@systemShow text="�X�N���[���g�����W�V����"
@systemShow text="KAG�łł̓V�X�e�����C�����g�����W�V��������Ă��܂��܂��B"
@trans method="scroll" from="bottom" time="1000"
@wt
@systemShow text="�g�����W�V�����e�X�g�I��"

@�߂�