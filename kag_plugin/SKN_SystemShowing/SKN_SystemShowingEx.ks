

@iscript
//------------------------------------------------ �f�t�H���g�̐ݒ肱������ ----
function SKN_SystemLayer_Config() {

// ���V�X�e�����C���̐F�ƕs�����x
this.baseColor = 0x0000FF; // �F
this.baseOpacity = 128; // �s�����x

// ���V�X�e�����C���̐�Έʒu
this.absolute = 30000000;

// �� ���E�㉺�}�[�W��
this.marginL = 2; // ���]��
this.marginT = 2; // ��]��
this.marginR = 2; // �E�]��
this.marginB = 2; // ���]��

// �� �����̑傫��
this.fontSize = 16;

// ���V�X�e�����C���̍����ɂ���
// �V�X�e�����C���̍����́u(�����̑傫��) + (��]��) + (���]��)�v�ƂȂ�܂�

// ���V�X�e�����C���̕��ɂ���
// �V�X�e�����C���̕��� �`�悷�镶�����y�щE�]���ƍ��]�� �ɉ����Ď����I�ɒ�������܂��B

// �� �����̏���
this.fontFace = "�l�r �o�S�V�b�N";

// �� �����̐F�ƕs�����x
this.drawColor = 0xFFFFFF; // �F
this.drawOpa = 255; // �s�����x

// �� �A���`�G�C���A�X�����`������邩
// ����ꍇ�� true, ���Ȃ��ꍇ�� false ���w�肵�܂��B
this.drawAA = true;

// �� �e�̕s�����x
// �e�̕s�����x���w�肵�܂��B
// 0���w�肷��Ɖe�͕\������܂���B
this.drawShadowlevel = 96;

// �� �e�̐F
this.drawShadowcolor = 0x000000;

// �� �e�̕�
// �e�̕�(�ڂ�)���w�肵�܂��B
// 0�������Ƃ��V���[�v(�ڂ��Ȃ�)�ŁA�l��傫������Ɖe���ڂ������Ƃ��ł��܂��B
this.drawShadowwidth = 1;

// �� �e�̈ʒu
// �e�̈ʒu���w�肵�܂��B
// �w�肵���l�����A�`�悷�镶�����炸�ꂽ�ʒu�ɕ`�悳��܂��B
// ���̒l���w�肷��ƉE�������A���̒l���w�肷��ƍ�������ɕ`�悳��܂��B
// 0���w�肷��ƕ����̐^���ɕ`�悳��܂��B
this.drawShadowofsx = 2; // x����
this.drawShadowofsy = 2; // y����

// �� �ړ����鎞��
// �V�X�e�����C����\������Ƃ��ɂ����鎞�Ԃ��w�肵�܂�(ms�P��)�B
// 0���w�肷��ƈ�u�ŕ\������(�������͉B����)�܂��B
this.showingTime = 200; // �\������Ƃ��ɂ����鎞��
this.hidingTime = 200; // �B���Ƃ��ɂ����鎞��

// ���\�����鎞��
// �V�X�e�����C����\�����鎞�Ԃ��w�肵�܂�(ms�P��)�B
// �\�����邽�߂̈ړ����I����Ă���A�w�肵�����Ԃ��߂���ƁA�B�����߂̈ړ����n�܂�܂�
this.hideTimerInterval = 1500; // �B���܂ł̎���
}

function SKN_SystemLayerManager_Config() {

// ���V�X�e�����C���̈ʒu
// ��ԏ�̃V�X�e�����C���̕\���ʒu���w�肵�܂��B
this.top = 2;
// ���V�X�e�����C���Ԃ̃}�[�W��
// �ׂ荇���V�X�e�����C���̊Ԃ̕����w�肵�܂��B
// ���̒l���w�肷��ƃV�X�e�����C���͏d�Ȃ荇���ĕ\������܂��B
this.margin = 4;

}
//------------------------------------------------------------ �ݒ肱���܂� ----

	// ��SKN_SystemLayer�N���X �v LinearMover
	// �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P	
class SKN_SystemLayer extends Layer {
	var waiting = true; // �ҋ@��(�\�����ꂸ�B��Ă���)��
	var waitingLeft, waitingTop; // �ҋ@���̈ʒu
	
	var moveObject; // ���ݐi�s���̎����ړ��p�I�u�W�F�N�g(�i�s���Ă��Ȃ��Ƃ���void)
	var hideTimer = new Timer(this, "onHideTimer"); // �B���܂ł̎��Ԃ𑪂�^�C�}�I�u�W�F�N�g
	
	var showing = false; // �\�����Ă���(move���Ă���)�Œ���
	var hiding = false; // �B���Ă���(move���Ă���)�Œ���
	
	var manager; // �Ǘ��I�u�W�F�N�g
	
	function SKN_SystemLayer(win, par, man) {
		super.Layer(win, par);
		
		manager = man;
		(SKN_SystemLayer_Config incontextof this)(); // �ݒ�ǂݍ���
		hideTimer.interval = hideTimerInterval + showingTime;
		
		with (font) { // �t�H���g�̐ݒ�
			.height = fontSize;
			.face = fontFace;
		}
		
		// ���C���̐ݒ�
		height = font.height + marginT + marginB; // ���C���̏c��
		visible = true; // ��ɕ\��(��ʊO�ɉB��邾��)
		enabled = false; // ���b�Z�[�W�͈�؎󂯎��Ȃ�
		hitThreshold = 256;
	}
	function finalize() {
		invalidate moveObject if moveObject !== void;
		invalidate hideTimer if hideTimer !== void;
		super.finalize(...);
	}
	function show(text) {
	 	// �V�X�e�����C����\������Ƃ��ɌĂ�
	 	width = marginT + marginB + font.getTextWidth(text); // ���C���̉���
		fillRect(0, 0, width, height, baseColor + (baseOpacity << 24)); // �x�[�X�̐F��h��
		
		drawText(marginL, marginT, text, drawColor, drawOpa, drawAA, drawShadowlevel, drawShadowcolor, drawShadowwidth, drawShadowofsx, drawShadowofsy); // �����`��
		
		showing = true;
		waiting = false;
		beginAction(showingTime, window.innerWidth-width);
		hideTimer.enabled = true;
	}	
	function onHideTimer() {
		// ���C�����B���Ƃ��ɌĂ΂��
		hideTimer.enabled = false;
		hiding = true;
		beginAction(hidingTime, waitingLeft);
	}
	function beginAction(time, left) {
		with(kag) {
			.stopAction(this);
			.beginAction(this,
				%[
					"time" => time,
					"left" => %[ handler:"MoveAction", value : left ],
				],
				actionFinelFunction, true);
		}
	}
	function actionFinelFunction() {
		// �A�N�V�������I������Ƃ��ɌĂ΂��֐�
		if (showing) {
			showing = false;
		} else if (hiding) {
			waiting = true;
			hiding = false;
		}
	}
}

	// ��SKN_SystemLayerManager�N���X
	// �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
class SKN_SystemLayerManager extends KAGPlugin {
	var systemLayers = [];
	var window; // KAGWindow�I�u�W�F�N�g

	
	function SKN_SystemLayerManager(win) {
		window = win;
		(SKN_SystemLayerManager_Config incontextof this)(); // �ݒ�ǂݍ���
		addSystemLayer(); // �Ƃ肠�����V�X�e�����C���������Ă���
	}
	function finalize() {
		for (var i=0; i< systemLayers.count; ++i) {
			invalidate systemLayers[i];
		}
	}
	function addSystemLayer() {
		// systemLayer��ǉ�, �ǉ�����systemLayer�̔ԍ���Ԃ�
		systemLayers.add( new SKN_SystemLayer(window, window.primaryLayer, this));
		
			// �V�X�e�����C���̏����ݒ�
		var num = systemLayers.count -1;
		with (systemLayers[num]) { // �\���	
			.waitingLeft = window.innerWidth;
			.waitingTop = (.height+margin)*num + top;
			.setPos(.waitingLeft, .waitingTop);
			.name = "�V�X�e�����C��[" + num + "]";
		}
		return num;
	}

	function getSystemLayer() {
		// �ҋ@����systemLayer�̔ԍ��𓾂�
		for (var i = 0; i < systemLayers.count; ++i) {
			if (systemLayers[i].waiting) {
				return i;
			}
		}
		return addSystemLayer(); // �S�đҋ@���łȂ������烌�C���ǉ�
	}

	function showSystemLayer(text) {
		// �V�X�e�����C����\��
		var num = getSystemLayer();
		with (systemLayers[num]) {
			.show(text);
		}
	}
}

kag.addPlugin(global.skn_systemLayer = new SKN_SystemLayerManager(kag));
@endscript


; ���}�N����`
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
@macro name="systemShow"
	@eval exp="skn_systemLayer.showSystemLayer(mp.text)"
@endmacro

@return