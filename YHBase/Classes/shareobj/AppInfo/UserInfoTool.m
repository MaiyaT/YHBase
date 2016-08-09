//
//  UserInfoTool.m
//  SuoShi
//
//  Created by 林宁宁 on 16/3/15.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "UserInfoTool.h"
#import "MacroAppInfo.h"


@implementation UserInfoTool

+(instancetype)shareManager
{
    static UserInfoTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[UserInfoTool alloc] init];
        
        [tool readFromLocal];
    });
    
    return tool;
}

- (void)readFromLocal
{
    NSDictionary * infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
    
    if([infoDic isKindOfClass:[NSDictionary class]])
    {
        id obj = infoDic[@"userID"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userID = obj;
        }
        
        obj = infoDic[@"userImageURL"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userImageURL = obj;
        }
        
        obj = infoDic[@"userName"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userName = obj;
        }
        
        obj = infoDic[@"userIdClosedAD"];
        if(obj && ![obj isKindOfClass:[NSNull class]])
        {
            self.userIdClosedAD = [obj boolValue];
        }
        
        obj = infoDic[@"userLoginType"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userLoginType = obj;
        }
        
        obj = infoDic[@"userObjectID"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userObjectID = obj;
        }
        
        obj = infoDic[@"userClosedADAppVersion"];
        if([obj isKindOfClass:[NSString class]])
        {
            self.userClosedADAppVersion = obj;
        }
    }
}

-(void)saveToLocal
{
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    
    if(self.userID)
    {
        [dataDic setObject:self.userID forKey:@"userID"];
    }
    
    if(self.userImageURL)
    {
        [dataDic setObject:self.userImageURL forKey:@"userImageURL"];
    }
    
    if(self.userName)
    {
        [dataDic setObject:self.userName forKey:@"userName"];
    }
    
    if(self.userLoginType)
    {
        [dataDic setObject:self.userLoginType forKey:@"userLoginType"];
    }
    
    if(self.userObjectID)
    {
        [dataDic setObject:self.userObjectID forKey:@"userObjectID"];
    }
    
    [dataDic setObject:@(self.userIdClosedAD) forKey:@"userIdClosedAD"];
    
    if(self.userClosedADAppVersion)
    {
        [dataDic setObject:self.userClosedADAppVersion forKey:@"userClosedADAppVersion"];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dataDic forKey:@"userinfo"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (BOOL)appADIsClose
{
    if(self.userIdClosedAD)
    {
        return YES;
    }
    else if ([self.userClosedADAppVersion isEqualToString:[MacroAppInfo APP_VERSION]])
    {
        return YES;
    }
    return NO;
}

- (void)cleanUserInfo
{
    self.userID = nil;
    self.userImageURL = nil;
    self.userName = nil;
    //    self.userIdClosedAD = NO;
    
    self.userLoginType = nil;
    self.userObjectID = nil;
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userinfo"];
    
    [self saveToLocal];
}


@end
