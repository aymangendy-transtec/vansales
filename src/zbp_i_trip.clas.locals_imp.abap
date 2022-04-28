CLASS lhc_tripdetail DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS arrived FOR MODIFY
      IMPORTING keys FOR ACTION TripDetail~arrived RESULT result.

    METHODS depatured FOR MODIFY
      IMPORTING keys FOR ACTION TripDetail~depatured RESULT result.

    METHODS goToCustomer FOR MODIFY
      IMPORTING keys FOR ACTION TripDetail~goToCustomer RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR TripDetail RESULT result.
    METHODS earlynumbering_cba_Tripactivit FOR NUMBERING
      IMPORTING entities FOR CREATE TripDetail\_Tripactivity.

ENDCLASS.

CLASS lhc_tripdetail IMPLEMENTATION.

  METHOD arrived.
    MODIFY ENTITIES OF zi_trip IN LOCAL MODE
             ENTITY TripDetail
                UPDATE FIELDS ( Tripstepstatus Arrivaldate Arrivaltime )
                   WITH VALUE #( FOR key IN keys ( %tky      = key-%tky
                                                   Tripstepstatus = 'A'
                                                   Arrivaldate = cl_abap_context_info=>get_system_date(  )
                                                   Arrivaltime = cl_abap_context_info=>get_system_time( ) ) ). " Started

    " Read changed data for action result
    READ ENTITIES OF zi_trip IN LOCAL MODE
      ENTITY TripDetail
         ALL FIELDS WITH
         CORRESPONDING #( keys )
       RESULT DATA(trip_details).

    result = VALUE #( FOR trip_detail IN trip_details ( %tky      = trip_detail-%tky
                                                         %param    = trip_detail ) ).
  ENDMETHOD.

  METHOD depatured.
    MODIFY ENTITIES OF zi_trip IN LOCAL MODE
            ENTITY TripDetail
               UPDATE FIELDS ( Tripstepstatus Depaturedate Depaturetime )
                  WITH VALUE #( FOR key IN keys ( %tky      = key-%tky
                                                  Tripstepstatus = 'D'
                                                  Depaturedate = cl_abap_context_info=>get_system_date(  )
                                                  Depaturetime = cl_abap_context_info=>get_system_time( ) ) ). " Started

    " Read changed data for action result
    READ ENTITIES OF zi_trip IN LOCAL MODE
      ENTITY TripDetail
         ALL FIELDS WITH
         CORRESPONDING #( keys )
       RESULT DATA(trip_details).

    result = VALUE #( FOR trip_detail IN trip_details ( %tky      = trip_detail-%tky
                                                         %param    = trip_detail ) ).
  ENDMETHOD.

  METHOD goToCustomer.
    MODIFY ENTITIES OF zi_trip IN LOCAL MODE
            ENTITY TripDetail
               UPDATE FIELDS ( Tripstepstatus Starttogodate Starttogotime )
                  WITH VALUE #( FOR key IN keys ( %tky      = key-%tky
                                                  Tripstepstatus = 'W'
                                                  Starttogodate = cl_abap_context_info=>get_system_date(  )
                                                  Starttogotime = cl_abap_context_info=>get_system_time( ) ) ). " Started

    " Read changed data for action result
    READ ENTITIES OF zi_trip IN LOCAL MODE
      ENTITY TripDetail
         ALL FIELDS WITH
         CORRESPONDING #( keys )
       RESULT DATA(trip_details).

    result = VALUE #( FOR trip_detail IN trip_details ( %tky      = trip_detail-%tky
                                                         %param    = trip_detail ) ).
  ENDMETHOD.

  METHOD earlynumbering_cba_Tripactivit.
    LOOP AT entities INTO DATA(entity) .
      DATA(cba_entities) = entity-%target.
      LOOP AT cba_entities INTO DATA(cba_entity) WHERE Tripactivity IS NOT INITIAL.
        APPEND CORRESPONDING #( cba_entity ) TO mapped-tripactivity.
      ENDLOOP.

      DATA(entities_wo_route) = cba_entities.
      DELETE entities_wo_route WHERE Tripactivity IS NOT INITIAL.

      "Get max travelID
      SELECT SINGLE FROM zttripactivity FIELDS MAX( tripactivity )
          WHERE tripuuid EQ @entity-tripuuid
          INTO @DATA(max_tripactivity)
           .

      " select from draft table
      SELECT SINGLE FROM zttripactivity_d FIELDS MAX( tripactivity )
          WHERE tripuuid EQ @entity-tripuuid
          INTO @DATA(max_tripactivity_draft).

      IF max_tripactivity < max_tripactivity_draft.
        max_tripactivity = max_tripactivity_draft.
      ENDIF.


      " Set Travel ID
      LOOP AT entities_wo_route INTO cba_entity.
        max_tripactivity += 1.
        cba_entity-tripactivity = max_tripactivity .

        APPEND VALUE #( %cid  = cba_entity-%cid
                        "%tky is not available since we are in create
                        %key  = cba_entity-%key
                        "needed because we are using draft
                        %is_draft = cba_entity-%is_draft
                      ) TO mapped-tripactivity.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_trip IN LOCAL MODE
  ENTITY TripDetail
  ALL FIELDS
  WITH CORRESPONDING #( keys )
  RESULT DATA(tripdetails).



    result = VALUE #( FOR tripdetail IN tripdetails
    ( %tky = tripdetail-%tky



    %field-Customerid = COND #( WHEN tripdetail-Routestep IS INITIAL
    THEN if_abap_behv=>fc-f-unrestricted
    ELSE if_abap_behv=>fc-f-read_only )
    %field-Customername = COND #( WHEN tripdetail-Routestep IS INITIAL
    THEN if_abap_behv=>fc-f-unrestricted
    ELSE if_abap_behv=>fc-f-read_only )
    %field-Locationaddress = COND #( WHEN tripdetail-Routestep IS INITIAL
    THEN if_abap_behv=>fc-f-unrestricted
    ELSE if_abap_behv=>fc-f-read_only )
    )    ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_trip DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Trip RESULT result.
    METHODS starttripaction FOR MODIFY
      IMPORTING keys FOR ACTION trip~startTrip RESULT result.
    METHODS endtrip FOR MODIFY
      IMPORTING keys FOR ACTION trip~endTrip RESULT result.
    METHODS setTripId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Trip~setTripId.
    METHODS earlynumbering_cba_Tripdetail FOR NUMBERING
      IMPORTING entities FOR CREATE Trip\_Tripdetail.

ENDCLASS.

CLASS lhc_trip IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD starttripaction.
    MODIFY ENTITIES OF zi_trip IN LOCAL MODE
             ENTITY Trip
                UPDATE FIELDS ( tripstatus Startdate Starttime )
                   WITH VALUE #( FOR key IN keys ( %tky      = key-%tky
                                                   tripstatus = 'S'
                                                   Startdate = cl_abap_context_info=>get_system_date(  )
                                                   Starttime = cl_abap_context_info=>get_system_time( ) ) ). " Started

    " Read changed data for action result
    READ ENTITIES OF zi_trip IN LOCAL MODE
      ENTITY trip
         ALL FIELDS WITH
         CORRESPONDING #( keys )
       RESULT DATA(trips).

    result = VALUE #( FOR trip IN trips ( %tky      = trip-%tky
                                              %param    = trip ) ).
  ENDMETHOD.

  METHOD endTrip.
    MODIFY ENTITIES OF zi_trip IN LOCAL MODE
             ENTITY Trip
                UPDATE FIELDS ( tripstatus Enddate Endtime )
                   WITH VALUE #( FOR key IN keys ( %tky      = key-%tky
                                                   tripstatus = 'E'
                                                   Enddate = cl_abap_context_info=>get_system_date(  )
                                                   Endtime = cl_abap_context_info=>get_system_time( ) ) ). " Ended

    " Read changed data for action result
    READ ENTITIES OF zi_trip IN LOCAL MODE
      ENTITY trip
         ALL FIELDS WITH
         CORRESPONDING #( keys )
       RESULT DATA(trips).

    result = VALUE #( FOR trip IN trips ( %tky      = trip-%tky
                                              %param    = trip ) ).
  ENDMETHOD.

  METHOD earlynumbering_cba_Tripdetail.

    LOOP AT entities INTO DATA(entity) .
      DATA(cba_entities) = entity-%target.
      LOOP AT cba_entities INTO DATA(cba_entity) WHERE tripstep IS NOT INITIAL.
        APPEND CORRESPONDING #( cba_entity ) TO mapped-tripdetail.
      ENDLOOP.

      DATA(entities_wo_route) = cba_entities.
      DELETE entities_wo_route WHERE tripstep IS NOT INITIAL.

      "Get max travelID
      SELECT SINGLE FROM zttripdetail FIELDS MAX( tripstep )
          WHERE tripuuid EQ @entity-tripuuid
          INTO @DATA(max_tripstep)
           .

      " select from draft table
      SELECT SINGLE FROM zttripdetail_d FIELDS MAX( tripstep )
          WHERE tripuuid EQ @entity-tripuuid
          INTO @DATA(max_tripstep_draft).

      IF max_tripstep < max_tripstep_draft.
        max_tripstep = max_tripstep_draft.
      ENDIF.


      " Set Travel ID
      LOOP AT entities_wo_route INTO cba_entity.
        max_tripstep += 1.
        cba_entity-tripstep = max_tripstep .

        APPEND VALUE #( %cid  = cba_entity-%cid
                        "%tky is not available since we are in create
                        %key  = cba_entity-%key
                        "needed because we are using draft
                        %is_draft = cba_entity-%is_draft
                      ) TO mapped-tripdetail.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD setTripId.

    " Read entity to check if travel id is initial
    READ ENTITIES OF zi_trip IN LOCAL MODE
    ENTITY Trip
      FIELDS (  Tripid )
      WITH CORRESPONDING #( keys )
    RESULT   DATA(lt_trip_result).

    " only modify entities where no travel_id is given
    DELETE lt_trip_result WHERE tripid IS NOT INITIAL.

    LOOP AT lt_trip_result ASSIGNING FIELD-SYMBOL(<fs_trip>).
      " get a new travel ID
      "Get max travelID
      SELECT SINGLE FROM zttrip FIELDS MAX( tripid )
          INTO @DATA(max_tripid)
           .
      " select from draft table
      SELECT SINGLE FROM zttrip_d FIELDS MAX( tripid )
          INTO @DATA(max_tripid_draft).

      IF max_tripid < max_tripid_draft.
        max_tripid = max_tripid_draft.
      ENDIF.

      max_tripid += 1.
      <fs_trip>-tripid = max_tripid.
      MODIFY ENTITIES OF zi_trip IN LOCAL MODE
             ENTITY Trip
                UPDATE FIELDS ( tripid )
                   WITH VALUE #( FOR key IN keys ( %tky      = key-%tky
                                                   tripid = max_tripid ) ).
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
