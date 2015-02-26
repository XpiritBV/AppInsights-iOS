@class MSAIEnvelope;
@class MSAITelemetryData;
@class MSAITelemetryContext;
@class MSAIPLCrashReport;
#import <Foundation/Foundation.h>
#import "MSAIEnvelopeManager.h"

@interface MSAIEnvelopeManager()

///-----------------------------------------------------------------------------
/// @name Initialize and configure singleton instance
///-----------------------------------------------------------------------------

/**
 *  The context object, which contains information about current session, the device, the user etc.
 */
@property(nonatomic, strong, readonly)MSAITelemetryContext *telemetryContext;

/**
 *  Get the singleton instance.
 *
 *  @return the singleton instance
 */
+ (instancetype)sharedManager;

/**
 *  Configure the manager with a given context object.
 *
 *  @param telemetryContext information about the client and the AI account
 */
- (void)configureWithTelemetryContext:(MSAITelemetryContext *)telemetryContext;

///-----------------------------------------------------------------------------
/// @name Update context
///-----------------------------------------------------------------------------

// TODO: Use Notifications instead

/**
 *  Renews all session context information used to create an envelope.
 */
- (void)createNewSession;

///-----------------------------------------------------------------------------
/// @name Create envelope objects
///-----------------------------------------------------------------------------

/**
 *  Creates an envelope object with the current context information, but without any base data.
 *
 *  @return the created envelope object
 */
- (MSAIEnvelope *)envelope;

/**
 *  Creates an envelope object with the current context information and base data.
 *
 *  @param telemetryData the base data for the envelope
 *
 *  @return the created envelope object
 */
- (MSAIEnvelope *)envelopeForTelemetryData:(MSAITelemetryData *)telemetryData;

/**
 *  Creates an envelope object based on the information of a given crash report.
 *
 *  @param report the crash report which contains context and exception information.
 *
 *  @return an envelope object that contains a crash report
 */
- (MSAIEnvelope *)envelopeForCrashReport:(MSAIPLCrashReport *)report;

/**
 *  Creates an envelope object based on the information of a given crash report. This method is
 *  used to send handled exception rather than crashs.
 *
 *  @param report    the report, which contains context as well as exception information
 *  @param exception a handled exception object
 *
 *  @return an envelope object that contains a handled exception
 */
- (MSAIEnvelope *)envelopeForCrashReport:(MSAIPLCrashReport *)report exception:(NSException *)exception;

@end
