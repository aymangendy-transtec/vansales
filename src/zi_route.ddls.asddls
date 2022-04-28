@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'route interface'
define root view entity zi_route as select from ztroute as Route
composition[0..*] of  zi_route_detail as _Detail
 {
    key route as Route,
    routedescription as Routedescription,
    salesemployee as Salesemployee,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdat as Createdat,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat as Lastchangedat,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    locallastchangedat as Locallastchangedat, 
    _Detail // Make association public
}
