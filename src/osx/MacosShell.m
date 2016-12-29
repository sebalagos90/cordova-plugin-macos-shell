#import "MacosShell.h"
#import <Cordova/CDV.h>

@implementation MacosShell
- (void) executeCommand:(CDVInvokedUrlCommand*)command {
    NSString *shellCommand = [command.arguments objectAtIndex:0];
    if(shellCommand == nil){
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"NO_COMMAND"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    [self.commandDelegate runInBackground: ^{
        NSPipe* pipe = [NSPipe pipe];
        
        NSTask* task = [[NSTask alloc] init];
        [task setLaunchPath: @"/bin/sh"];
        [task setArguments:@[@"-c", [NSString stringWithFormat:@"%@ -t 1000", shellCommand]]];
        [task setStandardOutput:pipe];
        
        NSFileHandle* file = [pipe fileHandleForReading];
        [task launch];
        NSData *data = [file readDataToEndOfFile];
        //NSLog(@"%@", data);
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [file closeFile];
        //NSLog(@"%@", result);
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
@end
