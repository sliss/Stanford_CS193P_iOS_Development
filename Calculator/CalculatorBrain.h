//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Steven Liss Liss on 9/16/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand: (double)operand;
- (double)performOperation: (NSString *)operation;
@end
