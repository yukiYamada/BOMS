//
//  WaitSales.h
//  Register
//
//  Created by 山田 勇気 on 12/10/16.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "payment.h"
//メッセージ用のタグ列挙体
typedef enum _AlertTag{
    ALERTTAG_DEFAULT = 0,
    ALERTTAG_AC = 1
}AlertTag;
@interface Accounts : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
    NSMutableArray *stringArray; //会計明細と連動
    UITableView *myTableView; //会計明細テーブルビュー
    BOOL blnEditing; //会計中かどうか（YES:会計中）
}
//会計明細リスト
@property (nonatomic,retain) NSMutableArray *stringArray;
/********UI object******/
//テーブルビュー
@property (nonatomic,retain) IBOutlet UITableView *myTableView;
//お客様コード
@property (weak, nonatomic) IBOutlet UITextField *txtCUCode;
//お客様名
@property (weak, nonatomic) IBOutlet UITextField *txtCUName;
//商品コード
@property (weak, nonatomic) IBOutlet UITextField *txtItemCode;
//商品名
@property (weak, nonatomic) IBOutlet UITextField *txtItemName;
//価格
@property (weak, nonatomic) IBOutlet UITextField *txtItemValue;
//値引率
@property (weak, nonatomic) IBOutlet UITextField *txtDisCountValue;
//追加ボタン
@property (weak, nonatomic) IBOutlet UIButton *btnAddItem;
//確定してお支払いへ
@property (weak, nonatomic) IBOutlet UIButton *btnTopayment;
//合計金額
@property (weak, nonatomic) IBOutlet UILabel *lblTotalValue;
//削除ボタン
@property (weak, nonatomic) IBOutlet UIButton *btnDelItem;
/*****ITEMボタン*******/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemAC;
@end
