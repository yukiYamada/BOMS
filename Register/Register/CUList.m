//
//  ViewController.m
//  Register
//
//  Created by 山田 勇気 on 12/11/03.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "CUList.h"

@interface CUList ()
@end

@implementation CUList
@synthesize stringArray = stringArray_;
@synthesize myTableView;
@synthesize delegate = delegate_;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFrom];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*************************テーブルビューのデリゲート*****************/
//削除の実装
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}
//セクション数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (stringArray_ == nil){
        return 0;
    }
    else{
        return stringArray_.count;
    }
}
//セル選択
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //呼び出し元に選択セルを返却
    NSInteger row_ = [indexPath row];
    NSString *value_ = [stringArray_ objectAtIndex:row_];
    [delegate_ CUList_CUCode:[DBCommon subStringDBValue:value_ location:0]];
    [delegate_ CUList_CUName:[DBCommon subStringDBValue:value_ location:1]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//セル初期表示
- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellValue";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell =[[UITableViewCell alloc]
               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *cellValue = [stringArray_ objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    return cell;
}
//ヘッダー
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"お客様一覧";
}
//フッター
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}
/*************************メソッド**********************/
//init
-(void)initFrom{
    stringArray_ = [[NSMutableArray alloc]init];
    stringArray_ = [self getShohinMst];
    [myTableView reloadData];
}
//商品マスタの取得
-(NSMutableArray*)getShohinMst{
    //todo商品マスタ取得処理
    return [NSMutableArray arrayWithObjects:@"CＵコード：１，お客様名：山田　太郎", @"CＵコード：２，お客様名：山田　花子",nil];
}
@end
