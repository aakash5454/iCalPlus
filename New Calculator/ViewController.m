//
//  ViewController.m
//  New Calculator
//
//  Created by Sky on 3/26/15.
//  Copyright (c) 2015 com.sky. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@end

@implementation ViewController
{
    NSString *input1;
    NSString *input2;
    NSString *tempBuffer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.mainLabel.text = @"0";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Tapping on any Numeric Button
- (IBAction) buttonTapped: (id) sender
{
    input1 = self.mainLabel.text;
    UIButton *numberButton = (id) sender;
    int tag = numberButton.tag;
    tempBuffer = [NSString stringWithFormat:@"%i",tag];
    if ([self.mainLabel.text isEqual: @"0"])             //value for first entered number
    {
        input1 = [input1 substringFromIndex:1];
        input1 = [input1 stringByAppendingString:tempBuffer];
        NSLog(@"input 1 is %@", input1);
        _mainLabel.text = input1;
    }
    else
    {
        input1 = [input1 stringByAppendingString:tempBuffer];
        _mainLabel.text = input1;
    }
}

- (IBAction)clearTapped:(id)sender {
    self.mainLabel.text = @"0";
}


@end
