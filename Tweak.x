#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <rootless.h>

BOOL tweakEnabled = YES;
NSString *UAString;

void setupTweakPreferences() {
	NSString *iosVersion = @"17.5.1";
	NSString *appVersion = @"8.1.0";
	NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist")];
	if (defaults) {
		if (defaults[@"tweakEnabled"]) {
			tweakEnabled = [defaults[@"tweakEnabled"] boolValue];
		}
		if (defaults[@"iosVersion"]) {
			iosVersion = defaults[@"iosVersion"];
		}
		if (defaults[@"appVersion"]) {
			appVersion = defaults[@"appVersion"];
		}
	}
	NSLocale *deviceLocale = [NSLocale currentLocale];
	NSString *localeCode = [NSString stringWithFormat:@"%@-US", [deviceLocale objectForKey:NSLocaleLanguageCode]];
	UAString = [NSString stringWithFormat:@"MCDSDK/%@ (iPhone; %@; %@) GMA/%@", appVersion, iosVersion, localeCode, appVersion];
}

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	setupTweakPreferences();
}

%hook NSURLSession

-(id)dataTaskWithRequest:(id)arg1 completionHandler:(id)arg2 {
	if (tweakEnabled) {
		if ([[[arg1 URL] absoluteString] hasPrefix:@"https://us-prod.api.mcd.com"]) {
			NSMutableURLRequest *mutableRequest = [arg1 mutableCopy];
			NSMutableDictionary *mutableHeaders = [[mutableRequest allHTTPHeaderFields] mutableCopy];
			[mutableHeaders setValue:UAString forKey:@"user-agent"];
			NSDictionary *newHeaders = [mutableHeaders copy];
			[mutableRequest setAllHTTPHeaderFields:newHeaders];
			NSURLRequest *newRequest = [mutableRequest copy];
			return %orig(newRequest, arg2);
		} else {
			return %orig;
		}
	} else {
		return %orig;
	}
}

%end

%hook UIViewController

-(void)presentViewController:(id)arg1 animated:(BOOL)arg2 completion:(id)arg3 {
	if (tweakEnabled) {
		NSSet *alertStrings = [NSSet setWithObjects:@"We’ve heard your feedback & have made improvements to our app. Please update to the latest version of the McDonald’s app for an upgraded experience.",@"Escuchamos tus comentarios e hicimos actualizaciones a nuestro app. Actualízate a la última versión del app de McDonald's para disfrutar una experiencia superior.",nil];
		if ([arg1 respondsToSelector:@selector(message)]) {
			if (![alertStrings containsObject:[arg1 message]]) {
				%orig;
			}
		} else {
			%orig;
		}
	} else {
		%orig;
	}
}

%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)notificationCallback, CFSTR("me.dimphoton.mcdfpreferences.prefsmodified"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
	setupTweakPreferences();
	%init;
}