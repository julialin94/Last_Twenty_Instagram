//
//  ViewController.m
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import "LTICollectionViewController.h"
#import "LTICollectionViewCell.h"
#import "LTIAccessTokenManager.h"
#import "LTIAPIManager.h"
#import "LTIConstants.h"

#import <PINRemoteImage/UIImageView+PINRemoteImage.h>

@interface LTICollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray * recentMedia;

@end

@implementation LTICollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationFired:)
                                                 name:LOGIN_NOTIFICATION
                                               object:nil];
    
    if (![LTIAccessTokenManager accessToken]) {
        [self authenticate];
    }
    else {
        [self getRecentMedia];
    }
}

-(void)authenticate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://instagram.com/oauth/authorize/?client_id=94026f0150eb4ff6ac201289ff6556c8&redirect_uri=LastTwentyInstagram://&response_type=token"]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:LOGIN_NOTIFICATION
                                                  object:nil];
}

-(void)notificationFired:(id)notification {
    [self getRecentMedia];
}

-(void)getRecentMedia {
    [LTIAPIManager getSelfRecentMediaWithCount:[NSNumber numberWithInt:20]
                                andCompletion:^(NSDictionary * data, NSError * error) {
                                    if (error) {
                                        [self getRecentMediaFailedWithError:error];
                                    }
                                    else {
                                        [self getRecentMediaSuccessWithData:data];
                                    }
                                }];

}

-(void)getRecentMediaFailedWithError:(NSError *)error {
    NSString * message;
    UIAlertAction * action;
    if (error.code == NSURLErrorBadServerResponse) {
        message = @"Please log in again.";
        action = [UIAlertAction actionWithTitle:@"Okay"
                                 style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            NSLog(@"action: %@", action);
                                            [self authenticate];
                                        }];
    }
    else {
        message = @"Unable to get recent media.";
        action = [UIAlertAction actionWithTitle:@"Okay"
                                 style:UIAlertActionStyleDefault
                                        handler:nil];
    }
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:nil
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:action];
    [self presentViewController:ac
                       animated:YES
                     completion:nil];
}

-(void)getRecentMediaSuccessWithData:(NSDictionary *)data {
    self.recentMedia = data[@"data"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recentMedia.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"recentCell";
    
    LTICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageView.image = nil;
    NSDictionary * mediaDetails = self.recentMedia[indexPath.row];
    NSString * imageUrl = mediaDetails[@"images"][@"standard_resolution"][@"url"];
    [cell.imageView pin_setImageFromURL:[NSURL URLWithString:imageUrl]];
    return cell;
}

@end
