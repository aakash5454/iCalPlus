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
    BOOL operationButtonTapped;           //Initially false becasue button not tapped
    BOOL equalToTapped;                   //Initially false becasue button not tapped
    BOOL decimalButtonTapped;             //Initially false becasue button not tapped
    int operationButtonTagValue;          //To identify which operaiton button is tapped
    BOOL input2IsNil;
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
    equalToTapped = false;
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
        if (input2 ==  nil)                //first digit of second number entered
        {
            input2 = @"a";
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
    operationButtonTagValue = 17;  //Tag value that is greater than all the values used.
    input2IsNil = false;
}

#pragma mark- operationButtonTapped
//Uses Tag value of operators to decide which operation to perform
- (IBAction)operationButtonTapped:(id)sender
{
    if (input2) //added to fix #7
    {
        [self equalsToIsTapped:sender];
    }
    UIButton *operationButton = (id) sender;
    NSUInteger tag = operationButton.tag;
    input1 = _mainLabel.text;
    operationButtonTapped = true; //So that next number entered is input2
    decimalButtonTapped = false;
    
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
     if (operationButtonTapped == true)   //Added becasue input1=@"0" when operation button is tapped.
     {
         long double temp = [self.mainLabel.text doubleValue];
         temp  = -(temp);
        if (temp)
        {
            input1 = [NSString stringWithFormat:@"%Lg",temp];
                 self.mainLabel.text = input1;
        }
         else if ([input1  isEqual: @"0"])
             {
                 self.mainLabel.text = @"0";
             }
     }
     else
        {
            long double temp = [self.mainLabel.text doubleValue];
            temp  = -(temp);
            if (operationButtonTapped == false)  //This is input1
             {
                 input1 = [NSString stringWithFormat:@"%Lg",temp];
                 _mainLabel.text = input1;
             }
            else  //This is input 2
            {
                 input2 = [NSString stringWithFormat:@"%Lg",temp];
                 _mainLabel.text = input2;
         }
            //Added to check so you cannot get -0. Important feature of this calculator
            if ([input1  isEqual: @"-0"] || [input2 isEqual:@"-0"])
            {
                self.mainLabel.text = @"0";
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

                if (input2 == nil)
                {
                    input2 = @"0"; //Initilized to O, because we cannot append anything when input2=nil
                }
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
   //operationButtonTapped = false; //To solve #7 because u want next input to be input1.
     //commented the above line after making change in operatioButtontapped to fix #7.
    static NSString *input11;   //Temp variable use when = is tapped 2nd time or more
    static NSString *input22;   //Temp variable use when = is tapped 2nd time or more
    long double answer;
    answer = [input1 doubleValue]; //added so that operation: 5 =  is equal to 5
    
    if (equalToTapped == false)  //EqualToTapped for the First Time //
     {
         NSString *str1 = input1;
         long double theFirstOperandValue = [str1 doubleValue];
         NSString *str2 = input2;
         long double theSecondOperandValue = [str2 doubleValue];
         
         if (input2 == nil)  //when input2 is nil
         {
             input2IsNil = true;
             theSecondOperandValue = theFirstOperandValue; //Store 1st operand value in 2nd...To maintain normal calculator behaviour i.e take input2 equals to input1 when input2 is not provided and = is tapped.
         }
         
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
                 break;
         }
         
         result = [NSString stringWithFormat:@"%Lg", answer];
         _mainLabel.text = result;  // To update result on screen
         equalToTapped = true;
         
         if (input2IsNil == true)
         {
             input22 = [NSString stringWithFormat:@"%Lg", theSecondOperandValue];
             input2=nil;
             input2IsNil = false;
             
         }
         else
         {
             input11= [NSString stringWithFormat:@"%Lg", theFirstOperandValue];
             input22= [NSString stringWithFormat:@"%Lg", theSecondOperandValue];
             input2 = nil;
             input1 = @"0";
         }
      
    }
    else  //Equal to tapped second time
    {
        NSString *str2 = input22;
        long double theSecondOperandValue = [str2 doubleValue];
        
         NSString *tempResult1 = result;
         answer = [tempResult1 doubleValue];
         switch (operationButtonTagValue)
         {
             case DIVISION:
                 answer = answer/theSecondOperandValue;
                 break;
                 
             case MULTIPLICATION:
                 answer = answer*theSecondOperandValue;
                 break;
                 
             case ADDITION:
                 answer = answer+theSecondOperandValue;
                 break;

                 
             case SUBTRACTION:
                 answer = answer-theSecondOperandValue;
                 break;
           }
        result = [NSString stringWithFormat:@"%Lg", answer];
        _mainLabel.text = result;
      }
    NSLog(@"result is %@", result);
}

#pragma mark- Percentage Operator
- (IBAction)percentageButtonTapped:(id)sender
{
   if (!equalToTapped)
   {
    decimalButtonTapped = true; // added so that 4 % = 0.04 and then no one can tap decimal   
    if (operationButtonTapped == false)       //This is input1 and percentage is tapped (only input1 is given)
    {
        NSString *temp = self.mainLabel.text;
        long double percentage = [temp doubleValue]; //change to double from longLongValue
        percentage = percentage/100 ;
        input1 = [NSString stringWithFormat:@"%Lg", percentage];
        _mainLabel.text = input1;
    }
    else    //This is input2, and percentage of input2 is tapped (both inputs given)
    {
        NSString *temp = self.mainLabel.text;
        long double percentage = [temp doubleValue];
        percentage = percentage/100 ;
        input2 = [NSString stringWithFormat:@"%Lg", percentage];
        _mainLabel.text = input2;
        [self equalsToIsTapped:sender];       //To get the result as soon as Percentage is tapped without user to tap equals to. Have to do this because % is a single operand, operator. This is a feature from user Experience point of view.
    }
       
   }
   else //added to fix unreported decimal bug.
   {
       NSString *temp = self.mainLabel.text;
       long double percentage = [temp doubleValue]; //change to double from longLongValue
       percentage = percentage/100 ;
       input1 = [NSString stringWithFormat:@"%Lg", percentage];
       _mainLabel.text = input1;
       equalToTapped = true;
   }
}

@end
