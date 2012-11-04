//
//  ViewController.h
//  Register
//
//  Created by 山田 勇気 on 12/11/03.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCommon.h"
#import "Common.h"

@protocol itemListDelegate<NSObject>
-(void)itemList_itemCode:(NSString*) itemCode;
-(void)itemList_itemName:(NSString*) itemName;
-(void)itemList_itemValue:(NSInteger) itemValue;
-(void)itemList_discountValue:(NSInteger) discountValue;
-(void)itemList_itemCount:(NSInteger) itemCount;
@end

@interface ItemList : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    __unsafe_unretained id <itemListDelegate> delegate_;
    NSInteger intKidoMode_;  //起動モード
    NSMutableArray *stringArray_;
}
@property (assign,nonatomic) NSInteger intKidoMode;
@property (nonatomic,assign) id<itemListDelegate> delegate;

@property(nonatomic,retain) NSMutableArray *stringArray;
/***************UI********************************/
@property (weak, nonatomic) IBOutlet UITextField *txtDiscountValue;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *txtItemCount;
@end
