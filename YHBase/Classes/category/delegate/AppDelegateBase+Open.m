//
//  AppDelegateBase+Open.m
//  Pods
//
//  Created by 林宁宁 on 16/4/16.
//
//

#import "AppDelegateBase+Open.h"
#import "MacroAppInfo.h"
#import "BBXGuideViewController.h"
#import "AppDelegateBase+Assess.h"
#import "AppDelegateBase+Reachability.h"
#import "UserInfoTool.h"
#import "SVProgressHUD.h"


#define LANUCH_VIEW_TAG         889

@implementation AppDelegateBase (Open)

- (void)startApp
{
    //是否需要启动页判断
    if([MacroAppInfo needShowGuid])
    {
        //    弹出启动页
        __weak typeof(&*self)weakSelf = self;
        
        BBXGuideViewController * guideVC = [[BBXGuideViewController alloc] init];
        
        
        [guideVC setEnterAppBlock:^(BBXGuideViewController *vc) {
            
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        [self.window.rootViewController presentViewController:guideVC animated:YES completion:nil];
        
    }
    else
    {
        [self openHomePageVC];
    }
}

- (void)openGuideVC
{
    BBXGuideViewController * guideVC = [[BBXGuideViewController alloc] init];
    
    [self.rootNavc  pushViewController:guideVC animated:YES];
}

/**
 *  打开主界面
 */
- (void)openHomePageVC
{
    
    __weak typeof(&*self)weakSelf = self;
    
    [self beginLaunchViewDismissAnimationWithFinishBlock:^{
        
//        weakSelf.window.rootViewController = weakSelf.rootNavc;
//        [weakSelf.window makeKeyAndVisible];
        
        //检查网络
        [weakSelf setNetworkingConfig];
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        
        [weakSelf appHomeStart];
    }];
}


- (void)beginLaunchViewDismissAnimationWithFinishBlock:(void(^)())finishBlock
{
    UIView * launchView = [self.window viewWithTag:LANUCH_VIEW_TAG];
    
    if(launchView)
    {
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            launchView.alpha = 0.0f;
            launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
            
            
        } completion:^(BOOL finished) {
            
            [launchView removeFromSuperview];
            
            if(finishBlock)
            {
                finishBlock();
            }
        }];
    }
    else
    {
        if(finishBlock)
        {
            finishBlock();
        }
    }
}


@end
