//
//  APPSettingManager.m
//  Pods
//
//  Created by 林宁宁 on 2017/2/15.
//
//

#import "APPSettingManager.h"
#import "BBXDBManager.h"
#import "NSObject+YYModel.h"



@implementation APPSettingManager


+ (instancetype)shareManager
{
    static APPSettingManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [APPSettingManager modelWithDictionary:[APPSettingManager readFormLocal]];
        if(!manager)
        {
            manager = [[APPSettingManager alloc] init];
        }
    });
    
    return manager;
}

//读取本地
+ (NSDictionary *)readFormLocal
{
    NSArray * dataList = [BBXDBManager getDataListFormTableType:@"tab_setting"];
    if([dataList count] > 0)
    {
        NSDictionary * dataDic = [dataList firstObject];
        if([dataDic isKindOfClass:[NSDictionary class]])
        {
            NSString * json = dataDic[@"json"];
            if([json isKindOfClass:[NSString class]])
            {
                NSDictionary * dataJson = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:4] options:NSJSONReadingMutableContainers error:nil];
                if([dataJson isKindOfClass:[NSDictionary class]])
                {
                    return dataJson;
                }
            }
        }
    }
    
    return nil;
}

- (void)saveTolocal
{
    NSString * jsonStr = [self modelToJSONString];
    
    NSDictionary * saveDic = @{@"id":@(0),
                               @"json":jsonStr};
    
    
    if(![BBXDBManager isExitAtTable:@"tab_setting" withDataDic:@{@"id":@(0)}])
    {
        [BBXDBManager insetDataDic:saveDic toTable:@"tab_setting"];
    }
    else
    {
        [BBXDBManager updateTableType:@"tab_setting" withWhereDic:@{@"id":@(0)} andUpdateValue:saveDic];
    }
    
}





+ (NSArray *)skinFontStyleList
{
    NSArray * systemFont = [UIFont familyNames];
    
    NSMutableArray * fontlist = [[NSMutableArray alloc] init];
    
    [fontlist addObject:[UIFont systemFontOfSize:18].fontName];
    [fontlist addObject:@"Roboto-Light"];
    [fontlist addObjectsFromArray:systemFont];
    
    return fontlist;
}


@end
