//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Steven Liss Liss on 9/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    if(_operandStack==nil) _operandStack = [[NSMutableArray alloc] init]; // initialize it in getter to prevent it ever being nil.  called "lazy instanciation"
    return _operandStack;
}

- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand{
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation: (NSString *)operation {
    double result = 0; // caclulate result
    if([operation isEqualToString:@"+"]) {
        result =[self popOperand] + [self popOperand];
    } 
    else if ([@"*" isEqualToString:operation]){
        result =[self popOperand] * [self popOperand];
        }
    else if ([@"/" isEqualToString:operation]){
        double divisor = [self popOperand];
        result =[self popOperand] / divisor;
    }
    else if ([@"-" isEqualToString:operation]){
        double subtrahend = [self popOperand];
        result =[self popOperand] - subtrahend;
    }
    else if ([@"sin" isEqualToString:operation]){
        result =sin([self popOperand]);
    }
    else if ([@"cos" isEqualToString:operation]){
        result =cos([self popOperand]);
    }
    else if ([@"sqrt" isEqualToString:operation]){
        result =sqrt([self popOperand]);
    }
    [self pushOperand:result];
    return result;
    
}

- (void)clearStack{
    self.operandStack = nil;
}
@end
