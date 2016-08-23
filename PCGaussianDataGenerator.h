//
//  PCGaussianDataGenerator.h
//  laboratory-data-generator
//
//  Created by Webster Craig on 23/08/2016.
//  Copyright © 2016 Webster Craig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCGaussianDataGenerator : NSObject {
    NSDecimalNumber* _rand_helper;
    NSDecimalNumber* _next;
    int _numberOfResultsRequired;
    BOOL _valid;
}

@property NSDecimalNumber *mean;
@property NSDecimalNumber *standardDeviation;
@property NSMutableArray *results;

- (id)initWithMeanAndStandardDeviation:(NSDecimalNumber *)aMean standardDeviation:(NSDecimalNumber *)aStandardDeviation numberOfResults:(int)numberOfResultsRequired;
- (void)createDistribution;


@end
