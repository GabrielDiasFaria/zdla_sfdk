@EndUserText.label: 'Consumption - Feedback'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_SFDK_FEEDBACK
  as projection on ZR_SFDK_FEEDBACK
{
  key FeedbackId,
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      @Search.defaultSearchElement: true
      FeedbackText,
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.8
      @Search.defaultSearchElement: true
      Sentiment,
      Score,
      @Semantics.systemDate.createdAt: true
      CreatedAt,
      @Semantics.user.createdBy: true      
      @ObjectModel.text.element: [ 'UserName' ]
      CreatedBy,
      UserName,
      LastChangedAt,
      /* Associations */
      _Users
}
