//
//  AppDelegate.m
//  gilbertDevelopment
//
//  Created by Hugh Rawlinson on 07/05/2014.
//  Copyright (c) 2014 codeoclock. All rights reserved.
//

#import "AppDelegate.h"
#import "portaudio.h"
#import <vector>

@implementation AppDelegate


//int record( void *outputBuffer, void *inputBuffer, unsigned int nBufferFrames, double streamTime, RtAudioStreamStatus status, void *userData ){
//    if(status){
//        std::cout << "Stream overflow detected!" << std::endl;
//    }
//    // Do something with the data in the "inputBuffer" buffer.
//    return 0;
//}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    g = new gilbert();
    g->test();
    
    PaError err;
    err = Pa_Initialize();
    if( err != paNoError ) {
        printf(  "PortAudio error: %s\n", Pa_GetErrorText( err ) );
    }
    PaStream *stream;
    
    /* Open an audio I/O stream. */
    err = Pa_OpenDefaultStream( &stream,
                               0,          /* no input channels */
                               2,          /* stereo output */
                               paFloat32,  /* 32 bit floating point output */
                               44100,
                               256,        /* frames per buffer, i.e. the number
                                            of sample frames that PortAudio will
                                            request from the callback. Many apps
                                            may want to use
                                            paFramesPerBufferUnspecified, which
                                            tells PortAudio to pick the best,
                                            possibly changing, buffer size.*/
                               patestCallback, /* this is your callback function */
                               &data ); /*This is a pointer that will be passed to
                                         your callback*/
    if( err != paNoError ) {
        printf(  "PortAudio error: %s\n", Pa_GetErrorText( err ) );
    }
    
    /* Start the audio stream. */
    err = Pa_StartStream( stream );
    
    if( err != paNoError ) {
        printf(  "PortAudio error: %s\n", Pa_GetErrorText( err ) );
    }
}

typedef struct
{
    float left_phase;
    float right_phase;
}
paTestData;

static paTestData data;

static int patestCallback( const void *inputBuffer, void *outputBuffer,
                          unsigned long framesPerBuffer,
                          const PaStreamCallbackTimeInfo* timeInfo,
                          PaStreamCallbackFlags statusFlags,
                          void *userData )
{
    paTestData *data = (paTestData*)userData;
    std::vector<double> toGilbert(framesPerBuffer);
    
    for( int i=0; i<framesPerBuffer; i++ ){
        toGilbert.push_back(data->left_phase);
    }
    g->audioIn(toGilbert);
    return 0;
}

- (IBAction)buttonA:(id)sender {
}

- (IBAction)buttonPressed:(NSButton *)sender{
    NSLog(sender.identifier);
    g->registerBuffer([sender.identifier UTF8String]);
}
@end
