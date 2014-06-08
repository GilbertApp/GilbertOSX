//
//  AppDelegate.m
//  gilbertDevelopment
//
//  Created by Hugh Rawlinson on 07/05/2014.
//  Copyright (c) 2014 codeoclock. All rights reserved.
//

#import "AppDelegate.h"
#import "portaudio.h"

@implementation AppDelegate

//int record( void *outputBuffer, void *inputBuffer, unsigned int nBufferFrames, double streamTime, RtAudioStreamStatus status, void *userData ){
//    if(status){
//        std::cout << "Stream overflow detected!" << std::endl;
//    }
//    // Do something with the data in the "inputBuffer" buffer.
//    return 0;
//}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    Pa_Initialize();
//    RtAudio adc;
//    if ( adc.getDeviceCount() < 1 ) {
//        std::cout << "\nNo audio devices found!\n";
//        exit( 0 );
//    }
//    RtAudio::StreamParameters parameters;
//    parameters.deviceId = adc.getDefaultInputDevice();
//    parameters.nChannels = 2;
//    parameters.firstChannel = 0;
//    unsigned int sampleRate = 44100;
//    unsigned int bufferFrames = 256; // 256 sample frames
//    try {
//        adc.openStream( NULL, &parameters, RTAUDIO_SINT16,
//                       sampleRate, &bufferFrames, &record );
//        adc.startStream();
//    }
//    catch ( RtAudioError& e ) {
//        e.printMessage();
//        exit( 0 );
//    }
}

typedef struct
{
    float left_phase;
    float right_phase;
}
paTestData;
/* This routine will be called by the PortAudio engine when audio is needed.
 It may called at interrupt level on some machines so don't do anything
 that could mess up the system like calling malloc() or free().
 */
static int patestCallback( const void *inputBuffer, void *outputBuffer,
                          unsigned long framesPerBuffer,
                          const PaStreamCallbackTimeInfo* timeInfo,
                          PaStreamCallbackFlags statusFlags,
                          void *userData )
{
    /* Cast data passed through stream to our structure. */
    paTestData *data = (paTestData*)userData;
    float *out = (float*)outputBuffer;
    unsigned int i;
    (void) inputBuffer; /* Prevent unused variable warning. */
    
    for( i=0; i<framesPerBuffer; i++ )
    {
        *out++ = data->left_phase;  /* left */
        *out++ = data->right_phase;  /* right */
        /* Generate simple sawtooth phaser that ranges between -1.0 and 1.0. */
        data->left_phase += 0.01f;
        /* When signal reaches top, drop back down. */
        if( data->left_phase >= 1.0f ) data->left_phase -= 2.0f;
        /* higher pitch so we can distinguish left and right. */
        data->right_phase += 0.03f;
        if( data->right_phase >= 1.0f ) data->right_phase -= 2.0f;
    }
    return 0;
}

@end
