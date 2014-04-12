//
//  DSAAstronautCell.h
//  Liftoff
//
//  Created by Harry Slotwiner on 4/12/14.
//  Copyright (c) 2014 Disco Space Agency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface DSAAstronautCell : UITableViewCell {
    UIView *profileContainer;
}

@property (nonatomic, strong) IBOutlet EGOImageView *profile;
@property (nonatomic, strong) IBOutlet UILabel *astronautName;
@property (nonatomic, strong) IBOutlet UILabel *role;

@end
