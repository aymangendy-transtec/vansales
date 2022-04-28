@EndUserText.label: 'consumption view of route'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity zc_route as projection on zi_route as Route
 {
    @EndUserText.label: 'Route ID'
    key Route,
    @EndUserText.label: 'Route Description'
    Routedescription,
    @EndUserText.label: 'Sales Employee'
    Salesemployee,
    Createdby,
    Createdat,
    /* Associations */
    _Detail : redirected to composition child zc_route_detail
}
