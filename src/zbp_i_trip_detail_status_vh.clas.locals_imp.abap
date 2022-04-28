CLASS lhc_zi_trip_detail_status_vh DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_trip_detail_status_vh RESULT result.

ENDCLASS.

CLASS lhc_zi_trip_detail_status_vh IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
