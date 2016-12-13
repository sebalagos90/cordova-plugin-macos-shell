#import "MacosShell.h"
#import <Cordova/CDV.h>

@implementation MacosShell
- (void) executeCommand:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground: ^{
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"plugin OK"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }]
}
@end