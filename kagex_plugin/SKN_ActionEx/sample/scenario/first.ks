@wait time=500
@env init
@linemode mode=page

*test0
; canskip �p�����[�^�̃e�X�g
@iscript
	// �A�N�V�����̏���
	var actionArray = [
		%[
			opacity : %[
				handler:MoveAction,
				value:0,
				time:500,
			],
		],
		%[
			opacity : %[
				handler:MoveAction,
				value:255,
				time:500,
			],
			canskip:true, // canskip
		],
		%[
			loop : 0,
		],
	];
	function onCompleted() {
		invalidate layer;
		kag.process("","*test1");
	}
	// ���C���̏���
	var layer = new Layer(kag, kag.fore.base);
	layer.colorRect(0, 0, 32, 32, 0xFF0000, 255);
	layer.visible = true;
	// �A�N�V�����J�n
	kag.beginAction(layer, actionArray, onCompleted, false);
@endscript
@nowait
	�X�L�b�v�@�\�̃e�X�g�B���^�[���L�[�A�R���g���[���L�[�A���N���b�N�A�X�y�[�X�L�[�ŃA�N�V�������I�����܂��B[nor]
@endnowait
@s


*test1
; boost �p�����[�^�̃e�X�g

[nowait]
	�u�[�X�g�@�\�̃e�X�g�B���^�[���L�[�A�R���g���[���L�[�A���N���b�N�A�X�y�[�X�L�[�ő�����ł��܂��B[nor]
[endnowait]

@newlay name=�X�^�b�t���[�� file=image ypos=-760
@�X�^�b�t���[�� �����A�N�V����
@wat canskip=false

@nowait
	�A�N�V���������B[nor]
@endnowait
