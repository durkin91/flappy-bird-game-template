//
//  ShopCharacters.m
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

#import "ShopCharacters.h"
#import "StoreInventory.h"
#import "FlappyBlueprintTwoStoreAssets.h"
#import "InsufficientFundsException.h"
#import "Defaults.h"
#import "ProgressHUD.h"
#import "Options.h"

@implementation ShopCharacters {
    CCLabelBMFont *_allCoinsLabel;
    NSUInteger allCoins;
    NSUInteger manualyRefreshedAllCoins;
    NSString *allCoinsString;
    
    NSString *confirmAlertMessage;
}

- (void)didLoadFromCCB {
    
    [self refreshAllCoinsBalance];
    
    [self addAllCoinsLabel];
    
}

- (void) addAllCoinsLabel {
    _allCoinsLabel = [CCLabelBMFont labelWithString:allCoinsString fntFile:@"MyAwesomeBMFont.fnt"];
    _allCoinsLabel.anchorPoint = ccp(1.0, 0.5);
    _allCoinsLabel.position = ccp(280, 500);
    _allCoinsLabel.scale = 0.7f;
    
    [self addChild:_allCoinsLabel];
}

- (void) refreshAllCoinsBalance {
    // getting the number of all coins
    allCoins = [StoreInventory getItemBalance:COINS_CURRENCY_ITEM_ID];
    allCoinsString = [NSString stringWithFormat:@"%li",(long)allCoins];
    _allCoinsLabel.string = allCoinsString;
    
}

- (void) character01Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_01_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_01_NAME];
        [self showConfirmEquipAlertWithTag:11];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_01_NAME, (long)CLOTHES_PRODUCT_01_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:1];
    }
}

- (void) character02Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_02_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_02_NAME];
        [self showConfirmEquipAlertWithTag:12];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_02_NAME, (long)CLOTHES_PRODUCT_02_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:2];
    }
}

- (void) character03Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_03_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_03_NAME];
        [self showConfirmEquipAlertWithTag:13];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_03_NAME, (long)CLOTHES_PRODUCT_03_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:3];
    }
}

- (void) character04Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_04_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_04_NAME];
        [self showConfirmEquipAlertWithTag:14];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_04_NAME, (long)CLOTHES_PRODUCT_04_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:4];
    }
}

- (void) character05Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_05_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_05_NAME];
        [self showConfirmEquipAlertWithTag:15];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_05_NAME, (long)CLOTHES_PRODUCT_05_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:5];
    }
}

- (void) character06Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_06_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_06_NAME];
        [self showConfirmEquipAlertWithTag:16];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_06_NAME, (long)CLOTHES_PRODUCT_06_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:6];
    }
}

- (void) character07Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_07_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_07_NAME];
        [self showConfirmEquipAlertWithTag:17];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_07_NAME, (long)CLOTHES_PRODUCT_07_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:7];
    }
}

- (void) character08Tapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_08_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_08_NAME];
        [self showConfirmEquipAlertWithTag:18];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_08_NAME, (long)CLOTHES_PRODUCT_08_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:8];
    }
}

- (void) characterRandomTapped {
    [Options playTapSound];
    if ([StoreInventory getItemBalance:CLOTHES_GOOD_09_ITEM_ID] >= 1) {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@?", CONFIRM_EQUIP_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_RANDOM_NAME];
        [self showConfirmEquipAlertWithTag:19];
    } else {
        confirmAlertMessage = [NSString stringWithFormat:@"%@ %@ for %li %@?", CONFIRM_PURCHASE_ALERT_MESSAGE_FIRST_PART, CONFIRM_PURCHASE_ALERT_CHARACTER_RANDOM_NAME, (long)CLOTHES_PRODUCT_09_PRICE, VIRTUAL_CURRENCY_NAME];
        [self showConfirmPurchaseAlertWithTag:9];
    }
}

- (void) shopCoinsTapped {
    [Options playTapSound];
    
    CCScene *shopCoinsScene = [CCBReader loadAsScene:@"ShopCoins"];
    [[CCDirector sharedDirector] replaceScene:shopCoinsScene];
}

- (void) backButtonTapped {
    [Options playTapSound];
    CCScene *shopScene = [CCBReader loadAsScene:@"ShopMenu"];
    [[CCDirector sharedDirector] replaceScene:shopScene];
}

- (void) showInsuficientFundsAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:INSUFICIENT_FUNDS_ALERT_TITLE
                                                    message:INSUFICIENT_FUNDS_ALERT_DESCRIPTION
                                                   delegate:self
                                          cancelButtonTitle:INSUFICIENT_FUNDS_ALERT_NO_BUTTON
                                          otherButtonTitles:INSUFICIENT_FUNDS_ALERT_YES_BUTTON, nil];
    alert.tag = 100;
    [alert show];
}

- (void) showConfirmPurchaseAlertWithTag:(int) tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CONFIRM_PURCHASE_ALERT_TITLE
                                                    message:confirmAlertMessage
                                                   delegate:self
                                          cancelButtonTitle:CONFIRM_PURCHASE_ALERT_NO_BUTTON
                                          otherButtonTitles:CONFIRM_PURCHASE_ALERT_YES_BUTTON, nil];
    alert.tag = tag;
    [alert show];
}

- (void) showConfirmEquipAlertWithTag:(int) tag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CONFIRM_EQUIP_ALERT_TITLE
                                                    message:confirmAlertMessage
                                                   delegate:self
                                          cancelButtonTitle:CONFIRM_EQUIP_ALERT_NO_BUTTON
                                          otherButtonTitles:CONFIRM_EQUIP_ALERT_YES_BUTTON, nil];
    alert.tag = tag;
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ((alertView.tag == 1) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_01_ITEM_ID andPayload:@"character01"];
            [self boughtCharacter:CLOTHES_GOOD_01_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 2) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_02_ITEM_ID andPayload:@"character02"];
            [self boughtCharacter:CLOTHES_GOOD_02_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 3) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_03_ITEM_ID andPayload:@"character03"];
            [self boughtCharacter:CLOTHES_GOOD_03_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 4) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_04_ITEM_ID andPayload:@"character04"];
            [self boughtCharacter:CLOTHES_GOOD_04_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];;
        }
        
        
    }
    
    if ((alertView.tag == 5) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_05_ITEM_ID andPayload:@"character05"];
            [self boughtCharacter:CLOTHES_GOOD_05_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 6) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_06_ITEM_ID andPayload:@"character06"];
            [self boughtCharacter:CLOTHES_GOOD_06_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 7) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_07_ITEM_ID andPayload:@"character07"];
            [self boughtCharacter:CLOTHES_GOOD_07_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 8) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_08_ITEM_ID andPayload:@"character08"];
            [self boughtCharacter:CLOTHES_GOOD_08_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    if ((alertView.tag == 9) & (buttonIndex == 1)) {
        @try {
            [StoreInventory buyItemWithItemId:CLOTHES_GOOD_09_ITEM_ID andPayload:@"character09"];
            [self boughtCharacter:CLOTHES_GOOD_09_ITEM_ID];
            [self refreshAllCoinsBalance];
            
            [ProgressHUD showSuccess:@"Purchase completed!"];
            
        }
        @catch (InsufficientFundsException *exception) {
            [self showInsuficientFundsAlert];
        }
        
        
    }
    
    // equip
    
    if ((alertView.tag == 11) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_01_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType01;
    }
    
    if ((alertView.tag == 12) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_02_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType02;
    }
    
    if ((alertView.tag == 13) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_03_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType03;
    }
    
    if ((alertView.tag == 14) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_04_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType04;
    }
    
    if ((alertView.tag == 15) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_05_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType05;
    }
    
    if ((alertView.tag == 16) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_06_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:6 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType06;
    }
    
    if ((alertView.tag == 17) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_07_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:7 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType07;
    }
    
    if ((alertView.tag == 18) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_08_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:8 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroType08;
    }
    
    if ((alertView.tag == 19) & (buttonIndex == 1)) {
        
        [ProgressHUD showSuccess:@"Equiped!"];
        [StoreInventory equipVirtualGoodWithItemId:CLOTHES_GOOD_09_ITEM_ID];
      [[NSUserDefaults standardUserDefaults] setInteger:9 forKey:heroType];
      [[NSUserDefaults standardUserDefaults] synchronize];
        //heroType = kHeroTypeRandom;
    }
    
    
    // going to shop coins view
    if ((alertView.tag == 100) & (buttonIndex == 1)){
        
        CCScene *shopScene = [CCBReader loadAsScene:@"ShopCoins"];
        [[CCDirector sharedDirector] pushScene:shopScene];
    }
}

- (void) boughtCharacter: (NSString*) characterID {
  
  [StoreInventory equipVirtualGoodWithItemId:characterID];
  
  if (characterID == CLOTHES_GOOD_01_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType01;
  }
  
  if (characterID == CLOTHES_GOOD_02_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType02;
  }
  
  if (characterID == CLOTHES_GOOD_03_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType03;
  }
  
  if (characterID == CLOTHES_GOOD_04_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:4 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType04;
  }
  
  if (characterID == CLOTHES_GOOD_05_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType05;
  }
  
  if (characterID == CLOTHES_GOOD_06_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:6 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType06;
  }
  
  if (characterID == CLOTHES_GOOD_07_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:7 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType07;
  }
  
  if (characterID == CLOTHES_GOOD_08_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:8 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroType08;
  }
  
  if (characterID == CLOTHES_GOOD_09_ITEM_ID) {
    [[NSUserDefaults standardUserDefaults] setInteger:9 forKey:heroType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //heroType = kHeroTypeRandom;
  }
  
}


@end
