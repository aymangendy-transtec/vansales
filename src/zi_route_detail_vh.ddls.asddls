@AbapCatalog.sqlViewName: 'ZI_RT_DET_VH_DDL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'route value help'
define view zi_route_detail_vh as select from zi_route_detail {
    @EndUserText.label: 'Route UUID'
    key Route,
    @EndUserText.label: 'Route Step'
    key Routestep,
    @EndUserText.label: 'Customer ID'
    Customerid,
    @EndUserText.label: 'Customer Name'
    Customername,
    @EndUserText.label: 'Location Address'
    Locationaddress,
    @EndUserText.label: 'Notes'
    Notes,
    Lastchangedat,
    Longtuide,
    Latituide,
    /* Associations */
    _Customer,
    _Route
}
