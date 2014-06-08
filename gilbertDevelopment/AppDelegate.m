//
//  AppDelegate.m
//  gilbertDevelopment
//
//  Created by Hugh Rawlinson on 07/05/2014.
//  Copyright (c) 2014 codeoclock. All rights reserved.
//

#import "AppDelegate.h"
#import "RtAudio.h"

@implementation AppDelegate

int record( void *outputBuffer, void *inputBuffer, unsigned int nBufferFrames, double streamTime, RtAudioStreamStatus status, void *userData ){
    if(status){
        std::cout << "Stream overflow detected!" << std::endl;
    }
    // Do something with the data in the "inputBuffer" buffer.
    return 0;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    RtAudio adc;
    if ( adc.getDeviceCount() < 1 ) {
        std::cout << "\nNo audio devices found!\n";
        exit( 0 );
    }
    RtAudio::StreamParameters parameters;
    parameters.deviceId = adc.getDefaultInputDevice();
    parameters.nChannels = 2;
    parameters.firstChannel = 0;
    unsigned int sampleRate = 44100;
    unsigned int bufferFrames = 256; // 256 sample frames
    try {
        adc.openStream( NULL, &parameters, RTAUDIO_SINT16,
                       sampleRate, &bufferFrames, &record );
        adc.startStream();
    }
    catch ( RtAudioError& e ) {
        e.printMessage();
        exit( 0 );
    }
}

@end
