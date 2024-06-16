#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MCDFPRootListController.h"
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <rootless.h>

@implementation MCDFPRootListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	if ([specifier isKindOfClass:[PSTextFieldSpecifier class]]) {
		NSError *regexError;
		NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([1-9][0-9]?)\\.(\\d{1,2})(\\.\\d)?$" options:0 error:&regexError];
		NSRange lengthRange = NSMakeRange(0, [(NSString *)value length]);

		if ([regex numberOfMatchesInString:value options:0 range:lengthRange] == 1) {
			NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist")];
			if (!defaults) {
				defaults = [NSMutableDictionary dictionary];
			}
			[defaults setValue:value forKey:[specifier properties][@"key"]];
			[defaults writeToFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist") atomically:YES];
			CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("me.dimphoton.mcdfpreferences.prefsmodified"), NULL, NULL, YES);
		} else {
			UIAlertController *invalidAlert = [UIAlertController alertControllerWithTitle:@"Invalid Value" message:@"Please provide a correct value." preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {[self reloadSpecifiers];}];
			[invalidAlert addAction:alertAction];
			[self presentViewController:invalidAlert animated:YES completion:nil];
		}
	} else {
		NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist")];
		if (!defaults) {
			defaults = [NSMutableDictionary dictionary];
		}
		[defaults setValue:value forKey:[specifier properties][@"key"]];
		[defaults writeToFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist") atomically:YES];
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("me.dimphoton.mcdfpreferences.prefsmodified"), NULL, NULL, YES);
	}
}

-(id)readPreferenceValue:(PSSpecifier *)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist")];
	if (defaults && defaults[[specifier properties][@"key"]]) {
		return defaults[[specifier properties][@"key"]];
	} else {
		return [specifier properties][@"default"];
	}
}

-(void)resetDefaultStrings {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist")];
	if (!defaults) {
		defaults = [NSMutableDictionary dictionary];
	}
	[defaults setValue:@"17.5.1" forKey:@"iosVersion"];
	[defaults setValue:@"8.1.0" forKey:@"appVersion"];
	[defaults writeToFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/me.dimphoton.mcdfpreferences.plist") atomically:YES];
	[self reloadSpecifiers];
}

@end