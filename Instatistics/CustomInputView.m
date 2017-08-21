//
//  CustomInputView.m
//  Instatistics
//
//  Created by Devsteam.Mobi iMac on 10/4/16.
//  Copyright © 2016 Devsteam.mobi. All rights reserved.
//

#import "CustomInputView.h"
#import "AppUtils.h"

@implementation CustomInputView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
    
    
- (void)drawRect:(CGRect)rect {

    _textField.textColor = [AppUtils inputFieldTextColor];
    _separatorImage.backgroundColor = [AppUtils separatorsColor];
    if (_textField.placeholder.length) {
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textField.placeholder attributes:@{NSForegroundColorAttributeName: [AppUtils placeholdersColor]}];
    }
}



@end
