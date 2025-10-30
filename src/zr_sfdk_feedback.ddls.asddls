@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite - Feedback'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_SFDK_FEEDBACK
  as select from zi_sfdkt_001
  association [1..1] to ZI_SFDK_USERS as _Users on $projection.CreatedBy = _Users.BusinessName
{
  key FeedbackId,
      FeedbackText,
      Sentiment,
      Score,
      CreatedAt,
      CreatedBy,
      _Users.UserName,
      LastChangedAt,

      _Users
}
