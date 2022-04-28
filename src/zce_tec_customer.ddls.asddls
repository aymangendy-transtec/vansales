@EndUserText.label: 'custom entity for customer'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_TEC_CUSTOMERS'
define custom entity zce_tec_customer
{
  key Customer                       : abap.char( 10 );
      @OData.property.valueControl   : 'AuthorizationGroup_vc'
      AuthorizationGroup             : abap.char( 4 );
      AuthorizationGroup_vc          : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'BillingIsBlockedForCustomer_vc'
      BillingIsBlockedForCustomer    : abap.char( 2 );
      BillingIsBlockedForCustomer_vc : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CreatedByUser_vc'
      CreatedByUser                  : abap.char( 12 );
      CreatedByUser_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CreationDate_vc'
      CreationDate                   : rap_cp_odata_v2_edm_datetime;
      CreationDate_vc                : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CustomerAccountGroup_vc'
      CustomerAccountGroup           : abap.char( 4 );
      CustomerAccountGroup_vc        : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CustomerClassification_vc'
      CustomerClassification         : abap.char( 2 );
      CustomerClassification_vc      : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CustomerFullName_vc'
      CustomerFullName               : abap.char( 220 );
      CustomerFullName_vc            : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CustomerName_vc'
      CustomerName                   : abap.char( 80 );
      CustomerName_vc                : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'DeliveryIsBlocked_vc'
      DeliveryIsBlocked              : abap.char( 2 );
      DeliveryIsBlocked_vc           : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'NFPartnerIsNaturalPerson_vc'
      NFPartnerIsNaturalPerson       : abap.char( 1 );
      NFPartnerIsNaturalPerson_vc    : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'OrderIsBlockedForCustomer_vc'
      OrderIsBlockedForCustomer      : abap.char( 2 );
      OrderIsBlockedForCustomer_vc   : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'PostingIsBlocked_vc'
      PostingIsBlocked               : abap_boolean;
      PostingIsBlocked_vc            : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'Supplier_vc'
      Supplier                       : abap.char( 10 );
      Supplier_vc                    : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CustomerCorporateGroup_vc'
      CustomerCorporateGroup         : abap.char( 10 );
      CustomerCorporateGroup_vc      : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'FiscalAddress_vc'
      FiscalAddress                  : abap.char( 10 );
      FiscalAddress_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'Industry_vc'
      Industry                       : abap.char( 4 );
      Industry_vc                    : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'IndustryCode1_vc'
      IndustryCode1                  : abap.char( 10 );
      IndustryCode1_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'IndustryCode2_vc'
      IndustryCode2                  : abap.char( 10 );
      IndustryCode2_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'IndustryCode3_vc'
      IndustryCode3                  : abap.char( 10 );
      IndustryCode3_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'IndustryCode4_vc'
      IndustryCode4                  : abap.char( 10 );
      IndustryCode4_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'IndustryCode5_vc'
      IndustryCode5                  : abap.char( 10 );
      IndustryCode5_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'InternationalLocationNumber_vc'
      InternationalLocationNumber1   : abap.numc( 7 );
      InternationalLocationNumber_vc : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'NielsenRegion_vc'
      NielsenRegion                  : abap.char( 2 );
      NielsenRegion_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'ResponsibleType_vc'
      ResponsibleType                : abap.char( 2 );
      ResponsibleType_vc             : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TaxNumber1_vc'
      TaxNumber1                     : abap.char( 16 );
      TaxNumber1_vc                  : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TaxNumber2_vc'
      TaxNumber2                     : abap.char( 11 );
      TaxNumber2_vc                  : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TaxNumber3_vc'
      TaxNumber3                     : abap.char( 18 );
      TaxNumber3_vc                  : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TaxNumber4_vc'
      TaxNumber4                     : abap.char( 18 );
      TaxNumber4_vc                  : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TaxNumber5_vc'
      TaxNumber5                     : abap.char( 60 );
      TaxNumber5_vc                  : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TaxNumberType_vc'
      TaxNumberType                  : abap.char( 2 );
      TaxNumberType_vc               : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'VATRegistration_vc'
      VATRegistration                : abap.char( 20 );
      VATRegistration_vc             : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'DeletionIndicator_vc'
      DeletionIndicator              : abap_boolean;
      DeletionIndicator_vc           : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'ExpressTrainStationName_vc'
      ExpressTrainStationName        : abap.char( 25 );
      ExpressTrainStationName_vc     : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'TrainStationName_vc'
      TrainStationName               : abap.char( 25 );
      TrainStationName_vc            : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'CityCode_vc'
      CityCode                       : abap.char( 4 );
      CityCode_vc                    : rap_cp_odata_value_control;
      @OData.property.valueControl   : 'County_vc'
      County                         : abap.char( 3 );
      County_vc                      : rap_cp_odata_value_control;

}
