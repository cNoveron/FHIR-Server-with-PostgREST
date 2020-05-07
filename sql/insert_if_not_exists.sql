INSERT INTO "Patient" (
        patient_id, patient_email, patient_name, patient_surname, patient_password, patient_phone, patient_sex)
    SELECT 
        patient_id, patient_email, patient_name, patient_surname, patient_password, patient_phone, patient_sex
    FROM "Patient"
    UNION
    VALUES (
        'aa206120-8ef2-11ea-bc34-47c1fcb24dc4',
        'desh365@hotmail.com',
        'John',
        'Doe',
        '$2a$12$h4qrybNUu6H3xsON6.e53u5H8MueE/1O67U0DqcBRvSLDb53l3Y6S',
        '+525530406700',
        'male'
    )
    EXCEPT
    SELECT patient_id, patient_email, patient_name, patient_surname, patient_password, patient_phone, patient_sex 
    FROM "Patient";