CLASS lhc_feedback DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR feedback RESULT result.
    METHODS analizefeedback FOR MODIFY
      IMPORTING keys FOR ACTION feedback~analizefeedback RESULT result.

ENDCLASS.

CLASS lhc_feedback IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD analizeFeedback.
  ENDMETHOD.

ENDCLASS.
