#import "Launcher.h"
#import <Cordova/CDV.h>


@implementation NSString (NSString_Extended)

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || 
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end

@implementation Launcher

- (void)canLaunch:(CDVInvokedUrlCommand*)command {
	NSDictionary* options = [command.arguments objectAtIndex:0];
	CDVPluginResult * pluginResult = nil;

	if ([options objectForKey:@"uri"]) {
		NSString *uri = [options objectForKey:@"uri"];
		if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:uri]]) {
			 pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
			[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		} else {
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No app installed that can handle that uri."];
			[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		}
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'uri' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
}

- (void)launch:(CDVInvokedUrlCommand*)command {
	NSDictionary* options = [command.arguments objectAtIndex:0];
	CDVPluginResult * pluginResult = nil;

	if ([options objectForKey:@"uri"]) {
		NSString *uri = [options objectForKey:@"uri"];
		if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:uri]]) {
			NSURL *launchURL = [NSURL URLWithString:uri];
			[[UIApplication sharedApplication] openURL: launchURL];
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
			[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		} else {
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No app installed that can handle that uri."];
			[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
		}
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'uri' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
}



- (void)launchStarplayer:(CDVInvokedUrlCommand*)command {
	NSDictionary* options = [command.arguments objectAtIndex:0];
	CDVPluginResult * pluginResult = nil;

	// 授權 License
	NSString *license = nil;
	if ([options objectForKey:@"license"]) {
		license = [options objectForKey:@"license"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'license' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}

	// Starplayer XML resource url
	NSString *url_origin = nil;
	if ([options objectForKey:@"url"]) {
		url_origin = [options objectForKey:@"url"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'url' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
	// NSString *url = [url_origin stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	// NSString *url = [url urlencode];
    // NSString *url = [url_origin stringByAddingPercentEncodingWithAllowedCharacters:(NSCharacterSet *)NSUTF8StringEncoding];
	// NSString *url = [url_origin urlEncodeUsingEncoding:NSUTF8StringEncoding];  // [url_origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSString *url = urlEncodeUsingEncoding:( url_origin )
    // NSString *url = [ url_origin url// ]
	NSString *url = [url_origin urlencode];
    NSLog(@"uri_origin:%@\nuri:%@", url_origin, url);

	// referer
	NSString *referer_origin = nil;
	if ([options objectForKey:@"referer"]) {
		referer_origin = [options objectForKey:@"referer"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'referer' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}
	// NSString *referer = [referer_origin stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
	// NSString *referer = [referer_origin urlencode];
	// NSString *referer = [referer_origin stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
	NSString *referer = [referer_origin urlencode];
	// NSString *referer = [referer_origin urlEncodeUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"referer_origin:%@\nreferer:%@", referer_origin, referer);

	// debug
	NSString *debug = nil;
	if ([options objectForKey:@"debug"]) {
		debug = [options objectForKey:@"debug"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'debug' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}

	// version
	NSString *version = nil;
	if ([options objectForKey:@"version"]) {
		version = [options objectForKey:@"version"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'version' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}

	// pmp
	NSString *pmp = nil;
	if ([options objectForKey:@"pmp"]) {
		pmp = [options objectForKey:@"pmp"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'pmp' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}

	// referer_return
	NSString *referer_return = nil;
	if ([options objectForKey:@"referer_return"]) {
		referer_return = [options objectForKey:@"referer_return"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'referer_return' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}

	// user_id
	NSString *user_id = nil;
	if ([options objectForKey:@"user_id"]) {
		user_id = [options objectForKey:@"user_id"];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing option: 'user_id' required."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}


	NSString *uri = [NSString stringWithFormat:@"starplayer://?license=%@&url=%@&referer=%@&debug=%@&version=%@&pmp=%@&referer_return=%@&from=safari&&offine_check=false&user_id=%@", 
			license, url, referer, debug, version, pmp, referer_return, user_id];
	NSLog(@"uri: %@", uri);

	if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:uri]]) {
		NSURL *launchURL = [NSURL URLWithString:uri];
		[[UIApplication sharedApplication] openURL: launchURL];
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	} else {
		pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"No app installed that can handle that uri."];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}

}

@end
