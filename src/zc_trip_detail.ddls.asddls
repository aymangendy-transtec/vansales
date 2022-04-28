@EndUserText.label: 'consumption view of trip detail'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zc_trip_detail as projection on zi_trip_detail

{
    @EndUserText.label: 'Trip UUID'
    key Tripuuid,
    @EndUserText.label: 'Trip Step'
    key Tripstep,
    @EndUserText.label: 'Trip ID'
    _Trip.Tripid as Tripid,
    @EndUserText.label: 'Route UUID'
    _Trip.Routeuuid as Routeuuid, 
    
    @EndUserText.label: 'Route Step'
    @Consumption.valueHelpDefinition: [{ 
                    entity : {name: 'zi_route_detail_vh', 
                              element: 'Routestep'  },
                     additionalBinding: [{ localElement: 'Routeuuid' ,
                                            element:     'Route' ,
                                            usage:        #FILTER  },
                                         { localElement: 'Customerid' ,
                                            element:     'Customerid' ,
                                            usage:        #RESULT  },
                                         { localElement: 'Customername' ,
                                            element:     'Customername' ,
                                            usage:        #RESULT  },
                                         { localElement: 'Locationaddress' ,
                                            element:     'Locationaddress' ,
                                            usage:        #RESULT  }] }]
    Routestep,
    @EndUserText.label: 'Customer ID'
    Customerid,
    @EndUserText.label: 'Customer Name'
    Customername,
    @EndUserText.label: 'Location Address'
    Locationaddress,
    @EndUserText.label: 'Start To Go Date'
    Starttogodate,
    @EndUserText.label: 'Start To Go Time'
    Starttogotime,
    @EndUserText.label: 'Arrival Date'
    Arrivaldate,
    @EndUserText.label: 'Arrival Time'
    Arrivaltime,
    @EndUserText.label: 'Depature Date'
    Depaturedate,
    @EndUserText.label: 'Depature Time'
    Depaturetime,
    _TripDetailStatus.Statustext as StatusText,
    @EndUserText.label: 'Trip Step Status'
    @Consumption.valueHelpDefinition: [{ 
                    entity : {name: 'zi_trip_detail_status_vh', 
                              element: 'Status'  }
                               }]
    @ObjectModel.text.element: ['StatusText'] 
    Tripstepstatus,
    Criticality,
    @EndUserText.label: 'Notes'
    Notes,
    Createdby,
    Createdat,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _Trip: redirected to parent zc_trip,
    _TripActivity: redirected to composition child zc_trip_activity
}
