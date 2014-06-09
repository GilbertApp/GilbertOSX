//
//  AppDelegate.h
//  gilbertDevelopment
//
//  Created by Hugh Rawlinson on 07/05/2014.
//  Copyright (c) 2014 codeoclock. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "gilbertcore/gilbert.h"

gilbert * g;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
- (IBAction)buttonPressed:(NSButton *)sender;

@end
