//
//  chekinfoview.m
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "chekinfoview.h"
#import "JSONParser.h"
#import "registerview.h"

@implementation chekinfoview

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
    [textView release];
    [indicator release];
    [myTable release];
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
    
    
    email.text=  [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    
//    if (email.text) {
//        
//    }else {
//        
//        registerview *re = [[registerview alloc]init];
//        [self.navigationController pushViewController:re animated:YES];
//        [re release];
//        
//    }
//    

    
    detailArry = [[NSMutableArray alloc]init];
    
    self.title=@"Varificar Assinaturas";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{

}

- (void)viewDidUnload
{
    [email release];
    email = nil;
    [textView release];
    textView = nil;
    [indicator release];
    indicator = nil;
    [myTable release];
    myTable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor yellowColor];
    }
    if ([detailArry count]) {
        
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = [[detailArry objectAtIndex:0] valueForKey:@"UserEmail"];       

            break;
        }
        case 1:{
            cell.textLabel.text = [[detailArry objectAtIndex:0] valueForKey:@"UserPasswd"];       

            break;
        }
        case 2:{
            cell.textLabel.text = [[detailArry objectAtIndex:0] valueForKey:@"UserBirthDt"];       

            break;
        }
        case 3:{
            cell.textLabel.text = [[detailArry objectAtIndex:0] valueForKey:@"UserAskSubsc"];       

            break;
        }
        case 4:{
            cell.textLabel.text = [[detailArry objectAtIndex:0] valueForKey:@"UserHintSubsc"];       

            break;
        }
        default:
            break;
    }
        
        
    }

  
    // Configure the cell.
    
    return cell;
}





-(void)newsParse:(NSDictionary*)dic
{

    [indicator stopAnimating];
    textView.text = [NSString stringWithFormat:@"%@",dic];
    [detailArry removeAllObjects];
    [detailArry addObjectsFromArray:[dic valueForKey:@"ArrayOfInfo"]];
    
    [myTable reloadData];
    
    //[self.navigationController popViewControllerAnimated:YES];
    

}

- (IBAction)doneClicked:(id)sender {
    
    [indicator startAnimating];
    
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/GetUserInfo.php?email=%@",email.text];
    
    [[NSUserDefaults standardUserDefaults]setValue:email.text forKey:@"email"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);
}
@end
