//
//  VMAppleSignIn.h
//  Vortex Mortgage
//
//  Created by Alex Thompson on 7/1/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(AppleSignIn)

@interface VMAppleSignIn : NSObject

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *fullName;

- (instancetype)initWithUserId:(NSString *)userid
                         email:(NSString *)email
                     firstName:(NSString *)firstName
                      lastName:(NSString *)lastName
                     fulllName:(NSString *)fullName;
@end

NS_ASSUME_NONNULL_END
