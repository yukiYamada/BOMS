//
//  WaitSales.h
//  Register
//
//  Created by 山田 勇気 on 12/10/16.
//  Copyright (c) 2012年 山田 勇気. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "ItemList.h" //商品検索用
#import "CUList.h" //お客様検索用
//メッセージ用のタグ列挙体
typedef enum _AlertTag{
    ALERTTAG_DEFAULT = 0,
    ALERTTAG_AC = 1,
    ALERTTAG_AC_ONCUSEARCH =2
}AlertTag;
//フォーカスタグ列挙体
typedef enum _ForcusTag{
    FORCUSTAG_DEFAULT = 0,
    FORCUSTAG_CUCODE = 1,
    FORCUSTAG_CUNAME = 2,
    FORCUSTAG_ITEMCODE=3,
    FORCUSTAG_ITEMNAME=4,
    FORCUSTAG_ITEMVALUE=5,
    FORCUSTAG_ITEMCOUNT=6,
    FORCUSTAG_DISCOUNT=7,
    FORCUSTAG_PAYMENT=8
}ForcusTag;
@interface Accounts : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,itemListDelegate,CUListDelegate>{
    @private
    NSMutableArray *stringArray_; //会計明細と連動
    UITableView *myTableView_; //会計明細テーブルビュー
    BOOL blnEditing_; //会計中かどうか（YES:会計中）
    NSInteger intNowForcusTag_; //現在のフォーカスTag
}
//会計明細リスト
@property (nonatomic,retain) NSMutableArray *stringArray;
/********UI object******/
//日付
@property (weak, nonatomic) IBOutlet UIDatePicker *dapNow;
//請求金額、預かり金の差
@property (weak, nonatomic) IBOutlet UILabel *lblPayment;
//預かり金
@property (weak, nonatomic) IBOutlet UITextField *txtPayment;
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
//商品個数
@property (weak, nonatomic) IBOutlet UITextField *txtItemCount;
//合計金額
@property (weak, nonatomic) IBOutlet UILabel *lblTotalValue;
/*****ITEMボタン*******/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemAC;
//候補ボタン
@property (weak, nonatomic) IBOutlet UIBarButtonItem *itemKoho;
@end
