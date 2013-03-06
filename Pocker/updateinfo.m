//
//  updateinfo.m
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "updateinfo.h"
#import "JSONParser.h"
#import "registerview.h"


@implementation updateinfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [emailTxt release];
    [passwordTxt release];
    [birthdayTxt release];
    [indicator release];
    [toolbar release];
    [datePicker release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    emailTxt.text=  [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
//    if (emailTxt.text) {
//        
//    }else {
//        
//        registerview *re = [[registerview alloc]init];
//        [self.navigationController pushViewController:re animated:YES];
//        [re release];
//        
//    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{

    self.title=@"Atualizar Dados";

    
}



- (void)viewDidUnload
{
    [emailTxt release];
    emailTxt = nil;
    [passwordTxt release];
    passwordTxt = nil;
    [birthdayTxt release];
    birthdayTxt = nil;
    [indicator release];
    indicator = nil;
    [toolbar release];
    toolbar = nil;
    [datePicker release];
    datePicker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;

}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField.tag==3) {
        [passwordTxt resignFirstResponder];
        [emailTxt resignFirstResponder];
        datePicker.hidden=FALSE;
        toolbar.hidden=FALSE;
        return NO;
    }
    return YES;
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)newsParse:(NSDictionary*)dic
{
    
    [indicator stopAnimating];
    UIAlertView *alr = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@",[dic valueForKey:@"ReturnMessage"]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alr show];
    [alr release];
    
 //   [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)donePress:(id)sender {
    
    [indicator startAnimating];
    
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/UpdateUserInfo.php?email=%@&pwd=%@&birth=%@",emailTxt.text,passwordTxt.text,birthdayTxt.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);
}

- (IBAction)backing:(id)sender {
    
    datePicker.hidden=TRUE;
    toolbar.hidden=TRUE;

}

- (IBAction)datePickerChange:(id)sender {
    
    NSDateFormatter *form = [[NSDateFormatter alloc]init];
    [form setDateStyle:NSDateFormatterShortStyle];
    birthdayTxt.text = [form stringFromDate:datePicker.date];
    

}



    
    
@end
