; ��񂵂��ǂݍ��܂Ȃ�
[if exp="tf.SKN_Slider_GUARD"]
	@return
[endif]
@eval exp="tf.SKN_Slider_GUARD = true"


@iscript
// �{�̓Ǎ�
Scripts.evalStorage("SKN_SliderLayer.tjs");

	// ��SKN_Slider��KAG�g�ݍ��ݗp�N���X
	// �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
class SKN_SliderForKAG extends KAGPlugin {
	var window;	// KAGWindow�I�u�W�F�N�g
	var sliders = [];	// �X���C�_�Ǘ��I�u�W�F�N�g
	var sliderCount = 0;	// �I�u�W�F�N�g�̐�
	var fore = %["maxValues" => [], "minValues" => [], "scale" => [], "curValues" => []];
	var back = %["maxValues" => [], "minValues" => [], "scale" => [], "curValues" => []];
	/****** fore, back�̒��g ******
		maxValues = [];	// �X���C�_�̍ő�l
		minValues = [];	// �X���C�_�̍ŏ��l
		scale = [];	// 1�ڐ���̕�(px�P��)
		curValues = []; // �ۑ��A�Ǎ�����p
	*/
	var valueChangeHook = []; // �l���ς�������ɌĂяo�����
	
	// ------------------------------------------------------------------------ �}�l�[�W���Ǘ��֐�
	function SKN_SliderForKAG(win) { this.window = win; }
	function finalize() { for (var i = 0; i < sliderCount; ++i) { invalidate sliders[i]; } }
	
	function addSlider(num) {
		// �X���C�_�𐶐�
		sliders[num] = new SKN_Slider(window);
		fore.maxValues[num] = back.maxValues[num] = 100;
		fore.minValues[num] = back.minValues[num] = 0;
		fore.curValues[num] = back.curValues[num] = 0;
		fore.scale[num] = back.scale[num] = 1;
		sliders[num].fore.baseLayer.name="�X���C�_\[" + num +"\]�\ �x�[�X";
		sliders[num].fore.thumbLayer.name="�X���C�_\[" + num +"\]�\ �܂�";
		sliders[num].back.baseLayer.name="�X���C�_\[" + num +"\]�� �x�[�X";
		sliders[num].back.thumbLayer.name="�X���C�_\[" + num +"\]�� �܂�";
		
		// sliders[num].onValueChanged�I�[�o�[���[�h
		sliders[num].NUMBER = num;
		sliders[num].OWNER = this;
		sliders[num].onValueChanged = function(page) {
			OWNER.onValueChange(NUMBER, page);
		} incontextof sliders[num];
	}
	function eraseSlider(num) {
		// �X���C�_����
		invalidate sliders[num];
		delete fore.maxValues[num];
		delete back.maxValues[num];
		delete fore.minValues[num];
		delete back.minValues[num];
		delete fore.scale[num];
		delete back.scale[num];
		delete fore.curValues[num];
		delete back.curValues[num];
	}
	function getSliderPageFromElm(elm) {
		if (elm.page == "back") {
			return sliders[+elm.slider].back;
		}
		return sliders[+elm.slider].fore;
	}
	function getThisPageFromElm(elm) {
		if (elm.page == "back") {
			return this.back;
		}
		return this.fore;
	}
	function clearSliderImages(page, num) {
		// �w�肳�ꂽ�X���C�_�̉摜�����N���A
		// page == void�̂Ƃ��͗��ʃN���A
		if(num !== void) { sliders[num].clearImages(page); }
		for (var i = 0; i < sliderCount; ++i) {
			sliders[i].clearImages(page);
		}
	}
	
	// ------------------------------------------------------------------------ �}�N���p�֐�
	function setSliderCount(elm) {
		// �X���C�_�̐���elm.sliders�ɐݒ�
		if(sliderCount > elm.sliders) {
			for(var i = elm.sliders; i < sliderCount; ++i) {
				eraseSlider(i);
			}
		}
		else if(sliderCount < elm.sliders) {
			// ���C����������
			for(var i = sliderCount; i < elm.sliders; ++i) {
				addSlider(i);
			}
		}
		sliderCount = elm.sliders;
	}
	function setSliderImages(elm) {
		// �X���C�_�̉摜��ݒ�
		sliders[+elm.slider].setImages(elm);
	}	
	function setSliderOptions(elm) {
		// �X���C�_�̑�����ݒ�		
		var page = getSliderPageFromElm(elm);
		var t_page = getThisPageFromElm(elm);
			// ���̃N���X�ŊǗ����Ă���f�[�^
		with(t_page) {
			.scale[+elm.slider] = +elm.scale if elm.scale !== void;
			.maxValues[+elm.slider] = +elm.max if elm.max !== void;
			.minValues[+elm.slider] = +elm.min if elm.min !== void;
		}
			// �X���C�_�̊֐��ɓn������(void��n���ƕύX����Ȃ�)
		var top = (elm.top === void ? void : +elm.top);
		var left = (elm.left === void ? void : +elm.left);
		var mleft = (elm.mleft === void ? void : +elm.mleft);
		var mright = t_page.scale[+elm.slider] * (t_page.maxValues[+elm.slider] - t_page.minValues[+elm.slider] + 1) + mleft;
		var mtop = (elm.mtop === void ? void : +elm.mtop);
			// �X���C�_�̊֐��Ăяo��
		with(sliders[+elm.slider]) {
			.setThumbRange(page, mleft, mright, mtop);
			.setPosition(page, top, left, mtop) if (top !== void || left !== void || mtop !== void);
			.setHitThreshold(page, (elm.hit ? 0 : 16)) if elm.hit !== void;
			.setChangingValue(page, +elm.changing) if elm.changing !== void;
			.setEnabled(page, +elm.enabled) if elm.enabled !== void;
			.setCursorChanging(page, +elm.curchanging) if elm.curchanging !== void;
			.setCursorEnabled(page, +elm.cursor) if elm.cursor !== void;
			.setVisible(page, +elm.visible) if elm.visible !== void;
		}
	}
	function setSliderEnabled(elm) {
		// �S�ẴX���C�_��enabled���ꊇ�ŕύX
		elm.enabled = +elm.enabled;
		for (var i = 0; i < sliderCount; ++i) {
			with(sliders[i]) {
				.setEnabled(.fore, elm.enabled);
				.setEnabled(.back, elm.enabled);
			}
		}
	}		
	function setSliderValue(elm) {
		// �X���C�_�̒l��ݒ�
		getSliderValue(%["slider"=>elm.slider, "page"=>elm.page, "name"=>"tf.skn_old_value"]);
		if (tf.skn_old_value != elm.value) {	// �ύX�O�ƒl���قȂ��Ă�����
			var page = getSliderPageFromElm(elm);
			var t_page = getThisPageFromElm(elm);
			elm.value = (int)(elm.value * t_page.scale[+elm.slider]);
			sliders[+elm.slider].setValue(page, elm.value);
		}
	}	
	function getSliderValue(elm) {
		// �X���C�_�̒l��Ԃ�
		var value = sliders[+elm.slider].getCurrentValue(getSliderPageFromElm(elm));
		var r;
		with (getThisPageFromElm(elm)) {
			r = (int)(value / .scale[+elm.slider]);
			if (r > .maxValues[+elm.slider]) { r = .maxValues[+elm.slider]; }
			if (r < .minValues[+elm.slider]) { r = .minValues[+elm.slider]; }
		}
		Scripts.eval('(' + elm.name + ') = ' + r);
	}	
	function getSliderValues(elm) {
		// �S�ẴX���C�_�̒l���ꊇ�œ���
		if (sliderCount == 0) {
			Debug.message("�X���C�_�����݂��Ȃ��Ƃ���getSliderValues���Ă΂�܂���");
			return;
		}
		var page = getSliderPageFromElm(elm);
		for (var i = 0; i < sliderCount; ++i) {
			getSliderValue(%["slider" => i, "page" => elm.page, "name" => elm.name + '[' + i + ']' ]);
		}
	}
	
	// ------------------------------------------------------------------------ �Z�[�u/���[�h�Ή�
	function onStore(f, elm) {
		// �x��ۑ�����ۂɌĂ΂��
		f.skn_slider_store = %[];
		f.skn_slider_store["fore"] = %[];
		f.skn_slider_store["back"] = %[];
		setCurValues() if this.sliderCount != 0;
		(Dictionary.assignStruct incontextof f.skn_slider_store["fore"])(this.fore);
		(Dictionary.assignStruct incontextof f.skn_slider_store["back"])(this.back);
		f.skn_slider_store["sliderCount"] = this.sliderCount;		
		f.skn_slider_store["sliders"] = [];
		for (var i = 0; i < this.sliderCount; ++i) {
			with (this.sliders[i]) {
				f.skn_slider_store["sliders"][i] = %["fore" => %[], "back" => %[]];
				(Dictionary.assignStruct incontextof f.skn_slider_store["sliders"][i].fore)(.fore);
				(Dictionary.assignStruct incontextof f.skn_slider_store["sliders"][i].back)(.back);
			}
		}
	}	
	function onRestore(f, clear, elm) {
		// �x��ǂݏo���Ƃ��ɌĂ΂��		
		if (elm !== void && elm.backlay) {	// tempload���� backlay == true�̂Ƃ�(�\��ʂ̏��𗠉�ʂɓǂݍ���)
			var sliders = (f.skn_slider_store['sliderCount'] > sliderCount ? f.skn_slider_store['sliderCount'] : sliderCount);
			setSliderCount(%["sliders" => sliders]);	// �I�u�W�F�N�g�̐���ݒ�
			for (var i = 0; i < this.sliderCount; ++i) {
				with(f.skn_slider_store["sliders"][i]) {
					if (.fore.baseImage !== void) { clearSliderImages("back", i); }
					setSliderImages(%["slider" => i, "backbase" => .fore.baseImage, "backthumb" => .fore.thumbImage]);
					restoreSlider(i, "back", .fore, f.skn_slider_store.fore);
				}
			}
		}
		else {	// �ʏ�̃��[�h
			setSliderCount(%["sliders" => f.skn_slider_store['sliderCount']]);	// �I�u�W�F�N�g����
			for (var i = 0; i < this.sliderCount; ++i) {
				with (f.skn_slider_store["sliders"][i]) {
					if (.fore.baseImage !== void) { clearSliderImages("fore", i); }
					if (.back.baseImage !== void) { clearSliderImages("back", i); }
					setSliderImages(%["slider" => i, "forebase" => .fore.baseImage, "backbase" => .back.baseImage, "forethumb" => .fore.thumbImage, "backthumb" => .back.thumbImage]); // �摜�w��
					restoreSlider(i, "fore", .fore, f.skn_slider_store.fore); // �\���
					restoreSlider(i, "back", .back, f.skn_slider_store.back); // �����
				}
			}
			
		}
	}
	function restoreSlider(slider, page = "fore", sliderDic, thisDic) {
		// �w�肳�ꂽ�X���C�_�������ɏ]���ĕ���
		// slider : 0,1,2,...
		// page : "fore" or "back"
		// sldierDic : f.skn_slider_store["sliders"][i].fore��������f.skn_slider_store["sliders"][i].back�̃I�u�W�F�N�g
		// thisDic : f.skn_slider_store.fore��������f.skn_slider_store.back
		setSliderOptions(%[
			"slider" => slider, "page" => page,
			"top" => sliderDic.top, "left" => sliderDic.left, "mtop" => sliderDic.mtop, "mleft" => sliderDic.mleft,
			"max" => thisDic.maxValues[slider], "min" => thisDic.minValues[slider], "scale" => thisDic.scale[slider],
			"changing" => sliderDic.changingValue, "curchanging" => sliderDic.cursorChanging, "hit" => !sliderDic.hitThreshold,
			"enabled" => sliderDic.enabled, "cursor" => sliderDic.cursorEnabled,
			"visible" => sliderDic.visible
		]);
		setSliderValue(%["slider" => slider, "page" => page, "value" => thisDic.curValues[slider]]);
	}
	function setCurValues(page = "both") {
		// curValues���X�V
		getSliderValues(%["page" => "fore", "name" => "skn_slider.fore.curValues"]) if page !== "back";
		getSliderValues(%["page" => "back", "name" => "skn_slider.back.curValues"]) if page !== "fore";
	}
	// ------------------------------------------------------------------------ �g�����W�V�����Ή�
	function onExchangeForeBack() {
		// �g�����W�V�������ɌĂяo�����
		for (var i = 0; i < sliderCount; ++i) {
			sliders[i].onExchangeForeBack();
		}
	}
	function onCopyLayer(toback) {
		// backlay �^�O / forelay �^�O�����ׂẴ��C���ɑ΂��Ď��s����鎞��΂��
		if (sliderCount == 0) { return; }
		if (toback) {	// �\��ʂ𗠉�ʂɃR�s�[
			setCurValues("fore");
			clearSliderImages("back");
			for (var i = 0; i < this.sliderCount; ++i) {
				with (sliders[i]) {
					setSliderImages(%["slider" => i, "backbase" => .fore.baseImage, "backthumb" => .fore.thumbImage]); // �摜�w��
					restoreSlider(i, "back", .fore, this.fore);
				}
			}
		} else {	// ����ʂ�\��ʂɃR�s�[
			setCurValues("back");
			clearSliderImages("fore");
			for (var i = 0; i < this.sliderCount; ++i) {
				with (sliders[i]) {
					setSliderImages(%["slider" => i, "forebase" => .back.baseImage, "forethumb" => .back.thumbImage]); // �摜�w��
					restoreSlider(i, "fore", .back, this.back);
				}
			}
		}
	}
	
	// ------------------------------------------------------------------------ �g���p�֐�
	function onValueChange(num, page) {
		// �X���C�_�̒l���ς�����Ƃ��ɌĂ΂��B
		// num : �l���ς�����X���C�_�̔ԍ�
		// page : �l���ς�����y�[�W("fore" ���� "back")
		for (var i = 0; i < valueChangeHook.count; ++i) {
			valueChangeHook[i](num, page);
		}
	}
}

kag.addPlugin(global.skn_slider = new SKN_SliderForKAG(kag));
@endscript

; ���}�N����`
; �P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
@macro name = "setSliderCount"
@eval exp = "skn_slider.setSliderCount(mp)"
@endmacro
@macro name = "setSliderImages"
@eval exp="skn_slider.setSliderImages(mp)"
@endmacro
@macro name = "setSliderOptions"
@eval exp="skn_slider.setSliderOptions(mp)"
@endmacro
@macro name = "setSliderEnabled"
@eval exp="skn_slider.setSliderEnabled(mp)"
@endmacro
@macro name = "setSliderValue"
@eval exp="skn_slider.setSliderValue(mp)"
@endmacro
@macro name = "getSliderValue"
@eval exp="skn_slider.getSliderValue(mp)"
@endmacro
@macro name = "getSliderValues"
@eval exp="skn_slider.getSliderValues(mp)"
@endmacro

@return