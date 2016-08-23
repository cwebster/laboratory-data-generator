//
//  PCGaussianDataGenerator.m
//  laboratory-data-generator
//
//  Created by Webster Craig on 23/08/2016.
//  Copyright © 2016 Webster Craig. All rights reserved.
//

#import "PCGaussianDataGenerator.h"

@implementation PCGaussianDataGenerator


- (id)initWithMeanAndStandardDeviation:(NSDecimalNumber *)aMean standardDeviation:(NSDecimalNumber *)aStandardDeviation numberOfResults:(int)numberOfResultsRequired{
    self = [super init];
    if (self) {
        // Any custom setup work goes here
        _mean = [aMean copy];
        _standardDeviation = [aStandardDeviation copy];
        _rand_helper = [self startRandomGenerator];
        _numberOfResultsRequired = numberOfResultsRequired;
        _valid = FALSE;
        _next = [[NSDecimalNumber alloc]initWithString:@"0.0"];
        _results = [[NSMutableArray alloc]init];
        [self createDistribution];
    }
    return self;
}

- (NSDecimalNumber *)startRandomGenerator{
    srand48(time(0));
    double random_seed = drand48();
    NSDecimalNumber *doubleDecimal = [[NSDecimalNumber alloc] initWithDouble:random_seed];
    return doubleDecimal;
}


-(void)createDistribution {
    int a;
    for( a = 1 ; a < _numberOfResultsRequired; a = a + 1 )
    {
        NSDecimalNumber *result = [self generateRandomNumber];
        
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:
                             result, @"Result",
                             nil];
        
        [_results addObject:dict];
        NSLog(@"value of result: %@\n", result);
    }
    
}

-(NSDecimalNumber*)generateRandomNumber {
    if (_valid)
    {
        _valid = FALSE;
    return _next;
    }
    else
    {
        _valid =  TRUE;
    
    NSDictionary* values = [self gaussian];
    
    _next = [values objectForKey:@"y"];
        
        
    return [values objectForKey:@"x"];
    }
}

-(NSDictionary *)gaussian{
    NSMutableDictionary* returnValues = [[NSMutableDictionary alloc]init];
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                             scale:2
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    
    
    NSDecimalNumber *piFactor = [[NSDecimalNumber alloc] initWithDouble:(2 * M_PI )];
    
   
    NSDecimalNumber *theta = [_rand_helper decimalNumberByMultiplyingBy:piFactor
                                                     withBehavior:handler];
    
    
    NSDecimalNumber *rho = [[NSDecimalNumber alloc] initWithDouble:(sqrt(-2 * log(1 - [_rand_helper doubleValue])))];
    
    
    NSDecimalNumber *scale = [_standardDeviation decimalNumberByMultiplyingBy:rho
                                                           withBehavior:handler];
    
    
    NSDecimal thetaCos =  [[NSDecimalNumber numberWithFloat:cos([theta doubleValue])] decimalValue];
    NSDecimal thetaSin =  [[NSDecimalNumber numberWithFloat:sin([theta doubleValue])] decimalValue];
    
    NSDecimalNumber *x = [[_standardDeviation decimalNumberByAdding:scale] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithDecimal:thetaCos]
                                                                 withBehavior:handler];
    
    NSDecimalNumber *y = [[_standardDeviation decimalNumberByAdding:scale] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithDecimal:thetaSin]
                                                                                           withBehavior:handler];
    
 
    
    
    [returnValues setObject:x forKey:@"x"];
    [returnValues setObject:y forKey:@"y"];
    
    return returnValues;
    
}

@end
