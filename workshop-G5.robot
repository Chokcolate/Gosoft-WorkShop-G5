*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${url}    https://www.allonline.7eleven.co.th/
${btn_plus}    //*[@id="article-form"]/div[2]/div[2]/div[1]/span[2]
${name_product}    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div
${check_order}    //*[@id="stepModel"]/div[1]/div[2]

*** Test Cases ***
สั่งซื้อสินค้า ไมโลบาร์ 30 กรัม เลือกรับที่ร้านและชำระด้วยบัตรเดบิต
    เปิดเว็บ allonline
    ค้นหาคำว่า ไมโลบาร์
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

ค้นหาคำว่า ไมโลบาร์
    Input Text    name=q    ไมโลบาร์
    Press Keys    None    RETURN

ตรวจสอบผลลัพธ์การค้นหา
    Wait Until Element Is Visible    xpath=${name_product}
    Element Should Contain    xpath=${name_product}    ไมโลบาร์ ช็อกโกแลต 30 กรัม

เลือกสินค้า
    Click Element    xpath=//*[@id="btn-accept-gdpr"]
    Click Element    xpath=${name_product}

เพิ่มจำนวนสินค้า
    Wait Until Element Is Visible    xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Element Attribute Value Should Be    xpath=//*[@id="article-form"]/div[2]/div[2]/div[1]/input    attribute=value    expected=6
กดซื้อสินค้า
    Wait Until Element Is Visible    xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button
    Click Element  xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button

login ข้อมูลส่วนตัว
    Input Text    name=email    abc123
    Input Text    name=password    123456
    Click Element    xpath=//*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]

เลือกจัดส่งที่ร้าน7-11
    Wait Until Element Is Visible    xpath=//*[@id="address-tabs"]/ul/li[1]/a
    Click Element    xpath=//*[@id="address-tabs"]/ul/li[1]/a
    Click Element    xpath=//*[@id="storefinder-selector-group"]/div[1]/div/button
    Input Text    id=user-storenumber-input    00903
    Wait Until Element Is Visible    xpath=//*[@id="store"]/div[2]/div/div[4]/div[3]
    Click Element    id=btn-check-storenumber

ดำเนินการชำระเงิน
    Wait Until Element Is Visible    id=continue-payment-btn
    Click Button    id=continue-payment-btn

เลือกวิธีการชำระเงินด้วยบัตรเดบิต
    Click Element    xpath=//*[@id="payment-options"]/div[1]/button

ตรวจสอบสรุุปรายการสั่งซื้อ
    #ที่อยู่จัดส่งสินค้า
    Element Should Contain    xpath=${check_order}    นัทธา ศิริไล
    Element Should Contain    xpath=${check_order}    เบอร์โทรศัพท์ผู้รับสินค้า: 0816138216
    Element Should Contain    xpath=${check_order}    เซเว่นอีเลฟเว่น #00903 สาขา สนามกอล์ฟทหารบก
    ...                                               เลขที่ ถ.รามอินทรา, 459, แขวงอนุสาวรีย์ เขตบางเขน กรุงเทพฯ 10220
    #รายละเอียดสินค้า
    Element Should Contain    xpath=${check_order}    ไมโลบาร์ ช็อกโกแลต 30 กรัม 6 ฿ 366
    Element Should Contain    xpath=${check_order}    ราคา ฿ 366
    Element Should Contain    xpath=${check_order}    ค่าจัดส่ง ฟรี
    Element Should Contain    xpath=${check_order}    ยอดสุทธิ (รวมภาษีมูลค่าเพิ่ม) ฿ 366
    Element Should Contain    xpath=${check_order}    รับ ALL member Point (คะแนน)
    ...                                               (ได้รับเมื่อชำระเงินสำเร็จ) 108
    Click Element    xpath=//*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button

# กรอกข้อมูลบัตรเดบิตและยืนยัน
#     Input Text    id=cardName    นัทธา ศิริไล
#     Input Text    id=cardNumber    5577554326574635
#     Input Text    id=expiryDate    08/26
#     Input Text    id=cvCode    224
#     Click Element    id=subFormPay