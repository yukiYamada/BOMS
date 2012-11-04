//
//  ViewController.h
//  Register
//
//  Created by 山田 勇気 on 12/11/03.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef enum _KidoMode{
    KIDOMODE_EDIT = 0,
    KIDOMODE_SEEK = 1
}KidoMode;
@interface DBCommon:NSObject
+(NSString*)subStringDBValue:(NSString*)value location:(NSInteger)location;
@end