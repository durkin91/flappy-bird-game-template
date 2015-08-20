//
//  PlistManager.m
//  FlappyBlueprintTwo
/*
 * Copyright (c) 2014 Rebeloper. All rights reserved.
 *
 *      http://www.rebeloper.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "PlistManager.h"
#import "Defaults.h"

@implementation PlistManager

NSMutableArray *settingsArray;

+ (void) setupPlistValues {
    [self copyPlist];
    [self createArrayFromPlist];
    [self saveAllPlistDataToNSUserDefaults];
}

+ (void) copyPlist {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory =  [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:settingsNamePlist];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //check if the file exists already in users documents folder
    //if file does not exist copy it from the application bundle Plist file
    /*
    if ( ![fileManager fileExistsAtPath:path] ) {
        NSLog(@"Copying %@ to users desktop.", settingsName);
        NSString *pathToSettingsInBundle = [[NSBundle mainBundle] pathForResource:settingsName ofType:@"plist"];
        [fileManager copyItemAtPath:pathToSettingsInBundle toPath:path error:&error];
    }
    //if file is already there do nothing
    else {
        NSLog(@"%@ already configured.", settingsName);
    }*/
    
    
    NSString *pathToSettingsInBundle = [[NSBundle mainBundle] pathForResource:settingsName ofType:@"plist"];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSLog(@"Removing %@ from users documents.", settingsName);
        [fileManager removeItemAtPath:path error:&error];
    }
    
    NSLog(@"Copying %@ to users documents.", settingsName);
    [fileManager copyItemAtPath:pathToSettingsInBundle toPath:path error:&error];

}

+ (void) createArrayFromPlist {
    //create array from Plist document of all settings
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory =  [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:settingsNamePlist];
    settingsArray = [[[NSMutableArray alloc] initWithContentsOfFile:plistPath]mutableCopy];
    NSLog(@"%@", settingsArray);
}

+ (NSString* ) readDataFromPlistWithKey: (NSString*) key {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary *object in settingsArray) {
        if ([[object objectForKey:kXLink] isEqualToString:kXLinkPleaseDoNotEverChangeMeString]) {
            [tempArray insertObject:object atIndex:0];
        }
    }
    
    NSMutableDictionary *dict = [tempArray objectAtIndex:0];
    
    NSString *value;
    value = [dict objectForKey:key];
    
    NSLog(@">>>>> %@", value);
    
    return value;
}

+ (void) savePlistDataToNSUserDefaultsWithKey: (NSString*) key {
    NSString *theValue = [PlistManager readDataFromPlistWithKey:key];
    [[NSUserDefaults standardUserDefaults] setObject:theValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) saveAllPlistDataToNSUserDefaults {
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaCustomSecret];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPCoinBoosterPackID];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPCoinMegaPackID];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPCoinUltraPackID];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPCoinImpossiblePackID];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPCoinUltimatePackID];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPDoubleCoinsID];
    //[self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPRevealSecretID];
    [self savePlistDataToNSUserDefaultsWithKey:kSoomlaIAPNoAdsID];
        
    [self savePlistDataToNSUserDefaultsWithKey:kAdsFrequencyStartup];
    [self savePlistDataToNSUserDefaultsWithKey:kAdsFrequencyGameOver];
    
}

+ (NSString*) getStringValueFromNSUserDefaultsWithKey: (NSString*) key {
    NSString *theValue = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return theValue;
}

+ (BOOL) getBoolValueFromNSUserDefaultsWithKey: (NSString*) key {
    NSString *theValue = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([theValue  isEqual: @"YES"]) {
        return YES;
    } else {
        return NO;
    }
}

+ (int) getIntValueFromNSUserDefaultsWithKey: (NSString*) key {
    int theValue = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return theValue;
}

@end
