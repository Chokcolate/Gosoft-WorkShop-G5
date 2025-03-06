*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${url}    https://www.allonline.7eleven.co.th/
${btn_plus}    //*[@id="article-form"]/div[2]/div[2]/div[1]/span[2]
${name_product1}    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div
${name_product2}    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div/div/a[2]/div
${check_order}    //*[@id="stepModel"]/div[1]/div[2]

*** Test Cases ***
สั่งซื้อสินค้า ซอยแคท อาหารแมวและ มีโอ อาหารแมว ปลาทูน่า เลือกรับที่ร้านและชำระเงินด้วยทรูมันนี่ วอลเล็ท
    เปิดเว็บ allonline
    ค้นหาคำว่า ซอยแคท อาหารแมว
    ตรวจสอบผลลัพธ์การค้นหาซอยแคท อาหารแมว
    เลือกสินค้าซอยแคท อาหารแมว
    เพิ่มจำนวนสินค้า
    กดซื้อสินค้าซอยแคทไว้ในตะกร้า
    ค้นหาคำว่า มีโอ อาหารแมว ปลาทูน่า
    ตรวจสอบผลลัพธ์การค้นหามีโอ อาหารแมว ปลาทูน่า
    เลือกสินค้ามีโอ อาหารแมว ปลาทูน่า
    กดซื้อสินค้ามีโอไว้ในตะกร้า
    ชำระสินค้า
    login ข้อมูลส่วนตัว
    เลือกจัดส่งที่ร้าน7-11
    ดำเนินการชำระเงิน
    เลือกวิธีการชำระเงินด้วยทรูวอลเลท
    # ตรวจสอบสรุุปรายการสั่งซื้อ
    # กรอกข้อมูลบัตรเดบิตและยืนยัน


*** Keywords ***
เปิดเว็บ allonline
    Open Browser    url=${url}    browser=chrome
    Maximize Browser Window

ค้นหาคำว่า ซอยแคท อาหารแมว
    Input Text    name=q    ซอยแคท อาหารแมว
    Press Keys    None    RETURN

ตรวจสอบผลลัพธ์การค้นหาซอยแคท อาหารแมว
    Wait Until Element Is Visible    xpath=${name_product1}
    Element Should Contain    xpath=${name_product1}    ซอยแคท อาหารแมว 1 มิกซ์ 1 กก.

เลือกสินค้าซอยแคท อาหารแมว
    Click Element    xpath=//*[@id="btn-accept-gdpr"]
    Click Element    xpath=${name_product1}

เพิ่มจำนวนสินค้า
    Wait Until Element Is Visible    xpath=${btn_plus}
    Click Element  xpath=${btn_plus}
    Element Attribute Value Should Be    name=order_count    attribute=value    expected=2
กดซื้อสินค้าซอยแคทไว้ในตะกร้า
    Wait Until Element Is Visible    xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button
    Click Element  xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button

ค้นหาคำว่า มีโอ อาหารแมว ปลาทูน่า
    Input Text    name=q    มีโอ อาหารแมว ปลาทูน่า
    Press Keys    None    RETURN

ตรวจสอบผลลัพธ์การค้นหามีโอ อาหารแมว ปลาทูน่า
    Wait Until Element Is Visible    xpath=${name_product2}
    Element Should Contain    xpath=${name_product2}    มีโอ อาหารแมว ปลาทูน่า 1 กก.

เลือกสินค้ามีโอ อาหารแมว ปลาทูน่า
    Click Element    xpath=//*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div
กดซื้อสินค้ามีโอไว้ในตะกร้า
    Wait Until Element Is Visible    xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button
    Click Element  xpath=//*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button

ชำระสินค้า
    Click Element    id=mini-basket
    Sleep    5s
    Scroll Element Into View    xpath=//*[@id="page"]/div[2]/div[2]/div[2]/div[1]/div[16]/div/div/div/a
    Wait Until Element Is Visible    xpath=//*[@id="page"]/div[2]/div[2]/div[2]/div[1]/div[16]/div/div/div/a    timeout=10s
    Click Element    xpath=//*[@id="page"]/div[2]/div[2]/div[2]/div[1]/div[16]/div/div/div/a


login ข้อมูลส่วนตัว
    Input Text    name=email    chokherotr@gmail.com
    Input Text    name=password    Terawat61070093
    Sleep    5s
    Click Element    xpath=//*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    Sleep    5s

เลือกจัดส่งที่ร้าน7-11
    Click Element    xpath=//*[@id="address-tabs"]/ul/li[1]/a
    Click Element    xpath=//*[@id="storefinder-selector-group"]/div[1]/div/button
    Sleep    5s
    Input Text    xpath=//*[@id="user-storenumber-input"]    04811
    # Wait Until Element Is Visible    id=btn-check-storenumber
    Click Element    id=btn-check-storenumber

ดำเนินการชำระเงิน
    Wait Until Element Is Visible    id=continue-payment-btn
    Click Button    id=continue-payment-btn

ตรวจสอบสรุุปรายการสั่งซื้อ
    #ที่อยู่จัดส่งสินค้า
    Element Should Contain    xpath=${check_order}    ธีรวัต กาญจนปานวงษ์
    Element Should Contain    xpath=${check_order}    เบอร์โทรศัพท์ผู้รับสินค้า: 0983209928
    Element Should Contain    xpath=${check_order}    เซเว่นอีเลฟเว่น #04811 สาขา สวนสยามซอย 1
    ...                                               เลขที่ ถ.สวนสยาม, 37,39, แขวงคันนายาว เขตคันนายาว กรุงเทพฯ 10230
    #รายละเอียดสินค้า
    Element Should Contain    xpath=${check_order}    ซอยแคท อาหารแมว 1 มิกซ์ 1 กก. 2 ฿ 138
    Element Should Contain    xpath=${check_order}    มีโอ อาหารแมว ปลาทูน่า 1 กก. 1 ฿ 126
    Element Should Contain    xpath=${check_order}    ราคา ฿ 264
    Element Should Contain    xpath=${check_order}    ค่าจัดส่ง ฟรี
    Element Should Contain    xpath=${check_order}    ยอดสุทธิ (รวมภาษีมูลค่าเพิ่ม) ฿ 264
    Element Should Contain    xpath=${check_order}    รับ ALL member Point (คะแนน)
    ...                                               (ได้รับเมื่อชำระเงินสำเร็จ) 78
    # Click Element    xpath=//*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button

เลือกวิธีการชำระเงินด้วยทรูวอลเลท
    Click Element    xpath=//*[@id="payment-options"]/div[2]/button
    Sleep    5s
    Input Text    id=checkoutData.paymentData.trueMoneyMobileNumber    0983209928
    Press Keys    None    RETURN
