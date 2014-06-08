//
//  AppDelegate.m
//  gilbertDevelopment
//
//  Created by Hugh Rawlinson on 07/05/2014.
//  Copyright (c) 2014 codeoclock. All rights reserved.
//

#import "AppDelegate.h"
#import "gilbertcore/gilbert.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    gilbert * g = new gilbert();
    std::cout<<g->test()<<std::endl;
}

@end
