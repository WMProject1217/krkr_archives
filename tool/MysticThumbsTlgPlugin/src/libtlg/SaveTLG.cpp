#include "TLG.h"
#include <sstream>

extern int SaveTLG5(tTJSBinaryStream *out, int width, int height, int colors, void *callback, tTVPGraphicScanLineCallback scanlinecallback);
extern int SaveTLG6(tTJSBinaryStream *out, int width, int height, int colors, void *callback, tTVPGraphicScanLineCallback scanlinecallback);

//---------------------------------------------------------------------------

/**
 * TLG�摜�̃Z�[�u
 * @param dest �i�[��X�g���[��
 * @param type ��� 0:TLG5 1:TLG6
 * @parma width �摜����
 * @param height �摜�c��
 * @param colors �F���w�� 1:8bit�O���[ 3:RGB 4:RGBA
 * @param callbackdata �R�[���o�b�N�p�f�[�^
 * @param scanlinecallback �Z�[�u�f�[�^�ʒm�p�R�[���o�b�N(�f�[�^�������Ă���A�h���X��n��)
 * @param tags �ۑ�����^�O���
 * @return 0:���� 1:���f -1:�G���[
 */
int
TVPSaveTLG(tTJSBinaryStream *dest,
		   int type,
		   int width, int height, int colors,
		   void *callback,
		   tTVPGraphicScanLineCallback scanlinecallback,
		   const std::map<std::string,std::string> *tags)
{
	int (*saveproc)(tTJSBinaryStream *, int, int, int, void *, tTVPGraphicScanLineCallback);

	saveproc = (type == 0) ? SaveTLG5 : SaveTLG6;
	
	// if no tags given, simply write TLG stream
	if (tags == NULL || tags->size() == 0) {
		return saveproc(dest, width, height, colors, callback, scanlinecallback);
	}

	// �^�O����TLG�t�@�C���̏���
	
	// write TLG0.0 Structured Data Stream header
	if (!dest->WriteBuffer("TLG0.0\x00sds\x1a\x00", 11)) {
		return TLG_ERROR;
	}

	tjs_uint64 rawlenpos = dest->GetPosition();
	if (!dest->WriteBuffer("0000", 4)) {
		return TLG_ERROR;
	}

	// write raw TLG stream
	int ret;
	if ((ret = saveproc(dest, width, height, colors, callback, scanlinecallback)) != TLG_SUCCESS) {
		return ret;
	}

	// write raw data size
	tjs_uint64 pos_save = dest->GetPosition();
	dest->SetPosition(rawlenpos);
	int size = (int)(pos_save - rawlenpos - 4);

	if (!dest->WriteInt32(size)) {
		return TLG_ERROR;
	}
	dest->SetPosition(pos_save);

	// write "tags" chunk name
	if (!dest->WriteBuffer("tags", 4)) {
		return TLG_ERROR;
	}

	// build tag chunk data
	std::stringstream ss;
	std::map<std::string,std::string>::const_iterator it = tags->begin();
	while (it != tags->end()) {
		ss << it->first.length() << ":" << it->first << "=" << it->second.length() << ":" << it->second << ",";
	}

	std::string s = ss.str();

	// write tag chunk
	if (!dest->WriteInt32(s.length()) ||
		!dest->WriteBuffer(s.c_str(), s.length())) {
		return TLG_ERROR;
	}
	
	return TLG_SUCCESS;
}
