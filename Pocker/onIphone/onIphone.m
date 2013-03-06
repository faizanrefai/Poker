//
//  onIphone.m
//  VideoApp
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "onIphone.h"
#import "JSONParser.h"
#import "registerview.h"
#import "HintDetail.h"



@implementation onIphone



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

    
    [myTable release];
    [answerText release];
    [quesText release];
    [moreInfocell release];
    [moreInfiLabel release];
    [indicator release];
    [dateLabel release];
    [textbox release];
    [toolbar release];
    [picker release];
    [askToProBtn release];
    [toolPicker release];
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
    moreQueArry = [[NSMutableArray alloc]init];
    pickerArry = [[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view from its nib.
    
    textbox.inputAccessoryView = toolbar;
    
    //self.title= @"";
    self.navigationItem.title =@"PERGUNTE AO PRO";

    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/GetPro.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(WSParsed:) andHandler:self]; 
    NSLog(@"%@",parser);

    
}

-(void)WSParsed:(NSDictionary*)dic
{

    NSLog(@"%@",[dic valueForKey:@"ArrayOfPros"]);

    [pickerArry addObjectsFromArray:[dic valueForKey:@"ArrayOfPros"]];
    [picker reloadAllComponents] ;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if (pickerArry) {
        
        return [[pickerArry objectAtIndex:row] valueForKey:@"ProName"];

    }else {
        return @"loading";
    }

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return [pickerArry count];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (pickerArry) {
        
        [askToProBtn setTitle:[[pickerArry objectAtIndex:row] valueForKey:@"ProName"]  forState:UIControlStateNormal];
        
    }else {
    }

    

}

-(void)viewWillAppear:(BOOL)animated
{
    [indicator startAnimating];
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/GetQuestion.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(newsParse:) andHandler:self]; 
    NSLog(@"%@",parser);

    
    
}

-(void)newsParse:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    
    [moreQueArry removeAllObjects];
    [moreQueArry addObjectsFromArray:[[[dic valueForKey:@"ArrayOfQuestions"] objectAtIndex:0] valueForKey:@"ArrayOfMore"]];
    
    
    quesText.text = [[[dic valueForKey:@"ArrayOfQuestions"] objectAtIndex:0] valueForKey:@"QuestionText"];
    answerText.text = [[[dic valueForKey:@"ArrayOfQuestions"] objectAtIndex:0] valueForKey:@"QuestionAnswer"];
    dateLabel.text = [[[dic valueForKey:@"ArrayOfQuestions"] objectAtIndex:0] valueForKey:@"QuestionDate"];
    
    
    [myTable reloadData];
    [indicator stopAnimating];
    
}





/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreQueArry count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle]loadNibNamed:@"AskProCell" owner:self options:nil];
        cell=moreInfocell;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    }
    
    if ([moreQueArry count]) {
        
        moreInfiLabel.text = [[moreQueArry objectAtIndex:indexPath.row] valueForKey:@"MoreTitle"];
        
    }
    
    // Configure the cell.
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


- (IBAction)backPressedPicker:(id)sender {
    
    picker.hidden=TRUE;
    toolPicker.hidden=TRUE;

}

- (IBAction)askToProPressed:(id)sender {
    
    picker.hidden=FALSE;
    toolPicker.hidden=FALSE;
    
    
}

- (IBAction)backPress:(id)sender {
    
    
    [textbox resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    
    if (email) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
        
        [indicator startAnimating];
        
        NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/CheckUserArticle.php?email=%@&article=%@",email, [[moreQueArry objectAtIndex:indexPath.row] valueForKey:@"ArticleId"]];
        
        articleID = [[[moreQueArry objectAtIndex:indexPath.row] valueForKey:@"ArticleId"] intValue];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(articleChk:) andHandler:self]; 
        NSLog(@"%@",parser);
        
        
    }else {
        
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:nil message:@"Não há usuário registrado para efetuar a compra" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}


-(void)articleChk:(NSDictionary*)dic
{
    
    NSLog(@"%@",dic);
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;
    
    
    if ([[[[dic valueForKey:@"ArrayOfUserArticle"] objectAtIndex:0] valueForKey:@"Purchased"]isEqualToString:@"N"]) {
        
        [[MKStoreManager sharedManager] buyFeature:kFeatureA1Id];
        
    }
    else {
        HintDetail *de = [[HintDetail alloc]init];
        [self.navigationController pushViewController:de animated:YES];
        [de release];
    }
    
    
}
- (void)productPurchased:(NSString *)productId
{
    
    NSString *email = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    NSString *url = [NSString stringWithFormat:@"http://www.acexgames.com.br/app_ws/NewArticlePurchase.php?email=%@&article=%d",email, articleID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    JSONParser *parser = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(articlePurchse:) andHandler:self]; 
    NSLog(@"%@",parser);
    
    [indicator stopAnimating];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;
    
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Article Successfully subscribed !" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    //    [alert show];
    //    [alert release];      
    //    
    
    
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    registerview *uf = [[registerview alloc]init];
    [self.navigationController pushViewController:uf animated:YES];
    [uf release];
    
    
}



-(IBAction)sendPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sent" message:@"Test" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}


- (void)viewDidUnload
{
   
    
    [myTable release];
    myTable = nil;
    [answerText release];
    answerText = nil;
    [quesText release];
    quesText = nil;
    [moreInfocell release];
    moreInfocell = nil;
    [moreInfiLabel release];
    moreInfiLabel = nil;
    [indicator release];
    indicator = nil;
    [dateLabel release];
    dateLabel = nil;
    [textbox release];
    textbox = nil;
    [toolbar release];
    toolbar = nil;
    [picker release];
    picker = nil;
    [askToProBtn release];
    askToProBtn = nil;
    [toolPicker release];
    toolPicker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
