insert into "Patient" (
        patient_id, patient_email, patient_name, patient_surname, patient_password, patient_phone, patient_sex)
    select 
        patient_id, patient_email, patient_name, patient_surname, patient_password, patient_phone, patient_sex
    from "Patient"
    union
    values (
        'aa206120-8ef2-11ea-bc34-47c1fcb24dc4',
        'john@hotmail.com',
        'john',
        'doe',
        '$2a$12$h4qrybnuu6h3xson6.e53u5h8muee/1o67u0dqcbrvsldb53l3y6s',
        '+525511002200',
        'male'
    )
    except
    select patient_id, patient_email, patient_name, patient_surname, patient_password, patient_phone, patient_sex 
    from "Patient";