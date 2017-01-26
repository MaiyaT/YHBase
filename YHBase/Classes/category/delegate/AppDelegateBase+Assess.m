//
//  AppDelegate+Assess.m
//  Shudu
//
//  Created by 林宁宁 on 16/3/1.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AppDelegateBase+Assess.h"
#import "AppConfigNote.h"
#import "JCAlertView.h"
#import "MacroAppInfo.h"
#import "UIColor+BBXApp.h"

#define Launch_Times        @"Launch_Times"
#define AlerVersion         @"alert_version"

@implementation AppDelegateBase (Assess)




/**
 *  弹出好评的提示窗
 */
- (void)popAssessVWithText:(NSString *)message
{
    [JCAlertView showTwoButtonsWithTitle:@"\(^o^)/~" Message:message ButtonType:2 ButtonTitle:@"马上赏" Click:^{
        [[NSUserDefaults standardUserDefaults] setObject:[MacroAppInfo APP_VERSION] forKey:AlerVersion];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_URL]];
    } ButtonType:0 ButtonTitle:@"等一等" Click:^{
        
    }];
}


- (void)popAssessVWithTitle:(NSString *)title andAssessKey:(NSString *)key andBtnWarn:(BOOL)haveWarnBtn
{
    BOOL donotShow = [[[NSUserDefaults standardUserDefaults] objectForKey:key] boolValue];
    
    if(!donotShow)
    {
        if(haveWarnBtn)
        {
            [JCAlertView showTwoButtonsWithTitle:@"友情提示" Message:title ButtonType:2 ButtonTitle:@"不再提醒" Click:^{
                
                [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:key];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
            } ButtonType:0 ButtonTitle:@"知道了" Click:^{
                
            }];
        }
        else
        {
            [JCAlertView showOneButtonWithTitle:@"友情提示" Message:title ButtonType:0 ButtonTitle:@"知道了" Click:^{
                
            }];
        }
    }
}

@end
