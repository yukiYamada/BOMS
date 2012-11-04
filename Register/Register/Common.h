//
//  WaitSales.h
//  Register
//
//  Created by 山田 勇気 on 12/10/16.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Common:NSObject
    +(NSString*)convertNSNumberToJPY:(NSNumber*)value;
    +(NSString*)convertNSIntegerToJPY:(NSInteger)value;
    +(NSInteger)replaceJPYToNSInteger:(NSString*)strValue;
    +(NSString*)replaceJPYToNSString:(NSString*)strValue;
    +(BOOL)isNumber:(NSString*)value;

@end
