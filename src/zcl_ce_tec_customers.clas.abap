CLASS zcl_ce_tec_customers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    INTERFACES if_rap_query_provider.
    TYPES t_customer_range TYPE RANGE OF ztec_s4_a_customer-Customer.
    TYPES t_business_data TYPE TABLE OF ztec_s4_a_customer.

    METHODS get_customers
      IMPORTING
        it_filter_cond   TYPE if_rap_query_filter=>tt_name_range_pairs   OPTIONAL
        top              TYPE i OPTIONAL
        skip             TYPE i OPTIONAL
      EXPORTING
        et_business_data TYPE  t_business_data
      RAISING
        /iwbep/cx_cp_remote
        /iwbep/cx_gateway
        cx_web_http_client_error
        cx_http_dest_provider_error
      .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ce_tec_customers IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA business_data TYPE TABLE OF ztec_s4_a_customer.
    DATA filter_conditions  TYPE if_rap_query_filter=>tt_name_range_pairs .
    DATA ranges_table TYPE if_rap_query_filter=>tt_range_option .
    "ranges_table = VALUE #( (  sign = 'I' option = 'GE' low = 'HT-1200' ) ).
    "filter_conditions = VALUE #( ( name = 'PRODUCT'  range = ranges_table ) ).

    TRY.
        get_customers(
          EXPORTING
            it_filter_cond    = filter_conditions
            top               =  5
            skip              =  1
          IMPORTING
            et_business_data  = business_data
          ) .
        out->write( business_data ).
      CATCH cx_root INTO DATA(exception).
        out->write( cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ) ).
    ENDTRY.

  ENDMETHOD.

  METHOD get_customers.


    DATA:
      " lt_business_data TYPE TABLE OF t_business_data,
      lo_http_client  TYPE REF TO if_web_http_client,
      lo_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request      TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response     TYPE REF TO /iwbep/if_cp_response_read_lst.

*DATA:
* lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
* lo_filter_node_1    TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_2    TYPE REF TO /iwbep/if_cp_filter_node,
* lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node,
* lt_range_CUSTOMER TYPE RANGE OF <element_name>,
* lt_range_AUTHORIZATIONGROUP TYPE RANGE OF <element_name>.


    TRY.
        " Create http client
*DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
*                                             comm_scenario  = 'SAP_COM_0008'
*                                             comm_system_id = '<Comm System Id>'
*                                             service_id     = '<Service Id>' ).
*lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        DATA(lo_destination) = cl_http_destination_provider=>create_by_url( i_url = 'https://sandbox.api.sap.com/s4hanacloud' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZSC_RAP_CUSTOMERS'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_BUSINESS_PARTNER' ).

        lo_http_client->get_http_request( )->set_header_field( i_name = 'APIKey'
                                                               i_value = 'qGToQpyVQwySUTvRZxG0BDLxliSfoXLn').
        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'A_CUSTOMER' )->create_request_for_read( ).

        " Create the filter tree
*lo_filter_factory = lo_request->create_filter_factory( ).
*
*lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'CUSTOMER'
*                                                        it_range             = lt_range_CUSTOMER ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'AUTHORIZATIONGROUP'
*                                                        it_range             = lt_range_AUTHORIZATIONGROUP ).

*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
*lo_request->set_filter( lo_filter_node_root ).

        lo_request->set_top( top )->set_skip( skip ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = et_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        DATA(lx_rm) = lx_remote .
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        DATA(lx_gw) = lx_gateway .

    ENDTRY.
  ENDMETHOD.
  METHOD if_rap_query_provider~select.
    DATA business_data TYPE TABLE OF ztec_s4_a_customer.
    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).

    "top = COND #( WHEN top > 25 THEN 25
     "                             ELSE top ).
    TRY.
        DATA(filter_condition) = io_request->get_filter( )->get_as_ranges( ).

        get_customers(
                 EXPORTING
                   it_filter_cond    = filter_condition
                   top               = CONV i( top )
                   skip              = CONV i( skip )
                 IMPORTING
                   et_business_data  = business_data
                 ) .

        io_response->set_total_number_of_records( lines( business_data ) ).
        io_response->set_data( business_data ).

      CATCH cx_root INTO DATA(exception).
        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
