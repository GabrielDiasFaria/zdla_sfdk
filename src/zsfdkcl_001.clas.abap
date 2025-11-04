CLASS zsfdkcl_001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_json,
             thinking TYPE string,
             message  TYPE string,
             isfinal  TYPE string,
           END OF ty_json.

    TYPES: BEGIN OF ty_feedback,
             sentiment TYPE string,
             score     TYPE string,
             summary   TYPE string,
             emoji     TYPE string,
           END OF ty_feedback.


    METHODS: send_message IMPORTING VALUE(iv_feedback) TYPE string
                          RETURNING VALUE(rv_feedback) TYPE ty_feedback.

  PROTECTED SECTION.

    DATA ls_json_converted TYPE ty_json.

    DATA ls_feedback TYPE ty_feedback.

    DATA lo_client TYPE REF TO if_http_client.

    METHODS: format_response IMPORTING VALUE(iv_json)     TYPE string
                             RETURNING VALUE(rv_feedback) TYPE ty_feedback.

  PRIVATE SECTION.
ENDCLASS.



CLASS zsfdkcl_001 IMPLEMENTATION.

  METHOD send_message.

    cl_http_client=>create_by_url(
        EXPORTING url     = 'https://ai.quanthra.com/api/public/external-api/b4d66993-ce4d-4520-869d-983c119a2d23/send-message/350'
        IMPORTING client  = lo_client
        EXCEPTIONS OTHERS = 1
    ).

    " Monta a Requisição
    lo_client->request->set_method( 'POST' ).
    lo_client->request->set_header_field( name = 'Content-Type' value = 'application/x-www-form-urlencoded' ).
    lo_client->request->set_header_field( name = 'Accept' value = 'application/json' ).

    " Monta o Body
    DATA(lv_body) = |message=Analise o feedback: { iv_feedback }|.
    lo_client->request->set_cdata( lv_body ).

    " Envia
    lo_client->send( EXCEPTIONS OTHERS = 1 ).

    " Recebimento
    lo_client->receive(  EXCEPTIONS OTHERS = 1 ).

    DATA lv_response TYPE string.
    lv_response = lo_client->response->get_cdata(  ).

    lo_client->close(  ).

    " Formata o Retorno
    rv_feedback = format_response( lv_response ).

  ENDMETHOD.

  METHOD format_response.

    DATA lv_formatted_response TYPE string.

    SPLIT iv_json AT cl_abap_char_utilities=>newline INTO TABLE DATA(lt_json).

    LOOP AT lt_json INTO DATA(lv_json).

      /ui2/cl_json=>deserialize(
         EXPORTING
           json = lv_json
         CHANGING
           data = ls_json_converted ).

      lv_formatted_response = |{ lv_formatted_response }{ ls_json_converted-message }|.

    ENDLOOP.

    REPLACE '```json' IN lv_formatted_response WITH ''.
    REPLACE '```' IN lv_formatted_response WITH ''.
    REPLACE ALL OCCURRENCES OF '#' IN lv_formatted_response WITH cl_abap_char_utilities=>cr_lf.

    /ui2/cl_json=>deserialize(
         EXPORTING
           json = lv_formatted_response
         CHANGING
           data = rv_feedback ).

  ENDMETHOD.

ENDCLASS.
