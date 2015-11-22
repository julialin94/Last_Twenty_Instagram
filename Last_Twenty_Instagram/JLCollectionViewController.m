//
//  ViewController.m
//  Last_Twenty_Instagram
//
//  Created by Julia Lin on 11/19/15.
//  Copyright © 2015 Julia Lin. All rights reserved.
//

#import "JLCollectionViewController.h"
#import "JLCollectionViewCell.h"

@interface JLCollectionViewController ()

@end

@implementation JLCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"recentCell";
    
    JLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
//    cell.imageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
