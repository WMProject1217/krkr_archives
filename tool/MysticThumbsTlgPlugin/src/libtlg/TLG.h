//---------------------------------------------------------------------------
/*
	TVP2 ( T Visual Presenter 2 )  A script authoring tool
	Copyright (C) 2000 W.Dee <dee@kikyou.info> and contributors

	See details of license at "license.txt"
*/
//---------------------------------------------------------------------------
// TLG5/6 decoder/encoder
//---------------------------------------------------------------------------

#ifndef __TLG_H__
#define __TLG_H__

#include "tjs.h"
#include "stream.h"
#include <string>
#include <map>

//---------------------------------------------------------------------------
// Graphic Loading Handler Type
//---------------------------------------------------------------------------

/*
	callback type to inform the image's size.
	call this once before TVPGraphicScanLineCallback.
	return false can stop processing
*/
typedef bool (*tTVPGraphicSizeCallback)(void *callbackdata, tjs_uint w, tjs_uint h);

/*
	callback type to ask the scanline buffer for the decoded image, per a line.
	returning null can stop the processing.

	passing of y=-1 notifies the scan line image had been written to the buffer that
	was given by previous calling of TVPGraphicScanLineCallback. in this time,
	this callback function must return NULL.
*/
typedef void * (*tTVPGraphicScanLineCallback)(void *callbackdata, tjs_int y);

//---------------------------------------------------------------------------
// return code
//---------------------------------------------------------------------------

#define TLG_SUCCESS (0)
#define TLG_ABORT   (1)
#define TLG_ERROR  (-1)


//---------------------------------------------------------------------------
// functions
//---------------------------------------------------------------------------

/**
 * src �ǂݍ��݌��X�g���[��
 * TLG�摜���ǂ����̔���
 */
bool
TVPCheckTLG(tTJSBinaryStream *src);

/**
 * TLG�摜�̏����擾
 * @param src �ǂݍ��݌��X�g���[��
 * @param width �������i�[��
 * @parma height �c�����i�[��
 */
extern bool
TVPGetInfoTLG(tTJSBinaryStream *src, int *width, int *height);

/**
 * TLG�摜�̃��[�h
 * @param dest �ǂݍ��݌��X�g���[��
 * @param callbackdata
 * @param sizecallback �T�C�Y���i�[�p�R�[���o�b�N
 * @param scanlinecallback ���[�h�f�[�^�i�[�p�R�[���o�b�N
 * @param tags �ǂݍ��񂾃^�O���̊i�[��
 * @return 0:���� 1:���f -1:�G���[
 */
extern int
TVPLoadTLG(void *callbackdata,
		   tTVPGraphicSizeCallback sizecallback,
		   tTVPGraphicScanLineCallback scanlinecallback,
		   std::map<std::string,std::string> *tags,
		   tTJSBinaryStream *src);

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
extern int
TVPSaveTLG(tTJSBinaryStream *dest,
		   int type,
		   int width, int height, int colors,
		   void *callbackdata,
		   tTVPGraphicScanLineCallback scanlinecallback,
		   const std::map<std::string,std::string> *tags);

#endif
