*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${url}    https://www.allonline.7eleven.co.th/
${btn_plus}    //*[@id="article-form"]/div[2]/div[2]/div[1]/span[2]
${name_product}    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[2]/div/a[2]/div
${check_order}    //*[@id="stepModel"]/div[1]/div[2]

*** Test Cases ***
สั่งซื้อสินค้า ไมโลนักเก็ตส์ 15 กรัม เลือกรับที่ร้านและชำระด้วยบัตรเดบิต
    เปิดเว็บ allonline
    ค้นหาคำว่า ไมโลนักเก็ตส์
    ตรวจสอบผลลัพธ์การค้นหา
    เลือกสินค้า
    เพิ่มจำนวนสินค้า
    กดซื้อสินค้า
    login ข้อมูลส่วนตัว
    เลือกจัดส่งที่ร้าน7-11
    ดำเนินการชำระเงิน
    เลือกวิธีการชำระเงินด้วยบัตรเดบิต
    ตรวจสอบสรุุปรายการสั่งซื้อ
    # กรอกข้อมูลบัตรเดบิตและยืนยัน


*** Keywords ***
เปิดเว็บ allonline
    Open Browser    url=${url}    browser=chrome
    # เปิดเต็มจอ
    Maximize Browser Window

ค้นหาคำว่า ไมโลนักเก็ตส์
    Input Text    name=q    ไมโลนักเก็ตส์
    Press Keys    None    RETURN

ตรวจสอบผลลัพธ์การค้นหา
    Wait Until Element Is Visible    xpath=${name_product}
    Element Should Contain    xpath=${name_product}    ไมโลนักเก็ตส์ ช็อกโกแลต 15 กรัม

เลือกสินค้า
    Click Element    xpath=//*[@id="btn-accept-gdpr"]
    Click Element    xpath=${name_product}

เพิ่มจำนวนสินค้า
    Wait Until Element Is Visible    xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Sleep    5s
    Element Attribute Value Should Be    xpath=//*[@id="article-form"]/div[2]/div[2]/div[1]/input    attribute=value    expected=3
กดซื้อสินค้า
    Wait Until Element Is Visible    xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button
    Click Element  xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button

login ข้อมูลส่วนตัว
    Input Text    name=email    chokherotr@gmail.com
    Input Text    name=password    Terawat61070093
    Sleep    5s
    Click Element    xpath=//*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    Sleep    5s
เลือกจัดส่งที่ร้าน7-11
    Wait Until Element Is Visible    xpath=//*[@id="address-tabs"]/ul/li[1]/a    timeout=10s
    Click Element    xpath=//*[@id="address-tabs"]/ul/li[1]/a
    Click Element    xpath=//*[@id="storefinder-selector-group"]/div[1]/div/button
    Sleep    5s
    Input Text    id=user-storenumber-input    15064
    Wait Until Element Is Visible    xpath=//*[@id="store"]/div[2]/div/div[4]/div[3]    timeout=10s
    Click Element    id=btn-check-storenumber

ดำเนินการชำระเงิน
    Wait Until Element Is Visible    id=continue-payment-btn    timeout=10s
    Click Button    id=continue-payment-btn

เลือกวิธีการชำระเงินด้วยบัตรเดบิต
    Click Element    xpath=//*[@id="payment-options"]/div[1]/button

ตรวจสอบสรุุปรายการสั่งซื้อ
    #ที่อยู่จัดส่งสินค้า
    Element Should Contain    xpath=${check_order}    ธีรวัต กาญจนปานวงษ์
    Element Should Contain    xpath=${check_order}    เบอร์โทรศัพท์ผู้รับสินค้า: 0983209928
    Element Should Contain    xpath=${check_order}    เซเว่นอีเลฟเว่น #15064 สาขา สุนทรศาลทูล ซ.2
    ...                                               เลขที่ หมู่, 8, 71/233, ต.บางเมืองใหม่ อ.เมืองสมุทรปราการ สมุทรปราการ 10270
    #รายละเอียดสินค้า
    Element Should Contain    xpath=${check_order}    ไมโลนักเก็ตส์ ช็อกโกแลต 15 กรัม 3 ฿ 327
    Element Should Contain    xpath=${check_order}    ราคา ฿ 327
    Element Should Contain    xpath=${check_order}    ค่าจัดส่ง ฟรี
    Element Should Contain    xpath=${check_order}    ยอดสุทธิ (รวมภาษีมูลค่าเพิ่ม) ฿ 327
    Wait Until Element Is Visible    xpath=//*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button    timeout=10s
    # สั่งซื้อเครดิต
    Click Element    xpath=//*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button

#     Switch Window    NEW
#     Wait Until Element Contains    
# # กรอกข้อมูลบัตรเดบิตและยืนยัน
# #     Input Text    id=cardName    นัทธา ศิริไล
# #     Input Text    id=cardNumber    5577554326574635
# #     Input Text    id=expiryDate    08/26
# #     Input Text    id=cvCode    224
# #     Click Element    id=subFormPay
#     Switch Window    MAIN