//
//  registerview.m
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "registerview.h"
#import "JSONParser.h"


@implementation registerview

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
    [email release];
    [passwrd release];
    [birthdate release];
    [indicator release];
    [datePicke release];
    [toolbar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
  email.text=  [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
   passwrd.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"passwrd"];
  birthdate.text=  [[NSUserDefaults standardUserDefaults]valueForKey:@"birthdate"];

    
    self.navigationItem.title=@"registerview";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [email release];
    email = nil;
    [passwrd release];
    passwrd = nil;
    [birthdate release];
    birthdate = nil;
    [indicator release];
    indicator = nil;
    [datePicke release];
    datePicke = nil;
    [toolbar release];
    toolbar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    if (textField.tag==3) {
        [passwrd resignFirstResponder];
        [email resignFirstResponder];
        datePicke.hidden=FALSE;
        toolbar.hidden=FALSE;
        return NO;
    }
    return YES;

}


- (IBAction)registrationclik:(id)sender {
    
   
    
    if (![email.text length]) {
        UIAlertView *alr=  [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alr show];
        [alr release];

        
    }else if(![passwrd.text length]){
    
        UIAlertView *alr=  [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alr show];
        [alr release];

    }else if(![birthdate.text length]){
        UIAlertView *alr=  [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Date of Birth" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alr show];
        [alr release];

    
    }
    
    
    [indicator startAnimating];
    
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/NewUser.php?email=%@&pwd=%@&birth=%@",email.text,passwrd.text,birthdate.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);
    
}

- (IBAction)pickerchanged:(UIDatePicker*)sender {
    
    NSDateFormatter *form = [[NSDateFormatter alloc]init];
    [form setDateStyle:NSDateFormatterShortStyle];
    birthdate.text = [form stringFromDate:datePicke.date];
    
}

- (IBAction)donePress:(id)sender {
    
    datePicke.hidden=TRUE;
    toolbar.hidden=TRUE;

}

-(void)newsParse:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    
    [indicator stopAnimating];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:email.text forKey:@"email"];
    [[NSUserDefaults standardUserDefaults]setValue:passwrd.text forKey:@"passwrd"];
    [[NSUserDefaults standardUserDefaults]setValue:birthdate.text forKey:@"birthdate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIAlertView *alr=  [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@",[dic valueForKey:@"ReturnMessage"]] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alr show];
    [alr release];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
