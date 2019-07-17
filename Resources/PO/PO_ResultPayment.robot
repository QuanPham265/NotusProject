*** Settings ***
Library  AppiumLibrary
Library  Dialogs
Library  String
Library  Collections

*** Variables ***
## Screen RESULT PAYMENT
${ID_ResultPayment_title}               id=vn.payoo.sandbox.debug:id/lblTitleSuccess
${ID_ResultPayment_descrt}              id=vn.payoo.sandbox.debug:id/lblDescriptionSuccess
${ID_ResultPayment_service}             id=vn.payoo.sandbox.debug:id/tvService
${ID_ResultPayment_provider}            id=vn.payoo.sandbox.debug:id/tvProvider
${ID_ResultPayment_orderno}             id=vn.payoo.sandbox.debug:id/tvOrderNo
${ID_ResultPayment_total}               id=vn.payoo.sandbox.debug:id/tvTotal

*** Keywords ***
Get Result Of Payment
    ${result} =  get text  ${ID_ResultPayment_title}
    [Return]  ${result}

Get Service Name Of Payment
    ${service} =  get text  ${ID_ResultPayment_service}
    [Return]  ${service}

Get Provider Name Of Payment
    ${provider} =  get text  ${ID_ResultPayment_provider}
    [Return]  ${provider}

Get OrderNo Of Payment
    ${orderno} =  get text  ${ID_ResultPayment_orderno}
    [Return]  ${orderno}

Get Total Of Payment
    ${total} =  get text  ${ID_ResultPayment_total}
    [Return]  ${total}

Get All Information Of Payment PayBill
    wait until element is visible  ${ID_ResultPayment_title}  timeout=10s
    ${result} =     Get Result Of Payment
    ${service} =    Get Service Name Of Payment
    ${provider} =   Get Provider Name Of Payment
    ${orderno} =    Get OrderNo Of Payment
    ${total} =      Get Total Of Payment
    log many  ${result}  ${service}  ${provider}  ${orderno}  ${total}
