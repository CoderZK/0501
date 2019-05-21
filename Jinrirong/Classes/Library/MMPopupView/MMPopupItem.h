//
//  MMActionItem.h
//  MMPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MMPopupItemHandler)(NSInteger index);
typedef void (^MMPopupItemHandler1)(NSInteger index,int selectIndex);

@interface MMPopupItem : NSObject

@property (nonatomic, assign) BOOL     highlight;
@property (nonatomic, assign) BOOL     disabled;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor  *color;

@property (nonatomic, copy)   MMPopupItemHandler handler;
@property (nonatomic,copy)MMPopupItemHandler1 handler1;
@end

typedef NS_ENUM(NSUInteger, MMItemType) {
    MMItemTypeNormal,
    MMItemTypeHighlight,
    MMItemTypeDisabled
};

NS_INLINE MMPopupItem* MMItemMake(NSString* title, MMItemType type, MMPopupItemHandler handler)
{
    MMPopupItem *item = [MMPopupItem new];
    
    item.title = title;
    item.handler = handler;
    
    switch (type)
    {
        case MMItemTypeNormal:
        {
            break;
        }
        case MMItemTypeHighlight:
        {
            item.highlight = YES;
            break;
        }
        case MMItemTypeDisabled:
        {
            item.disabled = YES;
            break;
        }
        default:
            break;
    }
    
    return item;
}

NS_INLINE MMPopupItem* MMItemMake1(NSString* title, MMItemType type, MMPopupItemHandler1 handler1)
{
    MMPopupItem *item = [MMPopupItem new];
    
    item.title = title;
    item.handler1 = handler1;
    
    switch (type)
    {
        case MMItemTypeNormal:
        {
            break;
        }
        case MMItemTypeHighlight:
        {
            item.highlight = YES;
            break;
        }
        case MMItemTypeDisabled:
        {
            item.disabled = YES;
            break;
        }
        default:
            break;
    }
    
    return item;
}