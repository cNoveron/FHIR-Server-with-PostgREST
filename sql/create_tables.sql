create table if not exists "Patient" (
    patient_id varchar(36) not null primary key,
    patient_email varchar(60),
    patient_sex varchar(10),
    patient_password varchar(60),
    patient_phone varchar(15),
    phone_verified boolean,
    email_verified boolean,
    sms_code varchar(4),
    email_code varchar(4),
    patient_name varchar(100),
    patient_surname varchar(100),
    consent boolean
);

create table if not exists "Patient_Bio" (
    patient_id varchar(36) not null,
    patient_blood_type text not null,
    patient_height numeric(3,0) not null, 
    patient_weight numeric(3,0) not null, 
    patient_birth_date date not null,
    foreign key (patient_id) references "Patient" (patient_id)
);