//
//  HVPrepareGameController.m
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVPrepareGameController.h"
#import "HVPrepareGameView.h"
#import "HVRoundView.h"
#import "HVGlobalData.h"
#import "HVLoginController.h"
#import "HVGameController.h"
#import "HVButtonFactory.h"


@implementation HVPrepareGameController

@synthesize rv;

int imgIndex = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view = [[HVPrepareGameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        
        
        //setting up the round view to choose the image
        self.rv = [[HVRoundView alloc] initWithFrame:CGRectMake(80, 110, 540, 540)];
        [self.view addSubview:self.rv];
        
        [self.rv loadImage:[[HVGlobalData sharedGlobals].images objectAtIndex:imgIndex] ];
        
        
       
        UIButton *backBtn = [HVButtonFactory getButtonWithText:NSLocalizedString(@"BackToStart", nil) andPos:CGPointMake(725, 450)];
        [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
        
        
        UIButton *prevBtn = [HVButtonFactory getButtonWithText:NSLocalizedString(@"PreviousImage", nil) andPos:CGPointMake(725, 550)];
        [prevBtn addTarget:self action:@selector(prevImg:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:prevBtn];
        
        
        UIButton *nextBtn = [HVButtonFactory getButtonWithText:NSLocalizedString(@"NextImage", nil) andPos:CGPointMake(725, 600)];
        [nextBtn addTarget:self action:@selector(nextImg:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nextBtn];
        
        
        UIButton *playBtn = [HVButtonFactory getButtonWithText:NSLocalizedString(@"StartTheGame", nil) andPos:CGPointMake(725, 700)];
        [playBtn addTarget:self action:@selector(loginSuccessfull) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:playBtn];
        
        
    }
    return self;
}


-(void)nextImg:(id)sender{
    
    imgIndex++;
    if(imgIndex > [[HVGlobalData sharedGlobals].images count]-1){
        imgIndex = 0;
    }
    
    [self.rv loadImage:[[HVGlobalData sharedGlobals].images objectAtIndex:imgIndex] ];
    
}


-(void)prevImg:(id)sender{
    
    imgIndex--;
    if(imgIndex < 0){
        imgIndex = [[HVGlobalData sharedGlobals].images count]-1;
    }
    
    [self.rv loadImage:[[HVGlobalData sharedGlobals].images objectAtIndex:imgIndex] ];
    
}


-(void)login:(id)sender{
    
    HVLoginController *popup = [[HVLoginController alloc] initWithNibName:@"HVLoginPopup" bundle:nil];
    [popup setModalPresentationStyle:UIModalPresentationPageSheet];
    [popup setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    popup.callback = self;
    
    [self presentViewController:popup animated:YES completion:nil];
    
    popup.view.superview.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;    
    
    popup.view.superview.frame = CGRectMake(300, 200, 400, 230 );
    
}

-(void)loginSuccessfull{
    
    HVGameController *game = [[HVGameController alloc] initWithImage: [[HVGlobalData sharedGlobals].images objectAtIndex:imgIndex] ];
    [self  presentViewController:game animated:YES completion:nil];
    
}

-(void)back:(id)sender{
    [self dismissModalViewControllerAnimated:NO];
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        return YES;
    }
	return NO;
}

@end
