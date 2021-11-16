//
//  VMAppleSignIn.m
//  Vortex Mortgage
//
//  Created by Alex Thompson on 7/1/20.
//  Copyright © 2020 BloomTech. All rights reserved.
//

#import "VMAppleSignIn.h"
#import "Vortex_Mortgage-Swift.h"

@implementation VMAppleSignIn

- (instancetype)initWithUserId:(NSString *)userid
                         email:(NSString *)email
                     firstName:(NSString *)firstName
                      lastName:(NSString *)lastName
                     fullName:(NSString *)fullName
{
    self = [super init];
    if (self) {
        _userid = [userid copy];
        _email = [email copy];
        _firstName = [firstName copy];
        _lastName = [lastName copy];
        _fullName = [fullName copy];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; %@ - %@>", NSStringFromClass(self.class), self, self.email, self.fullName];
}

@end
