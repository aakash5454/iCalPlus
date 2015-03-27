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
    NSString *result;                     //To store operation result
    BOOL operationButtonTapped;           //
    BOOL equalToTapped;
    int operationButtonTagValue;          //To identify which operaiton button is tapped

    
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
    result = @"0";
    input1 = @"0";
    input2 = @"0";
    operationButtonTapped = false;
    equalToTapped = false;
    
    operationButtonTapped = false;
}

- (IBAction)operationButtonTapped:(id)sender
{
    UIButton *operationButton = (id) sender;
    int tag = operationButton.tag;
    operationButtonTapped = true;
    BOOL performOperation;
    if (operationButtonTapped)
    {
        switch (tag)
        {
            case 11: //division
                input1 = _mainLabel.text;
                performOperation = true;
                operationButtonTagValue = 11;
                break;
                
            case 12:  //multiplication
                input1 = _mainLabel.text;
                performOperation = true;
                operationButtonTagValue = 12;
                break;
            
            case 13:  //addition
                input1 = _mainLabel.text;
                performOperation = true;
                operationButtonTagValue = 13;
                break;
                
            case 14:  //subtraction
                input1 = _mainLabel.text;
                performOperation = true;
                operationButtonTagValue = 14;
                break;
                
            default:
                break;
        }
    }
}

- (IBAction)equalsToIsTapped:(id)sender
{
    NSString *str1 = input1;
    double theFirstOperandValue = [str1 floatValue];
    NSString *str2 = input2;
    double theSecondOperandValue = [str2 floatValue];
    double answer;
     if (equalToTapped == false)
     {
        switch (operationButtonTagValue)
         {
            case 11:
                answer = theFirstOperandValue/theSecondOperandValue;
                result = [NSString stringWithFormat:@"%f", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;

            case 12:
                answer = theFirstOperandValue*theSecondOperandValue;
                result = [NSString stringWithFormat:@"%f", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;
                
            case 13:
                answer = theFirstOperandValue+theSecondOperandValue;
                result = [NSString stringWithFormat:@"%f", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;
                
            case 14:
                answer = theFirstOperandValue-theSecondOperandValue;
                result = [NSString stringWithFormat:@"%f", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;

        }
      }
      else
      {
         NSString *tempResult1 = result;
         answer = [tempResult1 floatValue];
         switch (operationButtonTagValue)
         {
             case 11:
                 answer = answer/theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%f", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 12:
                 answer = answer*theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%f", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 13:
                 answer = answer+theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%f", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 14:
                 answer = answer-theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%f", answer];
                 _mainLabel.text = result;
                 break;
           }
      }
}


@end
