//
//  onIphone.h
//  VideoApp
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKStoreManager.h"


@interface onIphone : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,MKStoreKitDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    
    
    
    IBOutlet UIButton *askToProBtn;
    IBOutlet UIPickerView *picker;
    IBOutlet UITextView *textbox;
    IBOutlet UILabel *dateLabel;
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UILabel *moreInfiLabel;
    IBOutlet UITableViewCell *moreInfocell;
    IBOutlet UITableView *myTable;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UITextView *quesText;
    IBOutlet UITextView *answerText;
    NSMutableArray *moreQueArry;
    
    IBOutlet UIToolbar *toolPicker;
    NSMutableArray *pickerArry;
    
    
    int articleID;

    
    
    
}


- (void)productPurchased:(NSString *)productId;

- (IBAction)backPressedPicker:(id)sender;

- (IBAction)askToProPressed:(id)sender;


- (IBAction)backPress:(id)sender;

- (IBAction)sendPressed:(id)sender;

@end
