//
//  HVLoginController.h
//  Hexvix
//
//  Created by Christian Dreier on 13.04.12.
//  Copyright (c) 2012 Weilacher.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVPrepareGameController.h"

@interface HVLoginController : UIViewController

- (IBAction)closeLogin:(id)sender;
- (IBAction)login:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (nonatomic, strong) HVPrepareGameController *callback;

@end
