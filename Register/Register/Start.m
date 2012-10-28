//
//  Start.m
//  Register
//
//  Created by 山田 勇気 on 12/10/16.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "Start.h"

@interface Start ()
@end

@implementation Start
- (void)viewDidLoad
{
    [super viewDidLoad];
    //会計メイン画面起動
    [self showAccounts:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
}
//会計メイン画面起動処理
- (void)showAccounts:(BOOL)blnOnTraining
{
    if (blnOnTraining) {
        //練習モードで起動
    }else{
        //通常モードで起動
        [self performSegueWithIdentifier:@"btnStartClick" sender:self];
    };
}
@end

