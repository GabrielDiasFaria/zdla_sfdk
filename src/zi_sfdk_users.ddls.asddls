@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Feedback Users'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SFDK_USERS
  as select from usr21
  association [1..1] to adrp as _UserAddress on $projection.UserAddressId = _UserAddress.persnumber
{
  key bname                   as BusinessName,
      persnumber              as UserAddressId,
      _UserAddress.name_first as UserName,

      _UserAddress
}
