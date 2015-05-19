//
//  HVLoginController.m
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVLoginController.h"
#import "NSString+casts.h"
#import "HVGameController.h"

@implementation HVLoginController
@synthesize errorLabel;
@synthesize codeField;
@synthesize callback;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

        
    }
    return self;
}


-(BOOL)checkCrossSum:(NSArray*)base withExpectedTarget:(NSNumber*)target{
    
    int crossSum = 0;
    
    for (NSString *c in base) {
       crossSum += [[c toNumber] intValue];
    }
    
    if (crossSum == [target intValue]) {
        return true;
    }
    
    return false;
}

- (IBAction)closeLogin:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}



-(void)closeLoginAfterSuccess{
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        [self.callback loginSuccessfull];        
    }];

}

- (IBAction)login:(id)sender {
    
    NSString *code = [self.codeField text];
    self.errorLabel.hidden = YES;
    
    if ([code length] != 7) {
        self.errorLabel.hidden = NO;
    }else{
        
        if([self checkCrossSum:[[code substringToIndex:5] toCharArray] withExpectedTarget:[[code substringFromIndex:5] toNumber]]){
                
            //TODO: set user?

            [self closeLoginAfterSuccess];

            
        }else{
            self.errorLabel.hidden = NO;
        }
        
    }
    
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setErrorLabel:nil];
    [self setCodeField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


@end
