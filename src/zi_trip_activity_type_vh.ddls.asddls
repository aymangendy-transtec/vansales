@AbapCatalog.sqlViewName: 'ZTRIP_ACTTYP_DDL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'trip activity type value help interface'
define root view zi_trip_activity_type_vh as select from zttripactivtype {
    key tripactivitytypeuuid as Tripactivitytypeuuid,
    @EndUserText.label: 'Activity Type'
    @UI.facet: [{ id: 'ActivityType' ,
               purpose: #STANDARD,
               type: #IDENTIFICATION_REFERENCE,
               label: 'Activity Type',
               position: 10
               }]   
    @UI: {
    identification: [{position: 10 }] ,
    lineItem: [{ position: 10 , importance: #HIGH }]}
    activitytype as Activitytype,
    @EndUserText.label: 'Activity Type Description'
    @UI: {
    identification: [{position: 20 }] ,
    lineItem: [{ position: 20 , importance: #HIGH }]}
    activitytypedescription as Activitytypedescription,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat
}
