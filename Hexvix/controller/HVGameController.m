//
//  HVGameController.m
//  Hexvix
//
//  Created by Christian Dreier on 18.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVGameController.h"
#import "HVGlobalData.h"
#import "HVImageProcessor.h"
#import "HVButtonFactory.h"

@implementation HVGameController

@synthesize rv;



- (id)initWithImage:(NSString*)img
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgr.png"]];
        bg.frame = CGRectMake(0, 0, 1025, 768);
        [self.view addSubview:bg];
        
        
        self.rv = [[HVRoundView alloc] initWithFrame:CGRectMake(80, 110, 540, 540)];
        [self.view addSubview:self.rv];
        
        imageName = img;
        [self.rv loadImage: imageName];
        [self.rv activatePainting];
        
        
        btnDone = [HVButtonFactory getButtonWithText:NSLocalizedString(@"End", nil) andPos:CGPointMake(725, 700)];
        [btnDone addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnDone];
        

        UIButton *btnBack = [HVButtonFactory getButtonWithText:NSLocalizedString(@"StopSession", nil) andPos:CGPointMake(725, 550)];
        [btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnBack];
        
        
        UIButton *btnRestart = [HVButtonFactory getButtonWithText:NSLocalizedString(@"StartNewSession", nil) andPos:CGPointMake(725, 600)];
        [btnRestart addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnRestart];
        
        
        UIImage *penIcon = [UIImage imageNamed:@"icon_pencil.png"];
        UIImageView *penLogo = [[UIImageView alloc] initWithImage:penIcon];
        penLogo.frame = CGRectMake(725, 200, penIcon.size.width, penIcon.size.height);
        [self.view addSubview:penLogo];
        
        UILabel *penSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(725+penIcon.size.width+10, 200, 200, penIcon.size.height)];
        [penSizeLabel setText:NSLocalizedString(@"PenSize", nil)];
        [penSizeLabel setTextColor:[UIColor grayColor]];
        [penSizeLabel setFont:[UIFont boldSystemFontOfSize:22]];
        [penSizeLabel setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:penSizeLabel];
        
        pens = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                                                                              [UIImage imageNamed:@"btn_size_small_inactive.png"],
                                                                              [UIImage imageNamed:@"btn_size_medium_inactive.png"],
                                                                              [UIImage imageNamed:@"btn_size_large_inactive.png"],
                                                                              nil]];
        [pens addTarget:self action:@selector(setPen:) forControlEvents:UIControlEventValueChanged];
        pens.segmentedControlStyle = UISegmentedControlStyleBar;
        [pens setFrame:CGRectMake(725, 230, 272, 42)];
        [self.view addSubview:pens];
        
        
        
        
        UIImage *rubberIcon = [UIImage imageNamed:@"icon_eraser.png"];
        UIImageView *rubberLogo = [[UIImageView alloc] initWithImage:rubberIcon];
        rubberLogo.frame = CGRectMake(725, 320, rubberIcon.size.width, rubberIcon.size.height);
        [self.view addSubview:rubberLogo];
        
        UILabel *rubberSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(725+rubberIcon.size.width+10, 320, 200, rubberIcon.size.height)];
        [rubberSizeLabel setText:NSLocalizedString(@"RubberSize", nil)];
        [rubberSizeLabel setTextColor:[UIColor grayColor]];
        [rubberSizeLabel setFont:[UIFont boldSystemFontOfSize:22]];
        [rubberSizeLabel setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:rubberSizeLabel];
                
        rubbers = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                                                                              [UIImage imageNamed:@"btn_size_small_inactive.png"],
                                                                              [UIImage imageNamed:@"btn_size_medium_inactive.png"],
                                                                              [UIImage imageNamed:@"btn_size_large_inactive.png"],
                                                                              nil]];
        [rubbers addTarget:self action:@selector(setRubber:) forControlEvents:UIControlEventValueChanged];        
        rubbers.segmentedControlStyle = UISegmentedControlStyleBar;
        [rubbers setFrame:CGRectMake(725, 350, 272, 42)];
        [self.view addSubview:rubbers];
        
        
        
        [pens setSelectedSegmentIndex:1];
        [pens setImage:[UIImage imageNamed:@"btn_size_medium_active.png"] forSegmentAtIndex:1];
        
        
        
    }
    return self;
}

-(void)resetSegmentControls{
    [pens setImage:[UIImage imageNamed:@"btn_size_small_inactive.png"] forSegmentAtIndex:0];
    [pens setImage:[UIImage imageNamed:@"btn_size_medium_inactive.png"] forSegmentAtIndex:1];
    [pens setImage:[UIImage imageNamed:@"btn_size_large_inactive.png"] forSegmentAtIndex:2];
    
    
    [rubbers setImage:[UIImage imageNamed:@"btn_size_small_inactive.png"] forSegmentAtIndex:0];
    [rubbers setImage:[UIImage imageNamed:@"btn_size_medium_inactive.png"] forSegmentAtIndex:1];
    [rubbers setImage:[UIImage imageNamed:@"btn_size_large_inactive.png"] forSegmentAtIndex:2];
}


-(void)setPen:(id)sender{
    
    UISegmentedControl *tmp = (UISegmentedControl*) sender;
    
    [self resetSegmentControls];
    [rubbers setSelectedSegmentIndex:-1];
    
    
    switch ([tmp selectedSegmentIndex]) {
        case 0:
            [self.rv setPenSmall];
            [pens setImage:[UIImage imageNamed:@"btn_size_small_active.png"] forSegmentAtIndex:0];
            break;
        case 1:
            [self.rv setPenMedium];
            [pens setImage:[UIImage imageNamed:@"btn_size_medium_active.png"] forSegmentAtIndex:1];
            break;
        case 2:
            [self.rv setPenBig];
            [pens setImage:[UIImage imageNamed:@"btn_size_large_active.png"] forSegmentAtIndex:2];
            break;
        default:
            NSLog(@"error in segment control index");
            break;
    }

}


-(void)setRubber:(id)sender{
    
    UISegmentedControl *tmp = (UISegmentedControl*) sender;
    
    [self resetSegmentControls];
    [pens setSelectedSegmentIndex:-1];
    
    switch ([tmp selectedSegmentIndex]) {
        case 0:
            [self.rv setRubberSmall];
            [rubbers setImage:[UIImage imageNamed:@"btn_size_small_active.png"] forSegmentAtIndex:0];
            break;
        case 1:
            [self.rv setRubberMedium];
            [rubbers setImage:[UIImage imageNamed:@"btn_size_medium_active.png"] forSegmentAtIndex:1];
            break;
        case 2:
            [self.rv setRubberBig];
            [rubbers setImage:[UIImage imageNamed:@"btn_size_large_active.png"] forSegmentAtIndex:2];
            break;
        default:
            NSLog(@"error in segment control index");
            break;
    }
    
}



-(void)done{
    
    UIImage *refTemp = [UIImage imageNamed: [NSString stringWithFormat:@"%@-ref-whiteTumor.bmp", [imageName stringByDeletingPathExtension]] ];    
    UIImage *mask =  [self.rv.paintView getMask];
    
    UIImage *colorRefTemp = [UIImage imageNamed: [NSString stringWithFormat:@"%@-ref.jpg", [imageName stringByDeletingPathExtension]] ];
    
    
    HVImageProcessor *result = [[HVImageProcessor alloc] initWithDrawnImage:mask andTargetImage:refTemp];
    result.coloredMask = colorRefTemp;
    [result process];
    
    
    NSLog(@"results: prozent tumor entfernt: %f  prozent gesundes gewebe entfernt: %f  prozent tumor noch vorhanden: %f", result.percentTumorRemoved, result.percentGoodTissueRemoved, result.percentTumorStillThere );
    
    
    
    
    [self.rv cancelPainting];
    
    resultView = [[HVResultView alloc] initWithFrame:CGRectMake(32, 65, 635, 635) andResult:result];
    [self.view addSubview:resultView];
    [pens setEnabled:NO];
    [rubbers setEnabled:NO];
    [btnDone setHidden:YES];
    
    UIButton *btnSolve = [HVButtonFactory getButtonWithText:NSLocalizedString(@"Complete", nil) andPos:CGPointMake(725, 700)];
    [btnSolve addTarget:self action:@selector(solve:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSolve];
    
    //[self.rv.img setImage: refTemp];
    
    //debug
//    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 50)];
//    [resultLabel setTextColor:[UIColor whiteColor]];
//    [resultLabel setFont:[UIFont boldSystemFontOfSize:14]];
//    [resultLabel setBackgroundColor:[UIColor clearColor]];
//    [resultLabel setLineBreakMode:UILineBreakModeWordWrap];
//    [resultLabel setText:[NSString stringWithFormat:@"results: prozent tumor entfernt: %f  prozent gesundes gewebe entfernt: %f  prozent tumor noch vorhanden: %f", result.percentTumorRemoved*100.0f, result.percentGoodTissueRemoved*100.0f, result.percentTumorStillThere*100.0f]];
//    
//    [self.view addSubview:resultLabel];
    
    

}

-(void)solve:(id)sender{
    [resultView showResult];
    [sender removeFromSuperview];
    
}






-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)restart{
    [resultView removeFromSuperview];
    [pens setEnabled:YES];
    [rubbers setEnabled:YES];
    [btnDone setHidden:NO];
    [btnDone setEnabled:YES];
    [self.rv resetPaintview];
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
