//===========================================================================
//Copyright (C) 2003, 2004 Zentaro Kavanagh
//
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions
//are met:
//
//- Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//- Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//- Neither the name of Zentaro Kavanagh nor the names of contributors 
//  may be used to endorse or promote products derived from this software 
//  without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
//PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE ORGANISATION OR
//CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
//PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//===========================================================================

#include "StdAfx.h"
#include "OggFLAC_1_0_Stream.h"
//#include "FLACMath.h"

OggFLAC_1_0_Stream::OggFLAC_1_0_Stream(OggPage* inBOSPage, OggDemuxSourceFilter* inOwningFilter, bool inAllowSeek)
	:	OggStream(inBOSPage, inOwningFilter, inAllowSeek)
	,	mFLACFormatBlock(NULL)
	//,	mNumHeaderPackets(0)
{
	InitCodec(inBOSPage->getStampedPacket(0));
}

OggFLAC_1_0_Stream::~OggFLAC_1_0_Stream(void)
{
	delete mFLACFormatBlock;
}

bool OggFLAC_1_0_Stream::InitCodec(StampedOggPacket* inOggPacket) {
	//Can probably abstract this out of here too !
	mCodecHeaders = new StreamHeaders;
	mCodecHeaders->mCodecType = StreamHeaders::FLAC;
	mCodecHeaders->addPacket((StampedOggPacket*)inOggPacket->clone());
	//What to do with commment fields ??
	//We set this to 1... and we override the header processor
	//When we see the last header packet ie starts with 1xxxxxxx then we decrement it.
	mNumHeadersNeeded = 1;
	return true;
}

wstring OggFLAC_1_0_Stream::getPinName() {
	wstring locName = L"FLAC Out";
	return locName;
}

bool OggFLAC_1_0_Stream::createFormatBlock() {
	const unsigned char FLAC_CHANNEL_MASK = 14;  //00001110
	const unsigned char FLAC_BPS_START_MASK = 1; //00000001
	const unsigned char FLAC_BPS_END_MASK = 240;  //11110000
	mFLACFormatBlock = new sFLACFormatBlock;
	//Fix the format block data... use header version and other version.
	//mFLACFormatBlock->FLACVersion = FLACMath::charArrToULong(mCodecHeaders->getPacket(1)->packetData() + 28);
	mFLACFormatBlock->numChannels = (((mCodecHeaders->getPacket(1)->packetData()[16]) & FLAC_CHANNEL_MASK) >> 1) + 1;
	mFLACFormatBlock->sampleRate = (iBE_Math::charArrToULong(mCodecHeaders->getPacket(1)->packetData() + 14)) >> 12;
	
	mFLACFormatBlock->numBitsPerSample =	(((mCodecHeaders->getPacket(1)->packetData()[16] & FLAC_BPS_START_MASK) << 4)	|
											((mCodecHeaders->getPacket(1)->packetData()[17] & FLAC_BPS_END_MASK) >> 4)) + 1;	
	return true;
}
BYTE* OggFLAC_1_0_Stream::getFormatBlock() {

	return (BYTE*)mFLACFormatBlock;


}
unsigned long OggFLAC_1_0_Stream::getFormatBlockSize() {
	//Do something
	return sizeof(sFLACFormatBlock);
}
GUID OggFLAC_1_0_Stream::getFormatGUID() {
	return FORMAT_FLAC;
}
GUID OggFLAC_1_0_Stream::getSubtypeGUID() {
	return MEDIASUBTYPE_FLAC;
}
GUID OggFLAC_1_0_Stream::getMajorTypeGUID() {
	return MEDIATYPE_Audio;
}

//Need to override from oggstream because we have variable number of headers
bool OggFLAC_1_0_Stream::processHeaderPacket(StampedOggPacket* inPacket) {
	//FIX::: Return values
	const unsigned char MORE_HEADERS_MASK = 128;   //10000000
	//We don't delete the packet... the codecheader list will delete when it's done.
	//StampedOggPacket* locPacket = processPacket(inPacket);
	if (inPacket != NULL) {
		//We got a comlpete packet
		mCodecHeaders->addPacket(inPacket);
		if ((inPacket->packetData()[0] & MORE_HEADERS_MASK) != 0) {
			mNumHeadersNeeded--;
			//mNumHeaderPackets++;
		}
	}
	return true;
}
void OggFLAC_1_0_Stream::setLastEndGranPos(__int64 inPos) {
	mLastEndGranulePos = (inPos * (__int64)mFLACFormatBlock->sampleRate)/ UNITS;
}
bool OggFLAC_1_0_Stream::deliverCodecHeaders() {
	StampedOggPacket* locPacket = NULL;
	for (unsigned long i = 0; i < mCodecHeaders->numPackets(); i++) {
		if (i==0) {
			locPacket = (StampedOggPacket*)mCodecHeaders->getPacket(0)->clone();
		} else {
			locPacket->merge(mCodecHeaders->getPacket(i));
		}
	}
	if (mCodecHeaders->numPackets() > 0) {
		dispatchPacket(locPacket);
	}
	return true;
}

LONGLONG OggFLAC_1_0_Stream::getCurrentPos() {
	return (mLastEndGranulePos * UNITS) / mFLACFormatBlock->sampleRate;
}

//unsigned long OggFLAC_1_0_Stream::numCodecHeaders() {
//	return mNumHeaderPackets;  //is this even needed ?
//}