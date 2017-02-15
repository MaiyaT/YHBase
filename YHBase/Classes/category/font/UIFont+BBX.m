//
//  UIFont+BBX.m
//  BangBangXing
//
//  Created by 林宁宁 on 15/7/4.
//  Copyright (c) 2015年 蓝海(福建)信息技术有限公司. All rights reserved.
//

#import "UIFont+BBX.h"
#import "MacroAppInfo.h"
#import "APPSettingManager.h"

@implementation UIFont (BBX)


+ (UIFont *)defaultButtonFont
{
    if([APPSettingManager shareManager].appFontName)
    {
        return [self bbxSystemFont:14 withFontName:[APPSettingManager shareManager].appFontName];
    }
    else
    {
        return [UIFont systemFontOfSize:[self fontSize:14]];
    }
}

+(UIFont *)bbxSystemFont:(float)size
{
    if([APPSettingManager shareManager].appFontName)
    {
        return [self bbxSystemFont:size withFontName:[APPSettingManager shareManager].appFontName];
    }
    else
    {
        return [UIFont systemFontOfSize:[self fontSize:size]];
    }
}

+(UIFont *)bbxBoldSystemFont:(float)size
{
    if([APPSettingManager shareManager].appFontName)
    {
        return [self bbxSystemFont:size withFontName:[APPSettingManager shareManager].appFontName];
    }
    else
    {
        return [UIFont boldSystemFontOfSize:[self fontSize:size]];
    }
}


+(UIFont *)bbxSystemFont:(float)size withFontName:(NSString *)fontName
{
    return [UIFont fontWithName:fontName size:[self fontSize:size]];
}

+ (CGFloat)fontSize:(CGFloat)oldFont
{
    switch ([APPSettingManager shareManager].appFont) {
        case FontSize_Normal:
            oldFont = oldFont;
            break;
        case FontSize_Small:
            oldFont = oldFont-1;
            break;
        case FontSize_Smallest:
            oldFont = oldFont-2;
            break;
        case FontSize_Big:
            oldFont = oldFont+2;
            break;
        case FontSize_Biger:
            oldFont = oldFont+4;
            break;
        case FontSize_Bigest:
            oldFont = oldFont+6;
            break;
            
        default:
            break;
    }
    
    if([MacroAppInfo isiPhone5_5Inch])
    {
        return oldFont;
    }
    return oldFont;
}


@end
