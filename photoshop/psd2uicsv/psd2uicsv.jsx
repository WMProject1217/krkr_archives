// �X�^�b�N�Ƃ��O���[�o���ɂ����Ă��悩�����c�c���X�����̌��Ȃ̂ŕ��u

// ���ėp�֐�
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
/**
 * �G���[����
 * @param message �G���[���b�Z�[�W
 */
function errorFunc(message) {
	alert(message);
}
/**
 * @param layer ���C��
 * @return layer�����C���Z�b�g�Ȃ�true
 */
function isLayerSet(layer) {
	return layer.typename == "LayerSet";
}

// ���\����ԕ��A�֐�
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
var ___origVisible = [];
var ___visiblesCount = 0;
/**
 * �ċA�I��objRef�ȉ��̃��C�������ׂĔ�\���ɂ���
 * ___origVisible�ɕ\�������L�^
 * @param objRef �h�L�������gor���C���Z�b�g
 */
function storeLayerVisible(objRef) {
	for (var i = 0; i < objRef.layers.length; ++i) {
		if (isLayerSet(objRef.layers[i])) {
			storeLayerVisible(objRef.layers[i]); // �q���C�����ɉB��
		}
		___origVisible.push(objRef.layers[i].visible);
		objRef.layers[i].visible = false;
	}
}
/**
 * �ċA�I��objRef�ȉ��̃��C���̕\����Ԃ�___origVisible�ɏ]���ĕ��A
 * �Ăяo���O��___visiblesCount��0�Ƀ��Z�b�g����K�v����
 * @param objRef �h�L�������gor���C���Z�b�g
 */
function restoreLayerVisible(objRef) {
	for (var i = 0; i < objRef.layers.length; ++i) {
		if (isLayerSet(objRef.layers[i])) { restoreLayerVisible(objRef.layers[i]); }
		objRef.layers[i].visible = ___origVisible[___visiblesCount++];
	}
}

// ���X�^�b�N�L�^�֐�
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
/**
 * �������f���~�^�����肷��
 * @param ch ���肷�镶��
 * @return ch���f���~�^��������true
 */
function isDelimiter(ch) {
	if (INVERSDELIMS[ch]) return true;
	return false;
}
/**
 * �����񂩂�f���~�^��T������
 * @param str �f���~�^��T��������
 * @param start �T���J�n�ʒu
 * @return �T���J�n�ʒu����f���~�^��T���Ĕ��������ʒu�B�f���~�^���Ȃ������ꍇ��str.length�ƈ�v�B
 */
function nextDelimiter(str, start) {
	for (; start != str.length ; ++start) {
		if (isDelimiter(str[start])) { return start; }
	}
	return start;
}
/**
 * �����񂩂�w�肳�ꂽ�����𒊏o���ċL�^
 * @param type �������鑮���̎��
 * @param str �������镶����
 * @param stack �S�̎w�葮���X�^�b�N
 * @param tmpAttr �ꎞ�w�葮��
 * @param all �S�̎w�肩
 * @return �L�^����������������������B�L�^�������Ȃ�������str���̂܂܁B
 */
function saveAttrFromStr(type, str, stack, tmpAttr, all) {
	var delim = DELIMS[type];
	var start = str.indexOf(delim);
	if (start != -1) {
		var end = nextDelimiter(str, start+1);
		var attr = str.substring(start+1, end);
		if (all) { saveAttr2Dic(type, stack[stack.length-1], attr); }
		else     { saveAttr2Dic(type, tmpAttr, attr);               }
		return str.substr(0, start) + str.substr(end);
	}
	return str;
}
/**
 * attr��dic�ɋL�^
 * @param type �L�^���鑮���̎��
 * @param dic �L�^���鎫���z��
 * @param attr �L�^���镶����
 */
function saveAttr2Dic(type, dic, attr) {
	switch (type) {
	case "type":
	case "name":
	case "csvName":
	case "replace":
		dic[type] = attr;
		break;
	case "option": // �I�v�V�����͕����w��\
		dic[type].push(attr);
		break;
	default:
		errorFunc("�s����type�w��(saveAttr2Dic), type:" + type);
	}
}

// ���f�[�^�ǂݏo���֐�
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
/**
 * @param stack �S�̎w�葮���X�^�b�N
 * @return stack�̒��ōł��[���ʒu�ɂ���u��������
 */
function replaceString(stack) {
	for (var i = stack.length-1; i >= 0; --i) {
		if (stack[i].replace != null) return stack[i].replace;
	}
	return "";
}
/**
 * �I�v�V���������݂��邩
 * @param attr �`�F�b�N����I�v�V������
 * @param stack �S�̎w�葮���X�^�b�N
 * @param tmpAttr �ꎞ�w�葮��
 * @return stack�܂���tmpAttr��option��attr���܂܂�Ă�����true
 */
/* not used
function chkOptionAttr(attr, stack, tmpAttr) {
	var arr = tmpAttr["option"];
	for (var i = arr.length-1; i >= 0; --i) { if (arr[i] == attr) return true; }
	for (var i = stack.length-1; i >= 0; --i) {
		arr = stack[i]["option"];
		for (var i = arr.length-1; i >= 0; --i) { if (arr[i] == attr) return true; }
	}
	return false;
}
*/

/**
 * @param attr �`�F�b�N���閼�O
 * @param stack �S�̎w�葮���X�^�b�N
 * @param tmpAttr �ꎞ�w�葮��
 * @return tmpAttr�܂���stack�ɋL�^����Ă���type�̒l
 */
function attr(type, stack, tmpAttr) {
	if (tmpAttr[type] != null) return tmpAttr[type];
	for (var i = stack.length-1; i >= 0; --i) {
		if (stack[i][type] != null) return stack[i][type];
	}
	return "";
}

/**
 * �I�v�V������z��ɓ���鏇�Ԃ͐[���ʒu�ɂ�����̂���B
 * �����[���ł͐�ɏ�����Ă�����̂���B
 * @param stack �S�̎w�葮���X�^�b�N
 * @param tmpAttr �ꎞ�w�葮��
 * @return �S�ẴI�v�V�����������������z��B
 */
function options(stack, tmpAttr) {
	var ret = [];
	var arr = tmpAttr["option"];
	for (var i = 0; i < arr.length; ++i) { ret.push(arr[i]); }
	for (var i = stack.length-1; i >= 0; --i) {
		arr = stack[i]["option"];
		for (var j = 0; j < arr.length; ++j) { ret.push(arr[j]); }
	}
	return ret;
}

// ���摜�ACSV���o�͊֐�
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
/**
 * @param layerRef �o�͂��郌�C��
 * @param stack �S�̎w�葮���X�^�b�N
 * @param tmpAttr �ꎞ�w�葮��
 */
function outputImage(layerRef, stack, tmpAttr) {
	layerRef.visible = true; // �Ώۃ��C������U�\��

	// ������ǂݍ���
	var attrType = attr("type", stack, tmpAttr);
	var attrCsvName = attr("csvName", stack, tmpAttr);
	var attrName = attr("name", stack, tmpAttr);
	var attrOpt = options(stack, tmpAttr).join();
	// ��U�摜���o��
	var imagename =attrCsvName + DELIMS["name"] + attrName + DELIMS["type"] + attrType;
	if (attrOpt != "") imagename += DELIMS["option"] + attrOpt.replace(/,/g, DELIMS["option"]);
	var fileRef = new File(folderPath + "\\" + imagename + ".png");
	docRef.saveAs(fileRef, saveOpt, true, Extension.LOWERCASE);
	// �摜���J���ăg���~���O�A�T�C�Y�𑪂�
	open(fileRef);
	var bounds
	with (activeDocument) {
		bounds = artLayers[0].bounds;
		artLayers[0].translate(-bounds[0],-bounds[1]);
		resizeCanvas(bounds[2]-bounds[0], bounds[3]-bounds[1], AnchorPosition.TOPLEFT);
		close(SaveOptions.SAVECHANGES);
	}
	// noimage�I�v�V���������Ă�����摜�폜
	if (attrOpt.indexOf("noimage") != -1) fileRef.remove();
	
	// file�R�}���h
	if (attrOpt.indexOf("nofile") == -1) {
		csvFile.push([]);
		var dic = csvFile[csvFile.length-1];
		dic.imagename = imagename;
		dic.csvName = attrCsvName;
		dic.name = attrName;
		dic.offs_x = bounds[0];
		dic.offs_y = bounds[1];
		dic.width = bounds[2]-bounds[0];
		dic.height = bounds[3]-bounds[1];
		dic.options = attrOpt;
	}
	
	// type�R�}���h
	if (attrOpt.indexOf("notype") == -1) {
		var dic = csvTypeRef[attrName];
		if (dic == undefined) { // �܂�type��񂪂Ȃ�������摜�T�C�Y���̂܂܋L�^
			csvType.push([]);
			dic = csvTypeRef[attrName] = csvType[csvType.length-1];
			dic.uitype = attrType;
			dic.csvName = attrCsvName;
			dic.name = attrName;
			dic.left = bounds[0];
			dic.top = bounds[1];
			dic.width = bounds[2]-bounds[0];
			dic.height = bounds[3]-bounds[1];
		} else { // type��񂪂�������͈͊g��
			if (dic.left > bounds[0]) {
				var newLeft = bounds[0];
				dic.width += newLeft - dic.left;
				dic.left = newLeft;
			}
			if (dic.top > bounds[1]) {
				var newTop = bounds[1];
				dic.height += newTop - dic.top;
				dic.top = newTop;
			}
			if (dic.width < bounds[2]-bounds[0]) {
				dic.width = bounds[2]-bounds[0];
			}
			if (dic.height < bounds[3]-bounds[1]) {
				dic.height = bounds[3]-bounds[1];
			}
		}
	}
	
	layerRef.visible = false;
}

/**
 * csvType�AcsvFile�AcsvTypeRef�ɏ]����CSV�t�@�C�����o��
 */
 var OPENMODE = "a"; // �ǋL���[�h
function outputCSV() {
	// type�R�}���h�o��
	for (var i = 0; i < csvType.length; ++i) {
		var dic = csvType[i];
		var csvRef = new File(folderPath + "\\" + dic.csvName + ".csv");
		csvRef.open(OPENMODE);
		csvRef.write(
			"type," +
			dic.name + "," +
			dic.uitype + "," +
			dic.left.value + "," + dic.top.value + ",", +
			dic.width.value + "," + dic.height.value + "\n"
		);
		csvRef.close();
	}
	// file�R�}���h�o��
	for (var i = 0; i < csvFile.length; ++i) {
		var dic = csvFile[i];
		var csvRef = new File(folderPath + "\\" + dic.csvName + ".csv");
		csvRef.open(OPENMODE);
		if (csvTypeRef[dic.name] == undefined) {
			errorFunc("type��`���C����������܂���B\nName:" + dic.name + "\nImageName:" + dic.imagename);
		}
		csvRef.write(
			"file," +
			dic.name + "," +
			dic.imagename + "," +
			(dic.offs_x - csvTypeRef[dic.name].left).value + "," + (dic.offs_y - csvTypeRef[dic.name].top).value + "," +
			dic.width.value + "," + dic.height.value
		);
		if (dic.options == "") csvRef.write("\n");
		else csvRef.write("," + dic.options + "\n");
		csvRef.close();
	}
	// ���̑��R�}���h�o��
	for (var i = 0; i < csvCmd.length; ++i) {
		var dic = csvCmd[i];
		var csvRef = new File(folderPath + "\\" + dic.csvName + ".csv");
		csvRef.open(OPENMODE);
		csvRef.write(dic.cmd + "\n");
		csvRef.close();
	}
}
	
// �����C���ċA�֐�
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
/**
 * @param objRef ���C���̐e�i�h�L�������g���� or ���C���Z�b�g
 * @param stack ���C���Z�b�g�̃X�R�[�v����������X�^�b�N
 */
function recursiveFunc(objRef, stack) {
	var layersRef = objRef.layers;

	// ���C���ꖇ���ƂɃ��[�v
	for (var i = 0; i < layersRef.length; ++i) {
		var layerRef = layersRef[i]; // ����Ώۃ��C��
		var layerName = layerRef.name; // ����Ώۃ��C���̃��C����
		var isLayerSetCache = (isLayerSet(layerRef)); // ����Ώۃ��C�������C���Z�b�g��
		var tmpAttr = STACK(); // ���̃��C������̑���
		var doDelimiter = true; // �f���~�^�����߂��邩

		// ���C��������R�����g���폜
		var start = layerName.indexOf(DELIMS["comment"]);
		if (start != -1) layerName = layerName.substr(0, start);

		// ���C���Z�b�g��������X�^�b�N����
		if (isLayerSetCache) stack.push(STACK());

		// �S�̑����w�肩����i�S�̎w��̏ꍇ��tmpAttr�ł͂Ȃ�stack�Ƀf�[�^������
		// ���C���Z�b�g�̏ꍇ�͖ⓚ���p�őS�̎w��
		var all = false;
		if (layerName[0] == DELIMS["allBegin"] && layerName[layerName.length-1] == DELIMS["allEnd"]) {
			all = true;
			layerName = layerName.slice(1, -1);
		} else if (isLayerSetCache) {
			all = true;
		}

		//  ������u��
        {
			// �u���Ώە��� $ �̒u��
			if (layerName.indexOf(DELIMS["rep"]) != -1) {
				layerName = layerName.replace(/\$/g, replaceString(stack));
			}
			// CSV�t�@�C�����u�� \0
			if (layerName.indexOf("\\0")!= -1) layerName = layerName.replace(/\\0/g, attr("csvName", stack, tmpAttr));
			// �ŗL���u�� \1
			if (layerName.indexOf("\\1")!= -1) layerName = layerName.replace(/\\1/g, attr("name", stack, tmpAttr));
			// ���i�^�C�v�u�� \2
			if (layerName.indexOf("\\2")!= -1) layerName = layerName.replace(/\\2/g, attr("type", stack, tmpAttr));		 
			// �I�v�V�������u�� \3
			if (layerName.indexOf("\\3")!= -1) layerName = layerName.replace(/\\3/g, options(stack, tmpAttr).join(DELIMS["option"]));

			// �u��������w��
			if (layerName[0] == DELIMS["repBegin"] && layerName[layerName.length-1] == DELIMS["repEnd"] ) {
				saveAttr2Dic("replace", stack[stack.length-1], layerName.slice(1,-1));
				doDelimiter = false;
			}
		}
	
		// IGNORE �͖���
		if (isLayerSetCache && layerName == "IGNORE") {
			continue;
		}
	
		// �f�~���^�R�}���h
		if (doDelimiter) {			
			// �I�v�V�����������L�^
			for (;;) { // �I�v�V�����͕������邩������Ȃ�
				if (layerName.indexOf(DELIMS["option"]) != -1) {
					layerName = saveAttrFromStr("option", layerName, stack, tmpAttr, all);
				} else { break; }
			}
			// �ŗL���������L�^
			layerName = saveAttrFromStr("name", layerName, stack, tmpAttr, all);
			// ���i�^�C�v�������L�^
			layerName = saveAttrFromStr("type", layerName, stack, tmpAttr, all);
			// CSV�t�@�C�������L�^
			layerName = saveAttrFromStr("csvName", layerName, stack, tmpAttr, all);

			// �o�͎w�肪����Ă���Ή摜�o��,���W���L�^
			if (layerName.indexOf(DELIMS["out"]) != -1) {
				if (isLayerSetCache) errorFunc("���C���Z�b�g�͉摜�o�͂ł��܂���B");
				outputImage(layerRef, stack, tmpAttr);
			}
			// �R�}���h�w�肪����Ă���΋L�^
			if (layerName.indexOf(DELIMS["rawCmd"]) != -1) {
					csvCmd.push({ cmd:layerName.substr(layerName.indexOf(DELIMS["rawCmd"])+1), csvName:attr("csvName", stack, tmpAttr) });
			}
		}

		// ���C���Z�b�g�Ȃ�ċA�I�ɏ���
		if (isLayerSetCache) {
			layerRef.visible = true;
			recursiveFunc(layerRef, stack);
			stack.pop();
			layerRef.visible = false;
		}
	}
}

// ���萔��`
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
// �f���~�^
var DELIMS = {
	option:";",
	type:"&",
	name:"@",
	csvName:"!",
	rawCmd:"<",
	comment:"/",
	rep:"$",
	repBegin:"[",
	repEnd:"]",
	allBegin:"(",
	allEnd:")",
	out:"*"
};
var INVERSDELIMS = {};
for (var i in DELIMS) { INVERSDELIMS[DELIMS[i]] = true;}
/**
 * �I�v�V�����̂ݕ����w�肠��
 * @return �X�^�b�N�̃e���v���[�g�ƂȂ�z��
 */
function STACK() { return { option:[], type:null, name:null, csvName:null, replace:null }; }


// ���ϐ���`
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
// csv�ւ̏o��
var csvType = [];
var csvFile = [];
var csvCmd = [];
var csvTypeRef = [];

// �I�u�W�F�N�g�ւ̎Q��
var docRef = activeDocument;

// �ۑ��I�v�V����
var saveOpt = new PNGSaveOptions();
saveOpt.interlaced = false;
var folderName = 'output';
var folderPath = docRef.path.fsName.toString() + "\\" + folderName;
var folderRef = new Folder(folderPath);
if (!folderRef.exists) { folderRef.create(); }

// �����s
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
// �s�N�Z���P��
var origUnit = preferences.rulerUnits;
preferences.rulerUnits = Units.PIXELS;

// ���C�������ׂĔ�\���ɂ���
storeLayerVisible(docRef, "");
	
// ���C�����ċA�I�ɏ���
recursiveFunc(docRef, [STACK()]);

// CSV�o��
try {
	outputCSV();
} catch (e) {
	alert(e + "\n\n�G���[���������܂����B\n���̏�Ԃɕ��A���܂��B"); // ���s�������ԕ��A��
}
// ��ԕ��A
___visiblesCount = 0; // restoreLayerVisible�Ŏg�p
restoreLayerVisible(docRef);
app.preferences.rulerUnits = origUnit;

// �Q�Ƃ����
docRef = null;
artLayerRef = null;

alert("���s�I�����܂����B");
