//
//  ViewController.m
//  UTCTime
//
//  Created by Naveen Kumar Dungarwal on 6/16/15.
//  Copyright (c) 2015 Naveen Kumar Dungarwal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *timeAgo = [self agoStringFromTime:@"2015-06-16T09:31:13.573Z"];
    [[[UIAlertView alloc]initWithTitle:@"Time Ago" message:[NSString stringWithFormat:@"UTC Time :2015-06-16T09:31:13.573Z  \nAgo:%@",timeAgo] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
}

-(NSString*)agoStringFromTime:(NSString*) dateString
{
    
    NSString *dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    [inputDateFormatter setTimeZone:inputTimeZone];
    [inputDateFormatter setDateFormat:dateFormat];
    
    NSString *inputString = dateString;// @"20140621-061250";
    NSDate *date = [inputDateFormatter dateFromString:inputString];
    
    NSTimeZone *outputTimeZone = [NSTimeZone localTimeZone];
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
    [outputDateFormatter setTimeZone:outputTimeZone];
    [outputDateFormatter setDateFormat:dateFormat];
    NSString *outputString = [outputDateFormatter stringFromDate:date];
    NSDate *outputDate = [inputDateFormatter dateFromString:outputString];
    
    NSDate *now = [NSDate date];
    NSString *nowStr = [outputDateFormatter stringFromDate:now];
    NSDate *currentDate = [inputDateFormatter dateFromString:nowStr];
    
    //    NSLog(@"outputString...%@//////%@///////%@",outputString,date,outputDate);
    
    //    NSLog(@"currentDate...%@//////%@///////%@",nowStr,now,currentDate);
    
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setLocale:[NSLocale currentLocale]];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    //    NSLog(@"dateString %@", dateString);
    //
    //    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    //    NSLog(@"dateFromString %@", dateFromString);
    //     NSLog(@"formattedAsTimeAgo %@",[dateFromString formattedAsTimeAgo]);
    NSDictionary *timeScale = @{@"s"  :@1,
                                @"m"  :@60,
                                @"h"   :@3600,
                                @"d"  :@86400,
                                @"w" :@605800,
                                @"mo":@2629743,
                                @"y" :@31556926};
    NSString *scale;
    int timeAgo = 0-(int)[outputDate timeIntervalSinceDate:currentDate];
    if(timeAgo<0)
        timeAgo = timeAgo*-1;
    if (timeAgo < 60) {
        scale = @"s";
    } else if (timeAgo < 3600) {
        scale = @"m";
    } else if (timeAgo < 86400) {
        scale = @"h";
    } else if (timeAgo < 605800) {
        scale = @"d";
    } else if (timeAgo < 2629743) {
        scale = @"w";
    } else if (timeAgo < 31556926) {
        scale = @"mo";
    } else {
        scale = @"y";
    }
    
    //    NSLog(@"time agor..%d, scale...%@....",timeAgo,scale);
    timeAgo = timeAgo/[[timeScale objectForKey:scale] integerValue];
    NSString *s = @"";
    if (timeAgo > 1) {
        s = @"s";
    }
    
    NSLog(@"%@ ago",[NSString stringWithFormat:@"%d%@", timeAgo, scale]);
    if(timeAgo == 0 && [scale isEqualToString:@"s"])
        return @"now";
    else
        return [NSString stringWithFormat:@"%d%@", timeAgo, scale];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
