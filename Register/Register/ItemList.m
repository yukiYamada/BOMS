//
//  ViewController.m
//  Register
//
//  Created by 山田 勇気 on 12/11/03.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "ItemList.h"

@interface ItemList ()
@end

@implementation ItemList
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
    //商品の引き渡し
    [delegate_ itemList_itemCode:[self getItemCode:value_]];
    [delegate_ itemList_itemName:[self getItemName:value_]];
    [delegate_ itemList_itemValue:[self getItemValue:value_]];
    //値引率の引き渡し
    if ( [[self txtDiscountValue].text isEqualToString:@""]){
        [delegate_ itemList_discountValue:0];
    }
    else{
        [delegate_ itemList_discountValue:[[self txtDiscountValue].text intValue]];
    }
    //個数の引き渡し
    if ( [[self txtItemCount].text isEqualToString:@""]){
        [delegate_ itemList_itemCount:1];
    }
    else{
        [delegate_ itemList_itemCount:[[self txtItemCount].text intValue]];
    }
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
    return @"商品一覧";
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
//ItemCode取得
-(NSString*)getItemCode:(NSString*)value{
    NSMutableString *strRet = [NSMutableString stringWithFormat:@""];
    strRet = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:0]];
    return strRet;
}
//ItemName取得
-(NSString*)getItemName:(NSString*)value{
    NSMutableString *strRet = [NSMutableString stringWithFormat:@""];
    strRet = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:1]];
    return strRet;
}
//ItemValue取得
-(NSInteger)getItemValue:(NSString*)value{
    NSInteger intRet = 0;
    NSMutableString *strWork = [NSMutableString stringWithFormat:@""];
    strWork = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:2]];
    intRet = [Common replaceJPYToNSInteger:strWork];
    return intRet;
}
//商品マスタの取得
-(NSMutableArray*)getShohinMst{
    //todo商品マスタ取得処理
    return [NSMutableArray arrayWithObjects:@"商品コード：C1，商品名：カット，単価：￥3,000", @"商品コード：P1，商品名：パーマ，単価：￥5,000",nil];
}
@end
