//
//  CalculatorController.m
//  New Calculator
//  Created by Sky on 3/26/15.
//  Copyright (c) 2015 com.sky. All rights reserved.
//
//  


#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@end

@implementation CalculatorViewController
{
    NSString *input1;                     //To store users First Input
    NSString *input2;                     //To store users third Input
    NSString *result;                     //To store operation result
    BOOL operationButtonTapped;
    BOOL equalToTapped;
    BOOL decimalButtonTapped;
    int operationButtonTagValue;          //To identify which operaiton button is tapped
}

typedef enum
{
    DIVISION = 11,
    MULTIPLICATION = 12,
    ADDITION = 13,
    SUBTRACTION = 14
    
}operations;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearTapped:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- NumericButtonTapped
// Tapping on any Numeric Button from 0-9 using tag values
- (IBAction)buttonTapped:(id)sender
{
    UIButton *numberButton = (id) sender;
    NSUInteger tag = numberButton.tag;
    NSString *tempBuffer1 = [NSString stringWithFormat:@"%lu",(unsigned long)tag];
    if (operationButtonTapped == false)             //This is input1
    {
        if ([input1 isEqual: @"0"])                //first digit of first number entered
        {
            input1 = [input1 substringFromIndex:1];
        }
            input1 = [input1 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input1;
            NSLog(@"input 1 first digit is: %@", input1);
    }
    else                //This is input2
    {
        NSLog(@"self.MainLabel.text %@", self.mainLabel.text);
        if ([input2 isEqual: @"0"])                //first digit of second number entered
        {
           // input2 = tempBuffer1;//was @"0"
            input2 = [input2 substringFromIndex:1];
        }
            input2 = [input2 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input2;
            NSLog(@"Complete input 2 is: %@", input2);
    }
        
}

#pragma mark- ClearButtonIsTapped
// A/C button on calculator to reset the calculator & display
- (IBAction)clearTapped:(id)sender
{
    self.mainLabel.text = @"0";
    result = @"0";
    input1 = @"0";
    input2 = nil;
    operationButtonTapped = false;
    equalToTapped = false;
    decimalButtonTapped = false;
    operationButtonTapped = false;
    operationButtonTagValue = 17;  //Tag value that is greater than all the values used.
}

#pragma mark- operationButtonTapped
//Uses Tag value of operators to decide which operation to perform
- (IBAction)operationButtonTapped:(id)sender
{
    UIButton *operationButton = (id) sender;
    NSUInteger tag = operationButton.tag;
    input1 = _mainLabel.text;
    operationButtonTapped = true;
    decimalButtonTapped = false;
    input2 = @"0"; // Change1  added to start adding first digit of 2nd input to input2
    
    if (operationButtonTapped)
    {
        switch (tag)
        {
            case DIVISION:
                operationButtonTagValue = DIVISION;
                break;
                
            case MULTIPLICATION:
                operationButtonTagValue = MULTIPLICATION;
                break;
            
            case ADDITION:
                operationButtonTagValue = ADDITION;
                break;
                
            case SUBTRACTION:
                operationButtonTagValue = SUBTRACTION;
                break;
                
            default:
                break;
        }
    }
}

#pragma mark- SignChangeOperatorTapped
 - (IBAction)signChangeOperatorTapped:(id)sender
 {

     if ([input1  isEqual: @"0"])
         {
             self.mainLabel.text = @"0";
         }
     else
        {
            float temp = [self.mainLabel.text floatValue];
            temp  = -(temp);
            if (operationButtonTapped == false)  //This is input1
             {
                 input1 = [NSString stringWithFormat:@"%g",temp];
                 _mainLabel.text = input1;
             }
            else  //This is input 2
            {
                 input2 = [NSString stringWithFormat:@"%g",temp];
                 _mainLabel.text = input2;
         }
     }
 }

#pragma mark- DecimalButtonTapped
- (IBAction)decimalButtonTapped:(id)sender
{
    if (operationButtonTapped == false) //this is input 1
        {
            if (decimalButtonTapped == false) // decimal is tapped first time for input1
           {
                input1 = [input1 stringByAppendingFormat:@"."];
                _mainLabel.text = input1;
                NSLog(@"the decimal formatted string is: %@", input1);
                decimalButtonTapped = true;
           }
            else
            {
                _mainLabel.text = input1;
            }

        }
        else   //this is input 2
        {
           
            if (decimalButtonTapped == false) //decimal is tapped first time for input2
            {
                input2 = @"0"; //Initilized to O, because . we cannot append anything to  input2=nil
                input2 = [input2 stringByAppendingString:@"."];
                _mainLabel.text = input2;
                decimalButtonTapped = true;
            }
            else
            {
                _mainLabel.text = input2;
            }
        }
}

#pragma mark- EqualToButtonTapped
- (IBAction)equalsToIsTapped:(id)sender
{
    NSString *str1 = input1;
    long double theFirstOperandValue = [str1 floatValue];
    NSString *str2 = input2;
    long double theSecondOperandValue = [str2 floatValue];
    
    if ([input2 isEqual:@"0"])
    {
        theSecondOperandValue = theFirstOperandValue; //To maintain normal calculator behaviour i.e take input2 equals to input1 when input2 is not provided and = is tapped.
    }
    else
    {
        theSecondOperandValue = theSecondOperandValue; //When input2 is provided.
    }
    long double answer;
     if (equalToTapped == false)  //EqualToTapped for the First Time
     {
        switch (operationButtonTagValue)
         {
            case DIVISION:
                answer = theFirstOperandValue/theSecondOperandValue;
                break;

            case MULTIPLICATION:
                answer = theFirstOperandValue*theSecondOperandValue;
                break;
                
            case ADDITION:
                answer = theFirstOperandValue+theSecondOperandValue;
                break;
                
            case SUBTRACTION:
                answer = theFirstOperandValue-theSecondOperandValue;
                break;
            default:
                 answer = 0.0;
                 break;
         }
         result = [NSString stringWithFormat:@"%Lg", answer];
         _mainLabel.text = result;
         equalToTapped = true;
      }
      else  //Equal to tapped second time
      {
         NSString *tempResult1 = result;
         answer = [tempResult1 floatValue];
         switch (operationButtonTagValue)
         {
             case 11:
                 answer = answer/theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 12:
                 answer = answer*theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 13:
                 answer = answer+theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 14:
                 answer = answer-theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
           }
      }
}

#pragma mark- Percentage Operator
- (IBAction)percentageButtonTapped:(id)sender
{
    NSString *temp = self.mainLabel.text;
    long double percentage = [temp floatValue];
    percentage = percentage/100 ;
    result = [NSString stringWithFormat:@"%Lg", percentage];
    _mainLabel.text = result;
    operationButtonTagValue = 17;
}

@end
