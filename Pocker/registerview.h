//
//  registerview.h
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface registerview : UIViewController  <UITextFieldDelegate> {
    
    
    IBOutlet UIDatePicker *datePicke;
    IBOutlet UIActivityIndicatorView *indicator;
    
    IBOutlet UITextField *passwrd;
    IBOutlet UITextField *email;
    
    IBOutlet UIToolbar *toolbar;
    IBOutlet UITextField *birthdate;
    
}
- (IBAction)registrationclik:(id)sender;

- (IBAction)pickerchanged:(id)sender;
- (IBAction)donePress:(id)sender;


@end
