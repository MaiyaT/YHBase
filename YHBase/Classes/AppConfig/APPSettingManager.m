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
    
    
    [BBXDBManager addTableName:@"tab_setting" andSQLStr:@"CREATE TABLE IF NOT EXISTS tab_setting (id INTEGER PRIMARY KEY, json TEXT)"];
    
    if(![BBXDBManager isExitAtTable:@"tab_setting" withDataDic:@{@"id":@(0)}])
    {
        [BBXDBManager insetDataDic:saveDic toTable:@"tab_setting"];
    }
    else
    {
        [BBXDBManager updateTableType:@"tab_setting" withWhereDic:@{@"id":@(0)} andUpdateValue:saveDic];
    }
    
}



/** 字体大小调整之后需要调整的高度*/
- (NSInteger)fontAdjuestToAddHeight
{
    if(self.appFont == FontSize_Big)
    {
        return 1;
    }
    else if (self.appFont == FontSize_Biger)
    {
        return 2;
    }
    else if (self.appFont == FontSize_Bigest)
    {
        return 3;
    }
    return 0;
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


+ (NSArray *)skinColorList
{
    return @[@"3A3A3A",@"faa932",@"111111",@"8cbb19",@"535353",@"8d8d8d",@"00aaee",@"a686ba",@"8992c8",@"e89abe",@"e16531"];
}


@end
