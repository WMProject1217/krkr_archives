@wait time=200
@env init
@linemode mode=free

*start
; ���I������̓X�L�b�v����
@eval exp=kag.afterskip=false
; ���R�����g�A�E�g���O���ƑI������X�L�b�v�p���Ńe�X�g
;@eval exp=kag.afterskip=true

*fade_default
�P���� type=fade
�I�����͂ǂ��I��ł����Ȃ��ł�

@seladd text=�I�����P target=*fade_each
@seladd text=�I�����Q target=*fade_each
@seladd text=�I�����R target=*fade_each
@selact show type="fade"
@selact hide type="fade"
@select
; �������l���ȗ������ true �ɂȂ�̂Œ���
; �ushow�v �� �ushow=true�v �Ƃ��Ȃ�

*fade_each
�Ԋu�������� type=fade
�������� reverse=true

@seladd text=�I�����P target=*fade_accel
@seladd text=�I�����Q target=*fade_accel
@seladd text=�I�����R target=*fade_accel
@seladd text=�I�����S target=*fade_accel
@selact show type="fade" time=600 waittime=200
@selact hide type="fade" time=600 waittime=200 reverse
@select
; ��reverse ������ƃA�N�V�����̏��Ԃ��t���ɂȂ�܂�

*fade_accel
�����x������ type=fade

@seladd text=�I�����P target=*scroll_default
@seladd text=�I�����Q target=*scroll_default
@seladd text=�I�����R target=*scroll_default
@seladd text=�I�����S target=*scroll_default
@seladd text=�I�����T target=*scroll_default
@selact show type="fade" time=600 waittime=200 accel=0.1
@selact hide type="fade" time=600 waittime=100 accel=-0.1
@select
; ��accel �����ŉ����x���w��ł��܂�

*scroll_default
�P���� type=scroll

@seladd text=�I�����P target=*scroll_each
@seladd text=�I�����Q target=*scroll_each
@selact show type="scroll" from=left
@selact hide type="scroll" from=left
@select

*scroll_each
�Ԋu�������� type=scroll
�������� reverse=true

@seladd text=�I�����P target=*scroll_accel
@seladd text=�I�����Q target=*scroll_accel
@seladd text=�I�����R target=*scroll_accel
@seladd text=�I�����S target=*scroll_accel
@seladd text=�I�����T target=*scroll_accel
@selact show type="scroll" from=right time=600 waittime=100
@selact hide type="scroll" from=right time=600 waittime=200 reverse
@select

*scroll_accel
�����x������ type=scroll
�\������ reverse=true

@seladd text=�I�����P target=*scroll_from
@seladd text=�I�����Q target=*scroll_from
@seladd text=�I�����R target=*scroll_from
@selact show type="scroll" from=right time=800 waittime=200 accel=-0.1 reverse
@selact hide type="scroll" from=right time=800 waittime=200 accel=0.1
@select


*scroll_from
�ʕ����� type=scroll

@seladd text=�I�����P target=*scroll_fromeach
@seladd text=�I�����Q target=*scroll_fromeach
@seladd text=�I�����R target=*scroll_fromeach
@selact show type="scroll" from=top time=400
@selact hide type="scroll" from=bottom time=400
@select

*scroll_fromeach
�Ԋu���������ʕ����� type=scroll

@seladd text=�I�����P target=*each
@seladd text=�I�����Q target=*each
@seladd text=�I�����R target=*each
@selact show type="scroll" from=top time=600 waittime=140
@selact hide type="scroll" from=bottom time=600 waittime=140 reverse
@select

*each
@iscript
	// �A�N�V������`
	tf.showDic = [];
	tf.showDic[0] = %[
		top : %[
			handler : MoveAction,
			start : "@+640", // �I������ �W���̈ʒu�ŏ���������Ă���̂ő��Ύw�肪�g���܂�
			value : "@",
			accel : -1,
			time : 500,
			canskip : true,
		],
		opacity : %[
			handler : MoveAction,
			start : 255, // �\������Ƃ��A�I������ opacity=0 �ŏ���������Ă���̂ŕs�����x���グ��K�v������܂�
			value : 255,
			time : 0,
		],
	];
	tf.showDic[1] = %[
		top : %[ handler:MoveAction, start:"@-640", value:"@", accel:-1, time:500, canskip:true, ],
		opacity : %[ handler:MoveAction, start:255, value:255, time:0, ],
	];
	tf.hideDic = [];
	tf.hideDic[0] = %[
		left : %[ handler:MoveAction, start:"@", value:"@+640", accel:1, time:500, canskip:true, ],
		opacity : %[ handler:MoveAction, start:255, value:0, accel:1, time:500, canskip:true, ],
	];
	tf.hideDic[1] = %[
		left : %[ handler:MoveAction, start:"@", value:"@-640", accel:1, time:500, canskip:true, ],
		opacity : %[ handler:MoveAction, start:255, value:0, accel:1, time:500, anskip:true, ],
	];
@endscript
�ʂɃA�N�V�������w��

@seladd text=�I�����P target=*p_each showaction=tf.showDic[0] hideaction=tf.hideDic[0]
@seladd text=�I�����Q target=*p_each showaction=tf.showDic[1] hideaction=tf.hideDic[1]
@select
; ��showaction, hideaction �����Œ��ڃ{�^�����ƂɃA�N�V�������w��ł��܂�

*p_each
�ꕔ�̑I�����̂݌ʂɃA�N�V�������w��

@seladd text=�I�����P target=*end showaction=tf.showDic[0] 
@seladd text=�I�����Q target=*end hideaction=tf.hideDic[1]
@seladd text=�I�����R target=*end showaction=tf.showDic[1]
@seladd text=�I�����S target=*end hideaction=tf.hideDic[1]
@selact show type=scroll time=500 from=right accel=-1
@selact hide type=scroll time=500 from=right accel=1
@select
; ��[seladd]�^�O�Ŏw�肳��Ȃ����������̂�[selact]�^�O�Ŏw�肳��܂�

*end
�ŏ��ɂ��ǂ�܂�

@next target=*start
