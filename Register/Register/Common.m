//
//  common.m
//  Register
//
//  Created by 山田 勇気 on 12/11/04.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "Common.h"
@implementation Common
+(NSString*) convertNSIntegerToJPY:(NSInteger)value{
    NSNumber *numValue = [NSNumber numberWithInt:value];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"JPY"];
    return [formatter stringForObjectValue:numValue];
}
+(NSString*) convertNSNumberToJPY:(NSNumber*)value{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"JPY"];
    return [formatter stringForObjectValue:value];
}
//￥表記から数値のみを切り出す
+ (NSInteger)replaceJPYToNSInteger:(NSString *)strValue{
    NSMutableString *strRet = [[NSMutableString alloc]initWithString:strValue];
    [strRet deleteCharactersInRange:NSMakeRange(0,1)];
    [strRet setString:[strRet stringByReplacingOccurrencesOfString:@"," withString:@""]];
    return [strRet intValue];
}
//￥表記から数値のみを切り出す
+ (NSString*)replaceJPYToNSString:(NSString*)strValue{
    NSMutableString *strRet = [[NSMutableString alloc]initWithString:strValue];
    [strRet deleteCharactersInRange:NSMakeRange(0,1)];
    [strRet setString:[strRet stringByReplacingOccurrencesOfString:@"," withString:@""]];
    return strRet;
}
//数値チェック
+(BOOL)isNumber:(NSString*)value{
    BOOL blnRet = NO;
    if (value ==nil || [value isEqualToString:@""]){
        return YES;
    }
    for (int i =0; i < [value length];i++){
        NSString *strWork = [[value substringFromIndex:i]substringToIndex:1];
        const char *chrWork = [strWork cStringUsingEncoding:NSASCIIStringEncoding];
        
        if( chrWork == NULL){
            blnRet = NO;
            break;
        }
        if ((chrWork[0] >= 0x30) && (chrWork[0] <= 0x39)){
            blnRet = YES;
        }else{
            blnRet = NO;
            break;
        }
    }
    return blnRet;
}

@end