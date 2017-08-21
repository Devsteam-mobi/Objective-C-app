//
//  AppConstants.h
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppConstants:NSObject

@end


typedef enum   {
    _new_followers,
    _lost_followers,
    _new_followings,
    _mutual,
    _not_following_me_back,
    _i_am_not_following_back,
    _deleted_comments,
    _deleted_likes
} UserEventType;

typedef enum   {
    _connected,
    _not_connected,
} ConnectionState;

typedef enum   {
    _help,
    _contact_us,
} RequestName;



#define UPGRADE_ID_1 @"mobi.devsteam.instatisticsapp.1month"
#define YANDEX_ID @"69eaf537-229b-4b76-b9f7-4bbcfdc35633"

#define MAINLINK @"http://Devsteam.Mobi/appstore/instagram/instatistics/"

#define appErrorDomain @"Instatistics"
#define _lato_font_heavy @"Lato-Heavy"
#define _lato_font_regular @"Lato-Regular"
#define _lato_font_black @"Lato-Black"
#define _lato_font_bold @"Lato-Bold"
#define _lato_font_light @"Lato-Light"
#define _helveticaNeue_font_regular @"HelveticaNeue"


#define segue_showAccountState @"showAccountState"
#define segue_showUserStatistics @"showUserStatistics"
#define segue_showMyPosts @"showMyPosts"
#define segue_showAudience @"showAudience"
#define segue_showStatistics @"showStatistics"
#define segue_showStartPage @"showStartPage"
#define segue_showEngagement @"showEngagement"
#define segue_showUserEvents @"showUserEvents"
#define segue_showUpgradeView @"showUpgradeView"
#define segue_showUserProfile @"showUserProfile"
#define segue_showLoginView @"showLoginView"
#define segue_showUserAudienceTops @"showUserAudienceTops"
#define segue_showUserEngagementTops @"showUserEngagementTops"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
