@EndUserText.label: 'consumption view of trip'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity zc_trip as projection on zi_trip 
 {
    @EndUserText.label: 'Trip UUID'
    key Tripuuid,
    @EndUserText.label: 'Trip ID'
    Tripid,
    @EndUserText.label: 'Route UUID'
    @Consumption.valueHelpDefinition: [{ 
                    entity : {name: 'ZC_ROUTE', 
                              element: 'Route'  },
                   additionalBinding: [ { localElement: 'Routedescription',
                                          element:      'Routedescription',
                                          usage: #RESULT }] }]
    // @ObjectModel.text.element: ['Routedescription']                          
    Routeuuid,
    @EndUserText.label: 'Route Description'
    _Route.Routedescription as Routedescription,
    @EndUserText.label: 'Sales Employee'
    Salesemployee,
    @EndUserText.label: 'Start Date'
    Startdate,
    @EndUserText.label: 'Start Time'
    Starttime,
    @EndUserText.label: 'End Date'
    Enddate,
    @EndUserText.label: 'End Time'
    Endtime,
    _TripStatus.Statustext as StatusText,
    @EndUserText.label: 'Trip Status'
    @Consumption.valueHelpDefinition: [{ 
                    entity : {name: 'zi_trip_status_vh', 
                              element: 'Status'  }
                               }]
    @ObjectModel.text.element: ['StatusText']                           
    Tripstatus,
    Criticality,
    Createdby,
    Createdat,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _TripDetail: redirected to composition child zc_trip_detail,
    _Route
}
