//
//  NetworkManager.m
//  TinderForPets
//
//  Created by Patrick Trudel on 2019-05-22.
//  Copyright © 2019 Patrick Trudel. All rights reserved.
//

#import "NetworkManager.h"
#import "TinderForPets-Swift.h"

@implementation NetworkManager

-(void)fetchAccessToken {
    
    self.clientID = @"chrzhAzFCmSjRpzhiQbMrer1RetIAtJ8vkSAFtlBHxLiUwNkfS";
    self.clientSecret = @"PGJx0pOrLGlM185SNzs2mSN2Rw15ma4JhQR98q3m";
    
    NSString * urlString = @"https://api.petfinder.com/v2/oauth2/token";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *post = [NSString stringWithFormat:@"grant_type=client_credentials&client_id=%@&client_secret=%@", self.clientID, self.clientSecret];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        self.accessToken = jsonResponse[@"access_token"];
        [self fetchDogData];
        //TODO: Make another network call using this access token.
    }];
    
    [dataTask resume];
}

-(void)fetchDogData {
//    NSMutableArray * arrayToReturn = [@[] mutableCopy];
//    
//    NSString * urlString = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%f&longitude=%f",latitude, longitude];
//    NSURL *url = [NSURL URLWithString:urlString];
//    
//    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
//    [urlRequest addValue:@"Bearer gM_n2TEHQWYQaDk-urKzj5klKc2sT74XP0FKmW_SHZTVCqB41hOmaZz6RUt3aQTdx0DnGOPmn-TMdyDJnBPl2tT3Tf4tx9H8PnTRc8Vxz1mNuCRKZGUcD878cOLeXHYx" forHTTPHeaderField:@"Authorization"];
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        if (error) {
//            NSLog(@"error: %@", error.localizedDescription);
//            return;
//        }
//        
//        NSError *jsonError = nil;
//        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//        NSArray *cafes = jsonResponse[@"businesses"];
//        
//        if (jsonError) {
//            NSLog(@"jsonError: %@", jsonError.localizedDescription);
//            return;
//        }
//        
//        for (NSDictionary *json in cafes) {
//            Cafe * cafe = [Cafe initWithJSON:json];
//            
//            [self getImageForURL:cafe.imageURL complete:^(UIImage * _Nonnull image) {
//                cafe.image = image;
//            }];
//            
//            [arrayToReturn addObject:cafe];
//        }
//        complete(arrayToReturn);
//    }];
//    
//    [dataTask resume];
}


@end
