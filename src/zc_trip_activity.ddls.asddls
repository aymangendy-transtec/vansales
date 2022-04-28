@EndUserText.label: 'consumption view of trip activity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity zc_trip_activity as projection on zi_trip_activity {
    @EndUserText.label: 'Trip UUID'
    key Tripuuid,
    @EndUserText.label: 'Trip Step'
    key Tripstep,
    @EndUserText.label: 'Trip Activity'
    key Tripactivity,
    @EndUserText.label: 'Trip ID'
    _Trip.Tripid as Tripid,
    @EndUserText.label: 'Route UUID'
    _Trip.Routeuuid as Routeuuid,
    @EndUserText.label: 'Route Step'
    Routestep,
    @EndUserText.label: 'Activity Type'
    @Consumption.valueHelpDefinition: [{ 
                    entity : {name: 'zi_trip_activity_type_vh', 
                              element: 'Activitytype'  }
                               }]    
    Activitytype,
    @EndUserText.label: 'Activity Detail'
    Activitydetail,
    _TripDetail.Customername as CustomerName,
    Createdby,
    Createdat,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _Trip: redirected to zc_trip,
    _TripDetail: redirected to parent zc_trip_detail
}
