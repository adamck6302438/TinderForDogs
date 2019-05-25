//
//  NetworkManager.h
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-22.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
@class Dog;

@protocol NetworkManagerDelegate <NSObject>

- (void)didFetchDogs;

@end

@protocol UpdateCardDelegate <NSObject>

-(void)updateCardWithDogs;
-(void)initializeCard;

@end


@interface NetworkManager : NSObject

@property (strong, nonatomic) NSString * clientID;
@property (strong, nonatomic) NSString * clientSecret;
@property (strong, nonatomic) NSString * accessToken;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) CLLocationManager * locationManager;
@property (weak, nonatomic) id<UpdateCardDelegate> updateCardDelegate;
@property (strong, nonatomic) id <NetworkManagerDelegate> delegate;

-(void)fetchAccessToken;
-(void)fetchImageForDogsWithCompletionHandler:(void(^)(BOOL))completed;
+ (NetworkManager *) shared;

@end

NS_ASSUME_NONNULL_END
