//
//  ViewController.h
//  Register
//
//  Created by 山田 勇気 on 12/11/03.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCommon.h"

@protocol CUListDelegate<NSObject>
-(void)CUList_CUCode:(NSString*) CUCode;
-(void)CUList_CUName:(NSString*) CUName;
@end

@interface CUList : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    __unsafe_unretained id <CUListDelegate> delegate_;
    NSInteger intKidoMode_;  //起動モード
    NSMutableArray *stringArray_;
}
@property (assign,nonatomic) NSInteger intKidoMode;
@property (nonatomic,assign) id<CUListDelegate> delegate;
@property(nonatomic,retain) NSMutableArray *stringArray;
/***************UI********************************/
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
