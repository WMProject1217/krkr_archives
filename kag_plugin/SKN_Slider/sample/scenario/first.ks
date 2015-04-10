; SKN_SliderLayer�v���O�C���̃T���v��


; ���v���O�C���Ǎ� ���̑������ݒ�
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
@call storage="SKN_Slider.ks"
@history enabled="false"
@position layer="message0" page="fore" opacity="128" color="0x000000"
@image layer="base" storage="bg"
@playbgm storage="bgm"

; ���X���C�_�[�ݒ�
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
; ���X���C�_�[�̒l������z��
@eval exp="f.slider = [ (int)(kag.bgm.buf1.volume2 / 1000), (int)(kag.se[0].volume2 / 1000), 0, 0, 0,128]"

; ���X���C�_�[�̐�
@setSliderCount sliders="6"

; ���X���C�_�[0�̐ݒ�(�ォ��P�Ԗڂ̃X���C�_) - (BGM���ʒ���)
@setSliderImages slider="0" forebase="base_white" forethumb="note_black"
@setSliderOptions slider="0" page="fore" visible="true" left="100" top="50" changing="20" max="100" min="0" visible="true" mtop="-5" mleft="-3" scale="2" hit="true" cursor="false"
; ���X���C�_�[1�̐ݒ�(�ォ��Q�Ԗڂ̃X���C�_) - (SE���ʒ���)
@setSliderImages slider="1" forebase="base_yellow" forethumb="note_red"
@setSliderOptions slider="1" page="fore" visible="true" left="100" top="100" changing="20" max="100" min="0" visible="true" mtop="-5" mleft="-3" scale="2" hit="true" cursor="true"
; ���X���C�_�[2�̐ݒ�(�ォ��R�Ԗڂ̃X���C�_) - (��)
@setSliderImages slider="2" forebase="base_pink" forethumb="thumb_tomato"
@setSliderOptions slider="2" page="fore" visible="true" left="50" top="180" changing="30" max="255" min="0" visible="true" scale="1" hit="true" cursor="true"
; ���X���C�_�[3�̐ݒ�(�ォ��S�Ԗڂ̃X���C�_) - (��)
@setSliderImages slider="3" forebase="base_lime" forethumb="thumb_lime"
@setSliderOptions slider="3" page="fore" visible="true" left="50" top="230" changing="30" max="255" min="0" visible="true" scale="1" hit="true" cursor="true"
; ���X���C�_�[4�̐ݒ�(�ォ��T�Ԗڂ̃X���C�_) - (��)
@setSliderImages slider="4" forebase="base_aqua" forethumb="thumb_purple"
@setSliderOptions slider="4" page="fore" visible="true" left="50" top="280" changing="30" max="255" min="0" visible="true" scale="1" hit="true" cursor="true"
; ���X���C�_�[5�̐ݒ�(�ォ��U�Ԗڂ̃X���C�_) - (�����x)
@setSliderImages slider="5" forebase="base_gray" forethumb="thumb_gray"
@setSliderOptions slider="5" page="fore" visible="true" left="50" top="330" changing="30" max="255" min="0" visible="true" scale="1" hit="true" cursor="true"


; ���X���C�_���������Ƃ��̏���
[iscript]
	// �X���C�_�̒l���ς�������ɌĂяo�����֐�
	// num(�l���ς�����X���C�_�̔ԍ�), page(�l���ς�����X���C�_�̃y�[�W)��2�̈������Ƃ�܂��B
function myValueChangeHook(num, page) {
	if (!kag.inSleep) { return; } // s�^�O�Ŏ~�܂��Ă��Ȃ������牽�����Ȃ��B
	
	tf.name = "f.slider[" + num + "]";
	skn_slider.getSliderValue(%["slider"=>num, "name"=>tf.name]); // [getSliderValue slider="&num" name="&tf.name"]�Ɠ���
		// �������f.slider�̒l�͏�ɍŐV�̒l�ɂȂ遣
		
	if (num == 0 && page == "fore") { // �X���C�_0�̕\��ʂ̒l���ς�����B
		kag.process("","*bgmSlider");
	} else if (num == 1 && page == "fore") {// �X���C�_1�̕\��ʂ̒l���ς����	
		kag.process("", "*seSlider");
	} else if (2 <= num && num <= 5 && page == "fore") { // �X���C�_2~5�̕\��ʂ̒l���ς�����B
		kag.process("", "*messageSlider");
	}
}
[endscript]
@eval exp="skn_slider.valueChangeHook.add(myValueChangeHook)"
; ��������֐�(myValueChangeHook)��valueChangeHook�ɓo�^��  �i�l���ς�������ɓo�^�����֐����Ă΂��B�j

; ���X���C�_�̒l�������ݒ�
@eval exp="tf.index = 0"
*_loop_setValue
@setSliderValue slider="&tf.index" value="&f.slider[tf.index]"
@eval exp="tf.index += 1"
@jump target="*_loop_setValue" cond="tf.index < skn_slider.sliderCount"
; ��skn_slider.sliderCount�̓X���C�_�̐��ł���

; ���X���C�_�̌��ݒl��\��
@call target="*showValues"

; ���{�^���z�u
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
@call target="*putButton"
@backlay
@trans method=crossfade time=1000
@wt

; ���z�u�I��
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
; �X���C�_�̓��͎�t�J�n
@setSliderEnabled enabled="true"
@s









; ���{�^���������ꂽ�Ƃ��̏���
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
; ���Đ��{�^���������ꂽ�Ƃ��̏���
*volume
@setSliderEnabled enabled="false"
; SE���Đ�
[playse storage="se"][ws]
; �X���C�_�̒l�\���X�V
@cm
@call target="*putButton"
@call target="*showValues"
@setSliderEnabled enabled="true"
@s

; ���X���C�_���������Ƃ��̏���
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
; ��BGM���ʒ����̃X���C�_���������Ƃ��̏���
*bgmSlider
@setSliderEnabled enabled="false"
@bgmopt gvolume="&f.slider[0]"
; �X���C�_�̒l�\���X�V
@cm
@call target="*putButton"
@call target="*showValues"
@setSliderEnabled enabled="true"
@s

; ��SE���ʒ����̃X���C�_���������Ƃ��̏���
*seSlider
@setSliderEnabled enabled="false"
@seopt buf="0" gvolume="&f.slider[1]"
; �X���C�_�̒l�\���X�V
@cm
@call target="*putButton"
@call target="*showValues"
@setSliderEnabled enabled="true"
@s

; �����b�Z�[�W�E�B���h�E�̐For�����x�����̃X���C�_���������Ƃ��̏���
*messageSlider
@setSliderEnabled enabled="false"
@position layer="message0" page="fore" color="&'0x%02x%02x%02x'.sprintf(f.slider[2], f.slider[3], f.slider[4])" opacity="&f.slider[5]"
; �X���C�_�̒l�\���X�V(position�ݒ肷��Ə�����̂�[cm]�K�v�Ȃ�)
@call target="*putButton"
@call target="*showValues"
@setSliderEnabled enabled="true"
@s

		
; ���T�u���[�`��
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P

; ���{�^����z�u����T�u���[�`��
*putButton
@current layer="message0" page="fore"
@locate x="300" y="75"
@button graphic="button_play" target="*volume"
@return

; ���X���C�_�̒l��\������T�u���[�`��
*showValues
@current layer="message0" page="fore"
[nowait]
[locate x="400" y="20"][emb exp="f.slider[0]"]
[locate x="400" y="70"][emb exp="f.slider[1]"]
[locate x="400" y="150"][emb exp="f.slider[2]"]
[locate x="400" y="200"][emb exp="f.slider[3]"]
[locate x="400" y="250"][emb exp="f.slider[4]"]
[locate x="400" y="300"][emb exp="f.slider[5]"]
[endnowait]
@return