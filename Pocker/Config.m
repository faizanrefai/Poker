//
//  Config.m
//  Pocker
//
//  Created by Ronak Arora on 20/06/12.
//  Copyright 2012 iverve. All rights reserved.
//

#import "Config.h"
#import "registerview.h"
#import "chekinfoview.h"
#import "updateinfo.h"

@implementation Config

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
    
    
   // self.title= @"";
    self.navigationItem.title =@"Configuracoes";

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)registrationpress:(id)sender {
    
    registerview *obj=[[registerview alloc]initWithNibName:@"registerview" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES]; 
}

- (IBAction)update:(id)sender {
    
  NSString *ema=  [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    if (ema) {
        
        updateinfo *obj=[[updateinfo alloc]initWithNibName:@"updateinfo" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES]; 

        
    }else {
        
        registerview *re = [[registerview alloc]init];
        [self.navigationController pushViewController:re animated:YES];
        [re release];
        
    }
    

    

}

- (IBAction)chekinfo:(id)sender {
    
    NSString *ema=  [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    
    if (ema) {
        
        
        chekinfoview *obj=[[chekinfoview alloc]initWithNibName:@"chekinfoview" bundle:nil];
        [self.navigationController pushViewController:obj animated:YES]; 
       
        
    }else {
        
        registerview *re = [[registerview alloc]init];
        [self.navigationController pushViewController:re animated:YES];
        [re release];
        
    }
    

  
}
@end
