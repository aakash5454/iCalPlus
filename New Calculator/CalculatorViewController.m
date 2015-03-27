//
//  ViewController.m
//  New Calculator
//
//  Created by Sky on 3/26/15.
//  Copyright (c) 2015 com.sky. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@end

@implementation CalculatorViewController
{
    NSString *input1;                     //To store users First Input
    NSString *input2;                     //To store users third Input
    NSString *tempBuffer;                 //
    BOOL operationButtonTapped;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.mainLabel.text = @"0";
    operationButtonTapped = false;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Tapping on any Numeric Button from 0-9 using tag values
- (IBAction)buttonTapped:(id)sender
{
    if (operationButtonTapped == false)             //This is input1
    {
        input1 = self.mainLabel.text;
        UIButton *numberButton = (id) sender;
        int tag = numberButton.tag;
        NSString *tempBuffer1 = [NSString stringWithFormat:@"%i",tag];
        if ([self.mainLabel.text isEqual: @"0"])                //first digit of first number entered
        {
            input1 = [input1 substringFromIndex:1];
            input1 = [input1 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input1;
            NSLog(@"input 1 first digit is: %@", input1);
        }
        else
        {
            input1 = [input1 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input1;
            NSLog(@"input 1 is: %@", input1);
        }
    }
    else                //This is input2
    {
       
       // input2 = self.mainLabel.text;
        UIButton *numberButton = (id) sender;
        int tag = numberButton.tag;
        NSString *tempBuffer1 = [NSString stringWithFormat:@"%i",tag];
        if ([self.mainLabel.text isEqual: input1])                //first digit of second number entered
        {
            input2 = @"0";
            input2 = [input2 substringFromIndex:1];
            input2 = [input2 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input2;
            NSLog(@"input 2 first digit is: %@", input2);
        }
        else
        {
            input2 = [input2 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input2;
            NSLog(@"Complete input 2 is: %@", input2);
        }
    }
        
}

- (IBAction)clearTapped:(id)sender {
    self.mainLabel.text = @"0";
    operationButtonTapped = false;
}

- (IBAction)operationButtonTapped:(id)sender
{
    UIButton *operationButton = (id) sender;
    int tag = operationButton.tag;
    operationButtonTapped = true;
    if (operationButtonTapped)
    {
        switch (tag) {
            case 11: //division
                input1 = _mainLabel.text;
                
                break;
                
            case 12:  //multiplication
                input1 = _mainLabel.text;
                break;
            
            case 13:  //addition
                input1 = _mainLabel.text;
                break;
                
            case 14:  //subtraction
                input1 = _mainLabel.text;
                break;
                
            default:
                break;
        }
    }
}
@end
