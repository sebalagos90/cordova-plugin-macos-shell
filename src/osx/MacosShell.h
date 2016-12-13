#import <Cordova/CDV.h>

@interface MacosShell : CDVPlugin

- (void) executeCommand:(CDVInvokedUrlCommand*)command;

@end