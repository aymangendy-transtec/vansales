@EndUserText.label: 'consumption view of route detail'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zc_route_detail as projection on zi_route_detail
                    {
    key Route,
    @EndUserText.label: 'Route Step'
    key Routestep,
    Customername,
    @EndUserText.label: 'Customer ID'
    @Consumption.valueHelpDefinition: [{ 
                    entity : {name: 'ZCE_TEC_CUSTOMER', 
                              element: 'Customer'  },
                   additionalBinding: [ { localElement: 'Customername',
                                          element:      'CustomerName',
                                          usage: #RESULT }]  }]
    @ObjectModel.text.element: ['Customername']
    Customerid ,
    //_Customer.CustomerName as CustomerName,
    @EndUserText.label: 'Location Address'
    Locationaddress,
    @EndUserText.label: 'Notes'
    Notes,
    @EndUserText.label: 'Longtuide'
    Longtuide,
    @EndUserText.label: 'Latituide'
    Latituide,
    /* Associations */
    _Route : redirected to parent zc_route,
    _Customer
}
