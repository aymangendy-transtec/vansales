@AbapCatalog.sqlViewName: 'ZTRIPSTATUS_DDL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'trip status value help interface'
define root view zi_trip_status_vh as select from zttripstatus {
    key tripstatusuuid as Tripstatusuuid,
    @EndUserText.label: 'StatusCode'
    @UI.facet: [{ id: 'TripStatus' ,
               purpose: #STANDARD,
               type: #IDENTIFICATION_REFERENCE,
               label: 'Trip Status',
               position: 10
               }]   
  @UI: {
    identification: [{position: 10 }] ,
    lineItem: [{ position: 10 , importance: #HIGH }]}
    status as Status,
    @EndUserText.label: 'Status'
    @UI: {
    identification: [{position: 20 }] ,
    lineItem: [{ position: 20 , importance: #HIGH }]}
    statustext as Statustext,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat
}
