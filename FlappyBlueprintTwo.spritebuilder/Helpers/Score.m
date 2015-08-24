//
//  Score.m
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

#import "Score.h"
#import "Options.h"

@implementation Score

// score
+ (void)registerScore:(NSUInteger)score
{
    if(score > [Score bestScore]){
        [Score setBestScore:score];
    }
    
    [Score setCurrentScore:score];
}

+ (void) setBestScore:(NSUInteger) bestScore
{
    if ([Options isEasy]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:bestScore forKey:kBestScoreKeyEasy];
        
    }
    
    else if ([Options isMedium]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:bestScore forKey:kBestScoreKeyMedium];
        
    }
    
    else if ([Options isHard]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:bestScore forKey:kBestScoreKeyHard];
        
    }

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsBestScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger) bestScore
{
    if ([Options isEasy]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:kBestScoreKeyEasy];
                
    }
    
    else if ([Options isMedium]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:kBestScoreKeyMedium];
        
    }
    
    else if ([Options isHard]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:kBestScoreKeyHard];
        
    }
    
    else return [[NSUserDefaults standardUserDefaults] integerForKey:kBestScoreKeyMedium];
    
}

+ (BOOL) isBestScore {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsBestScoreKey];
}

+ (void) resetIsBestScore {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsBestScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) setCurrentScore:(NSUInteger) currentScore
{
    [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:kCurrentScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger) currentScore
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kCurrentScoreKey];
}

// current coins
+ (void) setCurrentCoins:(NSUInteger) currentCoins
{
    [[NSUserDefaults standardUserDefaults] setInteger:currentCoins forKey:kCurrentCoinsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger) currentCoins
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kCurrentCoinsKey];
}


@end
