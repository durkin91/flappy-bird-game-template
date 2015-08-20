//
//  RootViewControllerInterface.m
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

#import "RootViewControllerInterface.h"

@implementation RootViewControllerInterface

@synthesize rootViewController;

#pragma mark -
#pragma mark Singleton Methods

+ (id)sharedManager {
    static RootViewControllerInterface *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(void) presentViewController:(UIViewController*)controller animated:(BOOL)animated {
    [rootViewController presentViewController:controller animated:animated completion:^{
        NSLog(@"...rootViewControllerInterFace presented");
    }];
}

- (void) presentUIActivityViewControllerWithCurrentScoreInString:(NSString*) scoreCurrentInString {
    
    // getting saved screenshot
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"screenshot.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    // getting message
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@ \n \n %@ \n", SHARE_TEXT_FIRST_PART, scoreCurrentInString, SHARE_TEXT_SECOND_PART, SHARE_TEXT_THIRD_PART];
    
    NSArray *objectsToShare = @[text, image];
    
    
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    // fix for iOS8+
    if ([controller respondsToSelector:@selector(popoverPresentationController)])
    {
        UIPopoverPresentationController *presentationController = [controller popoverPresentationController];
        presentationController.sourceView = rootViewController.view;
    }
    
    [rootViewController presentViewController:controller animated:YES completion:nil];
}


@end