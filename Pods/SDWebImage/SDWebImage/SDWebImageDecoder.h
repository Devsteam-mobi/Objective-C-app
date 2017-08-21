/*
 * This file is part of the SDWebImage package.
 * (c) Devsteam.mobi <rs@dailymotion.com>
 *
 * Created by Devsteam.mobi <https://github.com/mystcolor> on 9/28/11.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"

@interface UIImage (ForceDecode)

+ (UIImage *)decodedImageWithImage:(UIImage *)image;

@end
