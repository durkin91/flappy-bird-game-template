//
//  PlistManager.h
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

#import <Foundation/Foundation.h>

@interface PlistManager : NSObject

+ (void) setupPlistValues;

+ (void) copyPlist;
+ (void) createArrayFromPlist;
+ (NSString* ) readDataFromPlistWithKey: (NSString*) key;
+ (void) savePlistDataToNSUserDefaultsWithKey: (NSString*) key;
+ (void) saveAllPlistDataToNSUserDefaults;

+ (NSString*) getStringValueFromNSUserDefaultsWithKey: (NSString*) key;
+ (BOOL) getBoolValueFromNSUserDefaultsWithKey: (NSString*) key;
+ (int) getIntValueFromNSUserDefaultsWithKey: (NSString*) key;

@end
