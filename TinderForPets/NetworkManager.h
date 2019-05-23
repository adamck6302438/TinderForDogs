//
//  NetworkManager.h
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-22.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

@property (strong, nonatomic) NSString * clientID;
@property (strong, nonatomic) NSString * clientSecret;
@property (strong, nonatomic) NSString * accessToken;
@property (assign, nonatomic) NSInteger currentPage;

-(void)fetchAccessToken;

@end

NS_ASSUME_NONNULL_END
