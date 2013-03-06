//
//  updateinfo.h
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface updateinfo : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextField *passwordTxt;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UITextField *birthdayTxt;
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UITextField *emailTxt;
}
- (IBAction)donePress:(id)sender;

- (IBAction)backing:(id)sender;

- (IBAction)datePickerChange:(id)sender;





@end
