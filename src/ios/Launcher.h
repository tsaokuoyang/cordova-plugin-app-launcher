#import <Cordova/CDV.h>

@interface NSString (NSString_Extended)
- (NSString *)urlencode;
@end

@interface Launcher : CDVPlugin

// - (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding
- (void)canLaunch:(CDVInvokedUrlCommand*)command;
- (void)launch:(CDVInvokedUrlCommand*)command;
- (void)launchStarplayer:(CDVInvokedUrlCommand*)command;
- (void)launchStarplayerPlus:(CDVInvokedUrlCommand*)command;

@end
