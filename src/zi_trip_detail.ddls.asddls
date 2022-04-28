@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'trip detail interface'
define view entity zi_trip_detail as select from zttripdetail

association to parent zi_trip as _Trip
    on $projection.Tripuuid = _Trip.Tripuuid
    

association[1..1] to zi_trip_detail_status_vh as _TripDetailStatus
                    on _TripDetailStatus.Status = $projection.Tripstepstatus  
                        
composition[0..*] of zi_trip_activity as _TripActivity  

   {
    key zttripdetail.tripuuid as Tripuuid,
    key zttripdetail.tripstep as Tripstep,
    zttripdetail.tripid as Tripid,
    _Trip.Routeuuid as Routeuuid,
    zttripdetail.routestep as Routestep,
    zttripdetail.starttogodate as Starttogodate,
    zttripdetail.starttogotime as Starttogotime,
    zttripdetail.arrivaldate as Arrivaldate,
    zttripdetail.arrivaltime as Arrivaltime,
    zttripdetail.depaturedate as Depaturedate,
    zttripdetail.depaturetime as Depaturetime,
    zttripdetail.customerid as Customerid,
    zttripdetail.customername as Customername,
    zttripdetail.locationaddress as Locationaddress,
    zttripdetail.tripstepstatus as Tripstepstatus,
    case tripstepstatus 
        when 'W' then 0
        when 'P' then 1
        when 'A' then 2
        when 'D' then 3
     end as Criticality,
    
    zttripdetail.notes as Notes,
    zttripdetail.createdby as Createdby,
    zttripdetail.createdat as Createdat,
    zttripdetail.lastchangedat as Lastchangedat,
    zttripdetail.locallastchangedat as Locallastchangedat,
    _Trip,
    _TripActivity,
    _TripDetailStatus
}
