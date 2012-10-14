//
//  ViewController.m
//  testprogram
//
//  Created by 山田 勇気 on 12/10/14.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnclick:(id)sender {
    NSString *strMessage = [[self txtMessage] text];
    UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"TITLE" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
}

@end
