//
//  NSData+Gzw.m
//  跑腿
//
//  Created by mac on 16/1/21.
//  Copyright © 2016年 paotui. All rights reserved.
//

#import "NSData+Gzw.h"

@implementation NSData (Gzw)
+(NSData *)base64Encoded:(NSData *)data
{
    //base64binary(流媒体)
    
    static char encodingTable[64] = {
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
        'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
        'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
        'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };
    
    
    const unsigned char *bytes = [data bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:[data length]];
    unsigned long ixtext = 0;
    unsigned long lentext = [data length];
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    unsigned short i = 0;
    unsigned short charsonline = 0, ctcopy = 0;
    unsigned long ix = 0;
    
    while( YES )
    {
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 ) break;
        
        for( i = 0; i < 3; i++ ) {
            ix = ixtext + i;
            if( ix < lentext ) inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        
        outbuf [0] = (inbuf [0] & 0xFC) >> 2;
        outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
        outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        
        switch( ctremaining )
        {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for( i = 0; i < ctcopy; i++ )
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        
        for( i = ctcopy; i < 4; i++ )
            [result appendString:@"="];
        
        ixtext += 3;
        charsonline += 4;
    }
    
    return [result dataUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)jk_APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}
- (NSData *)jk_wavDataWithPCMFormat:(AudioStreamBasicDescription)PCMFormat;

{
    // Following https://ccrma.stanford.edu/courses/422/projects/WaveFormat/ formating wav
    
    unsigned int pcmDataLength = (unsigned int)[self length];    //pcm data length
    UInt32 wavHeaderSize = 44;                                      //wav header size = 44
    
    SInt8 *wavHeader = (SInt8 *)malloc(wavHeaderSize);
    if (wavHeader == NULL)
    {
        return nil;
    }
    
    // ChunkID = 'RIFF'
    wavHeader[0x00] = 'R';
    wavHeader[0x01] = 'I';
    wavHeader[0x02] = 'F';
    wavHeader[0x03] = 'F';
    
    // Chunk = 36 + SubChunk2Size
    // or more precisely:4 + (8 + SubChunk1Size) + (8 + SubChunk2Size)
    *((SInt32 *)(wavHeader + 0x04)) = pcmDataLength + 36;
    
    // Format = 'WAVE'
    wavHeader[0x08] = 'W';
    wavHeader[0x09] = 'A';
    wavHeader[0x0A] = 'V';
    wavHeader[0x0B] = 'E';
    
    // Subchunk1ID = 'fmt '
    wavHeader[0x0C] = 'f';
    wavHeader[0x0D] = 'm';
    wavHeader[0x0E] = 't';
    wavHeader[0x0F] = ' ';
    
    // SubchunckSize = 16 for PCM
    wavHeader[0x10] = 16;
    wavHeader[0x11] = 0;
    wavHeader[0x12] = 0;
    wavHeader[0x13] = 0;
    
    // AudioFormat, PCM format = 1
    wavHeader[0x14] = 1;
    wavHeader[0x15] = 0;
    
    // NumChannels
    wavHeader[0x16] = PCMFormat.mChannelsPerFrame;
    wavHeader[0x17] = 0;
    
    // SampleRate
    const int sampleRate = PCMFormat.mSampleRate;
    const char *ptr = (const char*)&sampleRate;
    char sampleRate1 = *ptr++;
    char sampleRate2 = *ptr++;
    char sampleRate3 = *ptr++;
    char sampleRate4 = *ptr++;
    wavHeader[0x18] = sampleRate1;
    wavHeader[0x19] = sampleRate2;
    wavHeader[0x1A] = sampleRate3;
    wavHeader[0x1B] = sampleRate4;
    
    // ByteRate
    const int byteRate = PCMFormat.mSampleRate * PCMFormat.mBitsPerChannel * PCMFormat.mChannelsPerFrame / 8;
    ptr = (const char*)&byteRate;
    char byteRate1 = *ptr++;
    char byteRate2 = *ptr++;
    char byteRate3 = *ptr++;
    char byteRate4 = *ptr++;
    wavHeader[0x1C] = byteRate1;
    wavHeader[0x1D] = byteRate2;
    wavHeader[0x1E] = byteRate3;
    wavHeader[0x1F] = byteRate4;
    
    // BlockAlign (bytesPerSample)
    wavHeader[0x20] = PCMFormat.mBytesPerFrame;
    wavHeader[0x21] = 0;
    
    // BitsPerSample
    wavHeader[0x22] = PCMFormat.mBitsPerChannel;
    // ExtraParamSize if PCM, then doesn't exist
    wavHeader[0x23] = 0;
    
    // Subchunk2ID = 'data'
    wavHeader[0x24] = 'd';
    wavHeader[0x25] = 'a';
    wavHeader[0x26] = 't';
    wavHeader[0x27] = 'a';
    
    // SubChunkSize = NumSamples * NumChannels * BitsPerSample/8. This is the number of bytes in the data.
    *((SInt32 *)(wavHeader + 0x28)) = pcmDataLength;
    
    NSMutableData *wavData = [NSMutableData dataWithBytes:wavHeader length:wavHeaderSize];
    free(wavHeader);
    
    // Append pcm data
    [wavData appendData:self];
    return wavData;
}
@end
