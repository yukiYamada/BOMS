//  Register
//
//  Created by 山田 勇気 on 12/11/03.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "DBCommon.h"

@implementation DBCommon
+(NSString*)subStringDBValue:(NSString *)value location:(NSInteger)location{
    NSMutableString *strRet = [NSMutableString stringWithFormat:@""];
    NSMutableArray *itemArray_ = [NSMutableArray array];
    itemArray_ = [NSMutableArray arrayWithArray:[value componentsSeparatedByString:@"，"]];
    NSMutableArray *workArray_ = [NSMutableArray array];
    workArray_ = [NSMutableArray arrayWithArray:[(NSString*)itemArray_[location] componentsSeparatedByString:@"："]];
    strRet = workArray_[1];
    return strRet;
}
@end