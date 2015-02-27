#import "MSAIStackFrame.h"
#import "MSAIObject.h"
#import "MSAITelemetryData.h"
#import "MSAIDomain.h"

@interface MSAIExceptionDetails : MSAIObject <NSCoding>

@property (nonatomic, copy) NSNumber *exceptionDetailsId;
@property (nonatomic, copy) NSNumber *outerId;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL hasFullStack;
@property (nonatomic, copy) NSString *stack;
@property (nonatomic, copy) NSMutableArray *parsedStack;

@end
