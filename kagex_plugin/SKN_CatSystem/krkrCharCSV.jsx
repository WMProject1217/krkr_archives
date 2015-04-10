// ���ϐ���`
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
// �I�u�W�F�N�g�ւ̎Q��
var docRef = activeDocument;

// �ۑ��I�v�V����
var folderName = 'output';
var saveOpt = new PNGSaveOptions();
saveOpt.interlaced = false;
var folderPath = docRef.path.fsName.toString() + "\\" + folderName;
var folderRef = new Folder(folderPath);
if (!folderRef.exists) { folderRef.create(); }
var csvRef = new File(folderPath + "\\" + "output.csv");;

// CSV�ɏ����o���f�[�^
var keys = [];
var data = [];

// ���֐���`
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
// layRef��savename + ".png"�Ƃ��ĕۑ�
function saveLayer(layRef, savename) {	
	// ��U�ۑ�(�\���Ώۃ��C���������ɂȂ��Ă���͂�)
	var fileRef = new File(folderPath + "\\" + savename + ".png");
	docRef.saveAs(fileRef, saveOpt, true, Extension.LOWERCASE);
	// �摜���J���ăg���~���O
	open(fileRef);
	var bounds = activeDocument.artLayers[0].bounds;
	activeDocument.artLayers[0].translate(-bounds[0],-bounds[1]);
	activeDocument.resizeCanvas(bounds[2]-bounds[0], bounds[3]-bounds[1], AnchorPosition.TOPLEFT);
	activeDocument.close(SaveOptions.SAVECHANGES);
	// �I�t�Z�b�g�Ȃǂ��L�^
	keys.push(savename);
	data[savename] = [];
	data[savename]["offs_x"] = bounds[0].toString().slice(0,-3);
	data[savename]["offs_y"] = bounds[1].toString().slice(0,-3);
	data[savename]["width"] = (bounds[2]-bounds[0]).toString().slice(0,-3);
	data[savename]["height"] = (bounds[3]-bounds[1]).toString().slice(0,-3);
	// ���̃h�L�������g���J��
	activeDocument = docRef;
}

function saveLayers(objRef, basename) {
	var layersRef = objRef.layers;
	for (var i = 0; i < layersRef.length; ++i) {
		var layerName = layersRef[i].name.replace(/\$/g, basename); // "$"��u��
		layersRef[i].visible = true; // �Ώۂ̃��C������U�\��
		if (layersRef[i].typename == "LayerSet") {
			// ���C���Z�b�g�̏���(�ċA)
			if (layerName.charAt(0) == "[" && layerName.charAt(layerName.length-1) == "]") {
				// ���C��������{�t�@�C�����Ȃ炻�̊�{�t�@�C�����ōċA
				saveLayers(layersRef[i], layerName.slice(1, -1));
			} else {
				// �����łȂ���Ό��݂�basename�ōċA
				saveLayers(layersRef[i], basename);
			}
		} else {
			// ���̑��̃��C���̏���
			if (layerName.charAt(0) == "[" && layerName.charAt(layerName.length-1) == "]") {
				// ���C��������{�t�@�C�����Ȃ�basename�X�V
				basename = layerName.slice(1, -1);
			} else if (layerName.charAt(0) == "@") {
				// ���C������@����n�܂��Ă���΂��̃��C����ۑ�
				saveLayer(layersRef[i], layerName.substr(1));
			}
		}
		layersRef[i].visible = false;
	}
}

function hideLayers(objRef) {
	for (var i = 0; i < objRef.layers.length; ++i) {
		if (objRef.layers[i].typename == "LayerSet") { hideLayers(objRef.layers[i]); } // �q���C�����ɉB��
		origVisibles.push(objRef.layers[i].visible);
		objRef.layers[i].visible = false;
	}
}
function restoreVisibles(objRef) {
	for (var i = 0; i < objRef.layers.length; ++i) {
		if (objRef.layers[i].typename == "LayerSet") { restoreVisibles(objRef.layers[i]); }
		objRef.layers[i].visible = origVisibles[restoreVisiblesCount++];
	}
}
// �����s
//�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P�P
var origUnit = preferences.rulerUnits;
preferences.rulerUnits = Units.PIXELS;
var origVisibles = [];
// ���C�������ׂĔ�\���ɂ���
hideLayers(docRef, "");
	
// ���C�����Ƃɕۑ�
saveLayers(docRef);

// CSV���o��
csvRef.open("w");
for (var i = 0; i < keys.length; ++i) {
	var dic = data[keys[i]];
	csvRef.write(keys[i] + ",");
	csvRef.write(dic["offs_x"] + ",");
	csvRef.write(dic["offs_y"] + ",");
	csvRef.write(dic["width"] + ",");
	csvRef.write(dic["height"] + "\n");
}
csvRef.close();

// ���̏�Ԃɖ߂�
var restoreVisiblesCount = 0;
restoreVisibles(docRef); // visible
app.preferences.rulerUnits = origUnit; // ruler

// �Q�Ƃ����
docRef = null;
artLayerRef = null;

alert("���s�I�����܂���");