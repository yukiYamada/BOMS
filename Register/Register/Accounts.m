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
@synthesize stringArray = stringArray_;
@synthesize myTableView = myTableView_;
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
    //タグの設定
    [self txtCUCode].tag = FORCUSTAG_CUCODE;
    [self txtCUName].tag = FORCUSTAG_CUNAME;
    [self txtItemCode].tag = FORCUSTAG_ITEMCODE;
    [self txtItemName].tag = FORCUSTAG_ITEMNAME;
    [self txtItemValue].tag = FORCUSTAG_ITEMVALUE;
    [self txtItemCount].tag = FORCUSTAG_ITEMCOUNT;
    [self txtDisCountValue].tag = FORCUSTAG_DISCOUNT;
    [self txtPayment].tag = FORCUSTAG_PAYMENT;
    //画面の初期
    [self initForm];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*************************テーブルビューのデリゲート*****************/
//削除の実装
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self deleteItem:indexPath];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert){
    }
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

//セル初期表示
- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellValue";
    UITableViewCell *cell = [myTableView_ dequeueReusableCellWithIdentifier:cellIdentifier];
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
        case ALERTTAG_AC_ONCUSEARCH:
            switch (buttonIndex){
                case 0:
                    //OK押下
                    [self initForm];
                    [self showModalCUListView];
                    break;
                case 1:
                    //キャンセル押下
                    break;
                default:
                    break;
            }
        case ALERTTAG_DEFAULT:
            //処理なし
            break;
    }
}
/******************テキストフィールドのデリゲート***********/
//Retun
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//編集開始
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //共通処理
    //タグの設定
    intNowForcusTag_ = textField.tag;
    //全選択
    UITextPosition *fromPosition_ = [textField beginningOfDocument];
    UITextPosition *ToPosition_ = [textField endOfDocument];
    UITextRange *newRange_ = [textField textRangeFromPosition:fromPosition_ toPosition:ToPosition_];
    textField.selectedTextRange = newRange_;
    switch(textField.tag ){
        case FORCUSTAG_CUCODE:
            break;
        case FORCUSTAG_CUNAME:
            break;
        case FORCUSTAG_ITEMCODE:
            break;
        case FORCUSTAG_ITEMNAME:
            break;
        case FORCUSTAG_ITEMVALUE:
            break;
        case FORCUSTAG_ITEMCOUNT:
            break;
        case FORCUSTAG_DISCOUNT:
            break;
        case FORCUSTAG_PAYMENT:
            break;
    }
    return YES;
}
//編集終了
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    //共通処理
    [textField endEditing:YES];
    switch(textField.tag ){
        case FORCUSTAG_CUCODE:
            [self itemKoho].enabled = YES;
            break;
        case FORCUSTAG_CUNAME:
            break;
        case FORCUSTAG_ITEMCODE:
            [self itemKoho].enabled = YES;
            break;
        case FORCUSTAG_ITEMNAME:
            break;
        case FORCUSTAG_ITEMVALUE:
            [self txtItemValue].text = [NSString stringWithFormat:@"%d",[[self txtItemValue].text intValue]];
            break;
        case FORCUSTAG_ITEMCOUNT:
            [self txtItemCount].text = [NSString stringWithFormat:@"%d",[[self txtItemValue].text intValue]];
            break;
        case FORCUSTAG_DISCOUNT:
            [self txtDisCountValue].text = [NSString stringWithFormat:@"%d",[[self txtDisCountValue].text intValue]];
            break;
        case FORCUSTAG_PAYMENT:
            //差額の再計算
            [self txtPayment].text = [NSString stringWithFormat:@"%d",[[self txtPayment].text intValue]];
            [self sumTotal:0];
            break;
    }
    return YES;
}
//入力制御
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    switch(textField.tag ){
        case FORCUSTAG_CUCODE:
            break;
        case FORCUSTAG_CUNAME:
            break;
        case FORCUSTAG_ITEMCODE:
            break;
        case FORCUSTAG_ITEMNAME:
            break;
        case FORCUSTAG_ITEMVALUE:
            if(![Common isNumber:string]){
                return NO;
            }
            break;
        case FORCUSTAG_ITEMCOUNT:
            if(![Common isNumber:string]){
                return NO;
            }
            break;
        case FORCUSTAG_DISCOUNT:
            if(![Common isNumber:string]){
                return NO;
            }
            break;
        case FORCUSTAG_PAYMENT:
            if(![Common isNumber:string]){
                return NO;
            }
            break;
    }
    return YES;
}
/**************************ItemListのデリゲート****************************/
-(void)itemList_discountValue:(NSInteger)discountValue{
    //値引率の取得
    [self txtDisCountValue].text = [NSString stringWithFormat:@"%d",discountValue];
}
-(void)itemList_itemCount:(NSInteger)itemCount{
    //個数の取得
    [self txtItemCount].text = [NSString stringWithFormat:@"%d",itemCount];
}
-(void)itemList_itemValue:(NSInteger)itemValue{
    //単価の取得
    [self txtItemValue].text = [NSString stringWithFormat:@"%d",itemValue];
}
-(void)itemList_itemCode:(NSString *)itemCode{
    [self txtItemCode].text = itemCode;
}
-(void)itemList_itemName:(NSString *)itemName{
    //商品名の取得
    [self txtItemName].text= itemName;
}
/**************************CUListのデリゲート****************************/
-(void)CUList_CUCode:(NSString *)CUCode{
    //お客様コード
    [self txtCUCode].text = CUCode;
}
-(void)CUList_CUName:(NSString *)CUName{
    //お客様名
    [self txtCUName].text = CUName;
}

/**************************segueのデリゲート****************************/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"moveItemList"]){
        ItemList *ItemList_ = (ItemList*)[segue destinationViewController];
        ItemList_.delegate = self;
    }else if ([[segue identifier] isEqualToString:@"moveCUList"]){
        ItemList *ItemList_ = (ItemList*)[segue destinationViewController];
        ItemList_.delegate = self;
    }
}
/*******************イベント************************/
//商品追加ボタン押下
- (IBAction)btnAddItem_TouchUpInside:(id)sender {
    [self.view endEditing:YES];
    [self addItem];
}
//確定してお支払いへボタン押下
- (IBAction)btnTopayment_TouchUpInside:(id)sender {
    [self.view endEditing:YES];
    if ([self checkIsPayment] ){
        [self enterAccounts];
    }
}
//確定ボタン押下
- (IBAction)enter_Click:(id)sender {
    [self.view endEditing:YES];
    if ([self checkIsPayment] ){
        [self enterAccounts];
    }
}
//ItemＡCボタン押下
- (IBAction)AC_Click:(id)sender {
    [self.view endEditing:YES];
    [self checkAllClear];
}
//Item候補ボタンクリック
- (IBAction)koho_Click:(id)sender {
    [self.view endEditing:YES];
    switch(intNowForcusTag_){
        case FORCUSTAG_CUCODE:
            //お客様検索
            //会計情報をクリアする
            [self checkAllClearOnCUSearch];
            break;
        case FORCUSTAG_ITEMCODE:
            [self showModalItemListView];
            break;
        case FORCUSTAG_DEFAULT:
            break;
    }
    //フォーカスを戻す
    [self setPreForcus];
}
/*********************メソッド**********************/
//リストアイテムの削除
- (void)deleteItem:(NSIndexPath*)indexPath{
    //削除後の合計額の計算
    NSInteger intDeleteItemValue = 0;
    intDeleteItemValue = ([self getItemValue:[stringArray_ objectAtIndex:indexPath.row]] * [self getItemCount:[stringArray_ objectAtIndex:indexPath.row]]) * -1;
    [self sumTotal:intDeleteItemValue];
    [stringArray_ removeObjectAtIndex:indexPath.row]; //削除ボタンの行を配列から削除
    [myTableView_ deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //削除後、アイテムが０なら未編集
    if(stringArray_.count == 0 ){
        blnEditing_ = NO;
    }
}
//Init
- (void)initForm{
    stringArray_ = [[NSMutableArray alloc]init];
    blnEditing_ = NO;
    [self initCUArea];
    [self initItemArea];
    [myTableView_ reloadData];
    [self sumTotal:0];
    [self itemKoho].enabled = NO;
    intNowForcusTag_ = FORCUSTAG_DEFAULT;
}
//フォーカスを戻す
-(void)setPreForcus{
    switch(intNowForcusTag_){
        case FORCUSTAG_DEFAULT:
            break;
        case FORCUSTAG_CUCODE:
            [self txtCUCode].selected = YES;
            break;
        case FORCUSTAG_CUNAME:
            [self txtCUName].selected =YES;
            break;
        case FORCUSTAG_ITEMCODE:
            [self txtItemCode].selected = YES;
            break;
    }
}
//お客様情報エリアのInit
- (void)initCUArea{
    [self txtCUCode].text = @"";
    [self txtCUName].text = @"";
    [self lblTotalValue].text = [Common convertNSIntegerToJPY:0];
    [self lblPayment].text = [Common convertNSIntegerToJPY:0];
    [self sumTotal:0];
}
//商品情報エリアのInit
- (void)initItemArea{
    [self txtItemCode].text = @"";
    [self txtItemName].text = @"";
    [self txtItemValue].text = @"";
    [self txtItemCount].text = @"";
    [self txtDisCountValue].text =@"";
}
//オールクリアの確認
- (void) checkAllClear{
    //編集中かどうか確認
    if (blnEditing_){
        
        //メッセージ表示処理
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"編集中のデータを削除します。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        Alert.tag = ALERTTAG_AC;
        [Alert show];
    }
}
//オールクリアの確認（お客様検索）
- (void) checkAllClearOnCUSearch{
    //編集中かどうか確認
    if (blnEditing_){
        
        //メッセージ表示処理
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"編集中のデータを削除します。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
        Alert.tag = ALERTTAG_AC_ONCUSEARCH;
        [Alert show];
    }else{
        //
        [self showModalCUListView];
    }
}
//商品追加
-(void)addItem{
    //入力チェック
    NSInteger intItemValue = 0;
    NSInteger intDiscount = 0;
    NSInteger intItemTotalValue = 0;
    NSInteger intItemCount = 1;
    if([self checkIsAddItem]){
        //OK
        //会計中か確認
        if (blnEditing_){
            //処理なし
        }
        else{
            blnEditing_ = YES;
        }
        //単価の算出
        if ([[self txtDisCountValue].text intValue] == 0){
            //値引率なし
            intItemValue = [[self txtItemValue].text intValue];
        }
        else{
            intItemValue = [[self txtItemValue].text intValue] * 0.01 * (100-[[self txtDisCountValue].text intValue]);
            intDiscount = [[self txtDisCountValue].text intValue];
        }
        //小計の算出

        if([[self txtItemCount].text isEqualToString:@""]){
            //個数指定なし
            intItemTotalValue = intItemValue;
        }else{
            //個数指定あり
            intItemTotalValue = intItemValue * [[self txtItemCount].text intValue];
            intItemCount = [[self txtItemCount].text intValue];
        }
        //テーブルの表示
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self stringArray].count inSection:0];
        NSArray *indexPaths =[NSArray arrayWithObjects:indexPath, nil];
        [stringArray_ addObject:[self createItemString:
                                 [self txtItemCode].text
                                              ItemName:[self txtItemName].text
                                             ItemValue:intItemValue
                                     ItemDisCountValue:intDiscount
                                             ItemCount:intItemCount
                                 ]];
        [myTableView_ beginUpdates];
        [myTableView_ insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [myTableView_ endUpdates];
        [myTableView_ reloadData];
        //商品合計の算出
        [self sumTotal:intItemTotalValue];
        //入力エリアのクリア
        [self initItemArea];
    }
    else{
        //処理なし
    }
}

//合計金額と差額の計算
- (void) sumTotal:(NSInteger)addValue
{
    NSInteger intTotalValue = 0;
    //現在の合計金額を計算
    intTotalValue = [Common replaceJPYToNSInteger:[self lblTotalValue].text];
    intTotalValue += addValue;
    //支払金との差を計算
    NSInteger intPaymentValue = 0;
    if ([[self txtPayment].text isEqualToString:@""]){
        //空白の場合は代入なし
    }
    else{
        intPaymentValue = [[self txtPayment].text intValue];
        if (intPaymentValue >= intTotalValue){
            intPaymentValue = 0;
        }else{
            intPaymentValue = intTotalValue - intPaymentValue;
        }
    }
    //合計金額の表示
    [self lblTotalValue].text = [Common convertNSIntegerToJPY:intTotalValue];
    //差額の表示
    [self lblPayment].text = [Common convertNSIntegerToJPY:intPaymentValue];
}
//商品詳細文字列の作成
- (NSString*)createItemString:(NSString*)ItemCode ItemName:(NSString*)ItemName ItemValue:(NSInteger)ItemValue ItemDisCountValue:(NSInteger)ItemDisCountValue ItemCount:(NSInteger)ItemCount{
    NSMutableString *strRet = [NSMutableString string];

    [strRet appendString:[NSString stringWithFormat:@"商品コード：%@",ItemCode]];
    [strRet appendString:@"，"];
    [strRet appendString:[NSString stringWithFormat:@"商品名：%@",ItemName]];
    [strRet appendString:@"，"];
    [strRet appendString:[NSString stringWithFormat:@"単価：%@",[Common convertNSIntegerToJPY:ItemValue]]];
    if (ItemDisCountValue==0){
     //値引き率なし
    }
    else{
     //値引き率あり
        [strRet appendString:[NSString stringWithFormat:@"（値引率 %d％）",ItemDisCountValue]];
    }
    [strRet appendString:[NSString stringWithFormat:@" × %d",ItemCount]];
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
//会計確定時のチェック
- (BOOL)checkIsPayment{
    //編集中か確認
    if (blnEditing_){
        //編集中
    }
    else{
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"会計情報が未入力です" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return NO;
    }
    //お預かり金が入力されているか確認
    if (([[self txtPayment].text intValue ]==0) || [[self txtPayment].text isEqualToString:@""]){
        //預かり金未入力
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"預かり金が不足しています。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return NO;
    }else if ([Common replaceJPYToNSInteger:[self lblPayment].text] != 0){
        //預かり金不足
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"メッセージ" message:@"預かり金が不足しています。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [Alert show];
        return NO;
    }
    else{
        return true;
    }
}
//会計確定処理
- (void)enterAccounts{
    
}
//商品コード取得
-(NSString*)getItemCode:(NSString*)value{
    NSMutableString *strRet = [NSMutableString stringWithFormat:@""];
    strRet = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:0]];
    return strRet;
}
//商品名取得
-(NSString*)getItemName:(NSString*)value{
    NSMutableString *strRet = [NSMutableString stringWithFormat:@""];
    strRet = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:1]];
    return strRet;
}
//単価取得
-(NSInteger)getItemValue:(NSString*)value{
    NSInteger intRet = 0;
    NSMutableString *strWork = [NSMutableString stringWithFormat:@""];
    strWork = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:2]];
    NSRange searchRange = [strWork rangeOfString:@"（"];
    if (searchRange.location == NSNotFound){
        //値引率なし
    }else{
        //値引率あり
        strWork = [NSMutableString stringWithString:[strWork substringToIndex:searchRange.location]];
    }
    intRet =  [Common replaceJPYToNSInteger:strWork];
    return intRet;
}
//個数取得
-(NSInteger)getItemCount:(NSString*)value{
    NSInteger intRet = 0;
    NSMutableString *strWork = [NSMutableString stringWithFormat:@""];
    strWork = [NSMutableString stringWithString:[DBCommon subStringDBValue:value location:2]];
    NSRange searchRange = [strWork rangeOfString:@"×"];
    if (searchRange.location == NSNotFound){
        //値引率なし
    }else{
        //値引率あり
        strWork = [NSMutableString stringWithString:[strWork substringFromIndex:searchRange.location + 1]];
    }
    intRet =  [Common replaceJPYToNSInteger:strWork];
    return intRet;
}
//候補リストの表示
-(void)showModalItemListView{
    [self performSegueWithIdentifier:@"moveItemList" sender:self];
}
//候補リストの表示
-(void)showModalCUListView{
    [self performSegueWithIdentifier:@"moveCUList" sender:self];
}
@end