/*      Abstract: The custom MKAnnotation object representing a venue. */#import <MapKit/MapKit.h>@interface  Venue2Annotation: NSObject <MKAnnotation>{    NSNumber *latitude;    NSNumber *longitude;}@property (nonatomic, retain) NSNumber *latitude;@property (nonatomic, retain) NSNumber *longitude;@end
