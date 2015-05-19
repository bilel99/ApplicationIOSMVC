//
//  HVResultView.m
//  Hexvix
//
//  Created by Christian Dreier on 26.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import "HVResultView.h"
#import <QuartzCore/QuartzCore.h>
#import "HVImageProcessor.h"

@implementation HVResultView

@synthesize tumorRemoved, tumorRemained, goodTissueRemoved, res;

- (id)initWithFrame:(CGRect)frame andResult:(HVImageProcessor*)result
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        res = [[UIImageView alloc] initWithImage:result.coloredMask];
        [res setFrame:CGRectMake(47, 46, 540, 540)];
        res.layer.cornerRadius = res.bounds.size.width/2;
        res.layer.masksToBounds = YES;
        [self addSubview:res];
        
        UIImageView *bgr = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgr_viewer.png"]];
        [bgr setFrame:CGRectMake(0, 0, 635, 635)];
        [self addSubview:bgr];
        
        UILabel *auswertung = [[UILabel alloc] initWithFrame:CGRectMake(190, 150, 300, 100)];
        [auswertung setFont:[UIFont boldSystemFontOfSize:47]];
        [auswertung setTextColor:[UIColor colorWithRed:6.0f/255.0f green:61.0f/255.0f blue:122.0f/255.0f alpha:1.0f]];
        [auswertung setBackgroundColor:[UIColor clearColor]];
        [auswertung setText:NSLocalizedString(@"Score", nil)];
        [auswertung setShadowColor:[UIColor whiteColor]];
        [auswertung setShadowOffset:CGSizeMake(0, 1)];
        [self addSubview:auswertung];
        
        
                
        self.tumorRemoved = [[UILabel alloc] initWithFrame:CGRectMake(100, 250, 300, 50)];
        [self.tumorRemoved setFont:[UIFont boldSystemFontOfSize:22]];
        [self.tumorRemoved setTextColor:[UIColor darkGrayColor]];
        [self.tumorRemoved setBackgroundColor:[UIColor clearColor]];
        [self.tumorRemoved setTextAlignment:UITextAlignmentRight];
        [self.tumorRemoved setText:NSLocalizedString(@"TumourRemoved", nil)];
        [self.tumorRemoved setShadowColor:[UIColor whiteColor]];
        [self.tumorRemoved setShadowOffset:CGSizeMake(0,1)];
        [self addSubview:self.tumorRemoved];
//        %.2f %%", result.percentTumorRemoved * 100 ]
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(400, 250, 70, 50)];
        [lbl1 setFont:[UIFont boldSystemFontOfSize:22]];
        [lbl1 setTextColor:[UIColor colorWithRed:6.0f/255.0f green:61.0f/255.0f blue:122.0f/255.0f alpha:1.0f]];
        [lbl1 setTextAlignment:UITextAlignmentRight];
        [lbl1 setBackgroundColor:[UIColor clearColor]];
        [lbl1 setText:[NSString stringWithFormat:@"%.0f %%",result.percentTumorRemoved * 100 ]];
        [lbl1 setShadowColor:[UIColor whiteColor]];
        [lbl1 setShadowOffset:CGSizeMake(0,1)];
        [self addSubview:lbl1];
        
        
        self.tumorRemained = [[UILabel alloc] initWithFrame:CGRectMake(100, 280, 300, 50)];
        [self.tumorRemained setFont:[UIFont boldSystemFontOfSize:22]];
        [self.tumorRemained setTextColor:[UIColor darkGrayColor]];
        [self.tumorRemained setBackgroundColor:[UIColor clearColor]];
        [self.tumorRemained setTextAlignment:UITextAlignmentRight];
        [self.tumorRemained setText:NSLocalizedString(@"TumourLeft", nil) ];
        [self.tumorRemained setShadowColor:[UIColor whiteColor]];
        [self.tumorRemained setShadowOffset:CGSizeMake(0,1)];
        [self addSubview:self.tumorRemained];
        
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(400, 280, 70, 50)];
        [lbl2 setFont:[UIFont boldSystemFontOfSize:22]];
        [lbl2 setTextColor:[UIColor colorWithRed:6.0f/255.0f green:61.0f/255.0f blue:122.0f/255.0f alpha:1.0f]];
        [lbl2 setBackgroundColor:[UIColor clearColor]];
        [lbl2 setTextAlignment:UITextAlignmentRight];
        [lbl2 setText:[NSString stringWithFormat:@"%.0f %%",result.percentTumorStillThere * 100 ]];
        [lbl2 setShadowColor:[UIColor whiteColor]];
        [lbl2 setShadowOffset:CGSizeMake(0,1)];
        [self addSubview:lbl2];
        
        
        self.goodTissueRemoved = [[UILabel alloc] initWithFrame:CGRectMake(100, 310, 300, 50)];
        [self.goodTissueRemoved setFont:[UIFont boldSystemFontOfSize:22]];
        [self.goodTissueRemoved setTextColor:[UIColor darkGrayColor]];
        [self.goodTissueRemoved setBackgroundColor:[UIColor clearColor]];
        [self.goodTissueRemoved setTextAlignment:UITextAlignmentRight];
        [self.goodTissueRemoved setText:NSLocalizedString(@"HealthyTissueRemoved", nil) ];
        [self.goodTissueRemoved setShadowColor:[UIColor whiteColor]];
        [self.goodTissueRemoved setShadowOffset:CGSizeMake(0,1)];
        [self addSubview:self.goodTissueRemoved];
        
        
        UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(400, 310, 70, 50)];
        [lbl3 setFont:[UIFont boldSystemFontOfSize:22]];
        [lbl3 setTextColor:[UIColor colorWithRed:6.0f/255.0f green:61.0f/255.0f blue:122.0f/255.0f alpha:1.0f]];
        [lbl3 setBackgroundColor:[UIColor clearColor]];
        [lbl3 setTextAlignment:UITextAlignmentRight];
        [lbl3 setText:[NSString stringWithFormat:@"%.0f %%",result.percentGoodTissueRemoved * 100 ]];
        [lbl3 setShadowColor:[UIColor whiteColor]];
        [lbl3 setShadowOffset:CGSizeMake(0,1)];
        [self addSubview:lbl3];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)showResult{
    for (UIView* view in self.subviews) {
        if(view != self.res) [view removeFromSuperview];
    }
    [self setAlpha:0.6];
}

@end
