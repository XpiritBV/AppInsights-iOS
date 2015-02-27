#import "MSAIObject.h"
#import "MSAITelemetryData.h"
#import "MSAIDomain.h"

@interface MSAIOperation : MSAIObject <NSCoding>

@property (nonatomic, copy) NSString *operationId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *rootId;

@end
