//
//  WaitSales.m
//  Register
//
//  Created by 山田 勇気 on 12/10/16.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import "Accounts.h"

@interface Accounts()

@end

@implementation Accounts
@synthesize stringArray;
@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initForm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*************************テーブルビューのデリゲート*****************/
//セクション数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (stringArray == nil){
        return 0;
    }
    else{
        return stringArray.count;
    }
}

//セル初期表示
- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellValue";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell =[[UITableViewCell alloc]
               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *cellValue = [stringArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    return cell;
}
//ヘッダー
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"会計明細";
}
//フッター
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}
/*******************アラートのデリゲート***************/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch(alertView.tag){
        case ALERTTAG_AC:
            //AllClear
            switch (buttonIndex){
                case 0:
                    //OK押下
                    [self initForm];
                    break;
                case 1:
                    //キャンセル押下
                    break;
                default:
                    break;
            }
            break;
        case ALERTTAG_DEFAULT:
            //処理なし
            break;
    }
}
/******************テキストフィールドのデリゲート***********/
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*******************イベント************************/

//商品追加ボタン押下
- (IBAction)btnAddItem_TouchUpInside:(id)sender {
    [self.view endEditing:YES];
    //入力チェック
    if([self checkIsAddItem]){
        //OK
        //会計中か確認
        if (blnEditing){
            //処理なし
        }
        else{
            blnEditing = YES;
        }
        //金額の算出
        NSInteger intItemValue = 0;
        if ([[self txtDisCountValue].text intValue] == 0){
            //値引率なし
            intItemValue = [[self txtItemValue].text intValue];
        }
        else{
            intItemValue = [[self txtItemValue].text intValue] * 0.01 * (100-[[self txtDisCountValue].text intValue]);
        }
        //テーブルの表示
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self stringArray].count inSection:0];
        NSArray *indexPaths =[NSArray arrayWithObjects:indexPath, nil];
        [stringArray addObject:[self createItemString:
                                    [self txtItemCode].text
                                    ItemName:[self txtItemName].text
                                    ItemValue:[NSString stringWithFormat:@"%d",intItemValue]
                                    ItemDisCountValue:[self txtDisCountValue].text
                                ]];
        [myTableView beginUpdates];
        [myTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [myTableView endUpdates];
        [myTableView reloadData];
        //商品合計の算出
        NSInteger intTotalValue = [self replaceJPY:[self lblTotalValue].text];
        intTotalValue +=intItemValue;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [formatter setCurrencyCode:@"JPY"];
        [self lblTotalValue].text = [formatter stringForObjectValue:[NSNumber numberWithInteger:intTotalValue]];
        //入力エリアのクリア
        [self initItemArea];
    }
    else{
        //処理なし
    }
    
}
//確定してお支払いへボタン押下
- (IBAction)btnTopayment_TouchUpInside:(id)sender {
    [self.view endEditing:YES];
    [self moveToPayment];
}
//確定ボタン押下
- (IBAction)enter_Click:(id)sender {
    [self.view endEditing:YES];
    [self moveToPayment];
}
//ItemＡCボタン押下
- (IBAction)AC_Click:(id)sender {
    [self.view endEditing:YES];
    //編集中かどうか確認
    if (blnEditing){
        
        //メッセージ表示処理
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"編集中のデータを削除します。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        Alert.tag = ALERTTAG_AC;
        [Alert show];
    }
}

/***;******************メソッド**********************/
//Init
- (void)initForm{
    stringArray = [[NSMutableArray alloc]init];
    blnEditing = NO;
    [self initCUArea];
    [self initItemArea];
    [myTableView reloadData];
}
//お客様情報エリアのInit
- (void)initCUArea{
    [self txtCUCode].text = @"";
    [self txtCUName].text = @"";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"JPY"];
    [self lblTotalValue].text = [formatter stringForObjectValue:[[NSNumber alloc]initWithShort:0]];
}
//商品情報エリアのInit
- (void)initItemArea{
    [self txtItemCode].text = @"";
    [self txtItemName].text = @"";
    [self txtItemValue].text = @"";
    [self txtDisCountValue].text =@"";
}
//￥表記から数値のみを切り出す
- (NSInteger)replaceJPY:(NSString*)strValue{
    NSMutableString *strRet = [[NSMutableString alloc]initWithString:strValue];
    [strRet deleteCharactersInRange:NSMakeRange(0,1)];
    [strRet setString:[strRet stringByReplacingOccurrencesOfString:@"," withString:@""]];
    return [strRet intValue];
}
//商品詳細文字列の作成
- (NSString*)createItemString:(NSString*)ItemCode ItemName:(NSString*)ItemName ItemValue:(NSString*)ItemValue ItemDisCountValue:(NSString*)ItemDisCountValue{
    NSMutableString *strRet = [NSMutableString string];
    NSNumber* numItemValue = 0;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"JPY"];
   
    [strRet appendString:[NSString stringWithFormat:@"商品コード：%@",ItemCode]];
    [strRet appendString:@","];
    [strRet appendString:[NSString stringWithFormat:@"商品名：%@",ItemName]];
    [strRet appendString:@","];
    numItemValue = [NSNumber numberWithInt:[ItemValue intValue]];
    [strRet appendString:[NSString stringWithFormat:@"金額：%@",[formatter stringForObjectValue:numItemValue]]];
    if ([ItemDisCountValue intValue]==0){
     //値引き率なし
    }
    else{
     //値引き率あり
        [strRet appendString:[NSString stringWithFormat:@"（値引率 %@％）",ItemDisCountValue]];
    }
        return strRet;
}

//商品追加時のチェック
- (BOOL)checkIsAddItem{
    //商品コードのチェック
    if ([[self txtItemCode].text isEqualToString: @""]){
        //入力値なし
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"商品コードが入力されていません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return false;
    }
    //商品名のチェック
    if ([[self txtItemName].text isEqualToString: @""]){
        //入力値なし
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"商品名が設定されていません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return false;
    }
    //金額のチェック
    if ([[self txtItemValue].text isEqualToString: @""]){
        //入力値なし
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"金額がセットされていません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return false;
    }
    //値引率のチェック
    //未入力でOK
    return true;
}
//お支払い画面移動時のチェック
- (BOOL)checkIsMoveToPayment{
    if (blnEditing){
        return YES;
    }
    else{
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"会計情報が未入力です" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return FALSE;
    }
}
//お支払い画面への遷移
- (void)moveToPayment{
    //移動可能かチェック
    if ([self checkIsMoveToPayment]){
        //移動可能
        [self performSegueWithIdentifier:@"movePayment" sender:self];
    }
    else{
        //移動不可
    }
}
@end