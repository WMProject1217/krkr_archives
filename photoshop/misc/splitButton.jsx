
#target photoshop

// �I�u�W�F�N�g�ւ̎Q��
var orgDocRef = activeDocument;
var docRef = activeDocument.duplicate();

const saveOpt = new PNGSaveOptions();
saveOpt.interlaced = false;

// �摜���ݒ�
var width = docRef.width.value/3;
docRef.resizeCanvas(width, docRef.height.value, AnchorPosition.TOPLEFT);
var file = new File(orgDocRef.path + "/" + orgDocRef.name+ "_1.png");
docRef.saveAs(file,saveOpt, true);

docRef.layers[0].translate(-width);
var file = new File(orgDocRef.path + "/" + orgDocRef.name + "_2.png");
docRef.saveAs(file,saveOpt,true);

docRef.layers[0].translate(-width);
var file = new File(orgDocRef.path + "/" + orgDocRef.name + "_3.png");
docRef.saveAs(file,saveOpt,true);


docRef.close(SaveOptions.DONOTSAVECHANGES);
