@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'trip interface'
define root view entity zi_trip as select from zttrip

composition[0..*] of zi_trip_detail as _TripDetail 

association[1..1] to zi_route as _Route 
                    on _Route.Route = $projection.Routeuuid
                    
association[1..1] to zi_trip_status_vh as _TripStatus
                    on _TripStatus.Status = $projection.Tripstatus                    
   {
    key zttrip.tripuuid as Tripuuid,
    zttrip.tripid as Tripid,
    zttrip.routeuuid as Routeuuid,
    zttrip.salesemployee as Salesemployee,
    zttrip.startdate as Startdate,
    zttrip.starttime as Starttime,
    zttrip.enddate as Enddate,
    zttrip.endtime as Endtime,
    zttrip.tripstatus as Tripstatus,
    //zttrip.criticality as Criticality,
    zttrip.createdby as Createdby,
    zttrip.createdat as Createdat,
    zttrip.lastchangedat as Lastchangedat,
    zttrip.locallastchangedat as Locallastchangedat,
    case tripstatus 
        when '' then 1
        when 'P' then 1
        when 'S' then 2
        when 'E' then 3
     end as Criticality,
    _TripDetail, // Make association public
    _Route,
    _TripStatus
}
