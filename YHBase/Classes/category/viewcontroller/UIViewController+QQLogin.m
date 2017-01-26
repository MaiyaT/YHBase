//
//  UIViewController+QQLogin.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/17.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UIViewController+QQLogin.h"
#import "UserInfoTool.h"
#import "JCAlertView.h"
#import "UIColor+BBXApp.h"
#import "SVProgressHUD.h"
#import "AppDelegateBase.h"


@implementation UIViewController (QQLogin)

-(BOOL)isLoginWithAlertTitle:(NSString *)showAlertTitle
{
    if(![UserInfoTool shareManager].userID)
    {
        [JCAlertView showTwoButtonsWithTitle:@"提醒" Message:showAlertTitle ButtonType:2 ButtonTitle:@"登录" Click:^{
            
            UIViewController * loginVC = [[NSClassFromString(@"LoginViewController") alloc] init];
            [[AppDelegateBase shareAppDelegate].rootNavc presentViewController:loginVC animated:YES completion:nil];
            
        } ButtonType:0 ButtonTitle:@"不了" Click:^{
            
        }];
        
        return NO;
    }
    
    return YES;
}

@end
