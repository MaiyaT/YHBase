//
//  APPSettingManager.h
//  Pods
//
//  Created by 林宁宁 on 2017/2/15.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FontSize)
{
    /** 正常*/
    FontSize_Normal,
    /** 较小*/
    FontSize_Small,
    /** 小*/
    FontSize_Smallest,
    /** 较大*/
    FontSize_Big,
    
    /** 大*/
    FontSize_Biger,
    
    /** 非常大*/
    FontSize_Bigest
};

@interface APPSettingManager : NSObject


+ (instancetype)shareManager;

+ (NSDictionary *)readFormLocal;

- (void)saveTolocal;


+ (NSArray *)skinColorList;

+ (NSArray *)skinFontStyleList;



/**
 *  文字大小
 */
@property (assign, nonatomic) FontSize appFont;
/**
 *  app的字体名字
 */
@property (copy, nonatomic) NSString * appFontName;
/**
 *  app的字体名字
 */
@property (assign, nonatomic) NSInteger appSkin;

/** 字体大小调整之后需要调整的高度*/
- (NSInteger)fontAdjuestToAddHeight;

@end
