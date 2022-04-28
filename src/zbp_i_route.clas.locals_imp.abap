



CLASS lhc_Route DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Route RESULT result.
    METHODS earlynumbering_cba_detail_1 FOR NUMBERING
      IMPORTING entities FOR CREATE route\_detail.
    METHODS earlynumbering_cba_detail FOR NUMBERING
      IMPORTING entities FOR CREATE Detail.

ENDCLASS.

CLASS lhc_Route IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_cba_Detail.


    " Ensure Travel ID is not set yet (idempotent)- must be checked when BO is draft-enabled
    LOOP AT entities INTO DATA(entity) WHERE Routestep IS NOT INITIAL.
      APPEND CORRESPONDING #( entity ) TO mapped-detail.
    ENDLOOP.

    DATA(entities_wo_route) = entities.
    DELETE entities_wo_route WHERE Routestep IS NOT INITIAL.

    "Get max travelID
    SELECT SINGLE FROM ztroutedetail FIELDS MAX( routestep ) INTO @DATA(max_routestep).

    " select from draft table
    SELECT SINGLE FROM ztroutedetail_d FIELDS MAX( routestep ) INTO @DATA(max_routestep_draft).

    IF max_routestep < max_routestep_draft.
      max_routestep = max_routestep_draft.
    ELSEIF max_routestep = 0.
      max_routestep += 1.
    ENDIF.


    " Set Travel ID
    LOOP AT entities_wo_route INTO entity.
      max_routestep += 1.
      entity-Routestep = max_routestep .

      APPEND VALUE #( %cid  = entity-%cid
                      "%tky is not available since we are in create
                      %key  = entity-%key
                      "needed because we are using draft
                      %is_draft = entity-%is_draft
                    ) TO mapped-detail.
    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_Detail_1.

    " Ensure Travel ID is not set yet (idempotent)- must be checked when BO is draft-enabled

    LOOP AT entities INTO DATA(entity) .
       data(cba_entities) = entity-%target.
       loop at cba_entities into data(cba_entity) WHERE Routestep is not INITIAL.
       APPEND CORRESPONDING #( cba_entity ) TO mapped-detail.
ENDLOOP.

    DATA(entities_wo_route) = cba_entities.
    DELETE entities_wo_route WHERE Routestep IS NOT INITIAL.

    "Get max travelID
    SELECT SINGLE FROM ztroutedetail FIELDS MAX( routestep )
        where route eq @entity-route
        INTO @DATA(max_routestep)
         .

    " select from draft table
    SELECT SINGLE FROM ztroutedetail_d FIELDS MAX( routestep )
        where route eq @entity-route
        INTO @DATA(max_routestep_draft).

    IF max_routestep < max_routestep_draft.
      max_routestep = max_routestep_draft.
  "  ELSEIF max_routestep = 0.
   "   max_routestep += 1.
    ENDIF.


    " Set Travel ID
    LOOP AT entities_wo_route INTO cba_entity.
      max_routestep += 1.
      cba_entity-Routestep = max_routestep .

      APPEND VALUE #( %cid  = cba_entity-%cid
                      "%tky is not available since we are in create
                      %key  = cba_entity-%key
                      "needed because we are using draft
                      %is_draft = cba_entity-%is_draft
                    ) TO mapped-detail.
    ENDLOOP.
ENDLOOP.

  ENDMETHOD.

ENDCLASS.
