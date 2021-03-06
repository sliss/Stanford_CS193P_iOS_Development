//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Steven Liss Liss on 9/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL thereIsADecimal;
@property (nonatomic) BOOL validInput;
@property (nonatomic, strong) CalculatorBrain *brain;
@end


@implementation CalculatorViewController

@synthesize display = _display;
@synthesize history = _history;

@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize thereIsADecimal = _thereIsADecimal;
@synthesize validInput = _validInput;
@synthesize brain = _brain;

- (CalculatorBrain *)brain { // lazy instanciation
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender { //pointer UIButton is pointer to a UIBUtton object
    NSString *digit = [sender currentTitle]; //declares *digit as a pointer to a string equal to the sender's currentTitle
    if ([digit isEqualToString:@"π"]) {
        digit = @"3.1415";
    }
    self.validInput = YES; //assume valid to start
    if ([@"." isEqualToString:digit]) {
        if(self.thereIsADecimal) { // already a decimal?  not valid!
            self.validInput = NO;
        }
        self.thereIsADecimal = YES;
        
    }
    if (self.validInput && self.userIsInTheMiddleOfEnteringANumber) {// already entering #
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else if(self.validInput) { //beginning of new number
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    if(self.validInput) {
        self.history.text = [self.history.text stringByAppendingString:digit];
    }
    
    
    // debug: NSLog(@"digit pressed = %@", digit);
    
    //UILabel *myDisplay =self.display; // calls getter method via dot notation, same as [self display];
    //NSString *currentText self.display.text;

    
}

- (IBAction)clearPressed { //clear display and history, erase stack
    
    self.display.text = @"0";
    self.history.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.thereIsADecimal = NO;
    self.history.text = [self.history.text stringByAppendingString:@" "];
}


- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) { //implicit enter saves user a keystroke
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    self.history.text = [self.history.text stringByAppendingString:operation];
}




- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
