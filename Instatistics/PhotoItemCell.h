//
//  PhotoItemCell.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 11/30/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface PhotoItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (nonatomic,strong) id target;



-(void)setupWithItem:(NSString*)imageUrl;
@end
