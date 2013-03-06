//
//  chekinfoview.h
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface chekinfoview : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UITableView *myTable;
    IBOutlet UITextField *email;
    IBOutlet UITextView *textView;
    
    NSMutableArray*    detailArry;
}
- (IBAction)doneClicked:(id)sender;

@end
