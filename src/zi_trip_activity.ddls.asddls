@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'trip activity interface'
define view entity zi_trip_activity as select from zttripactivity

association to parent zi_trip_detail as _TripDetail
    on $projection.Tripuuid = _TripDetail.Tripuuid
    and $projection.Tripstep = _TripDetail.Tripstep 

association[1..1] to zi_trip as _Trip
 on $projection.Tripuuid = _Trip.Tripuuid

     {
    key zttripactivity.tripuuid as Tripuuid,
    key zttripactivity.tripstep as Tripstep,
    key zttripactivity.tripactivity as Tripactivity,
    zttripactivity.tripid as Tripid,
    zttripactivity.routeuuid as Routeuuid,
    zttripactivity.routestep as Routestep,
    zttripactivity.activitytype as Activitytype,
    zttripactivity.activitydetail as Activitydetail,
    zttripactivity.createdby as Createdby,
    zttripactivity.createdat as Createdat,
    zttripactivity.lastchangedat as Lastchangedat,
    zttripactivity.locallastchangedat as Locallastchangedat,
    _TripDetail, // Make association public
   _Trip 
}
