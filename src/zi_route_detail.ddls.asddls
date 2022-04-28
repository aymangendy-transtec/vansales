@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'route detail interface'
define view entity zi_route_detail as select from ztroutedetail as Detail

association to parent zi_route as _Route
    on $projection.Route = _Route.Route

association[1..1] to zce_tec_customer as _Customer 
                    on _Customer.Customer = $projection.Customerid
                    
     {
    key route as Route,
    key routestep as Routestep,
    customerid as Customerid,
    customername as Customername,
    locationaddress as Locationaddress,
    notes as Notes,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat as Lastchangedat,
    longtuide as Longtuide,
    latituide as Latituide,
    _Route, // Make association public
    _Customer
}
