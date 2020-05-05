alter table "Patient" add column consent boolean;

alter table "Patient_Bio" drop column patient_bio_id;
alter table "Patient_Data" drop column patient_data_id;
alter table "Patient_Bio" add column patient_birth_date date not null;
alter table "Patient_Bio" add column patient_id varchar(36) not null 
    constraint "unique" unique (patient_id)
    constraint "foreign_key" foreign key (patient_id) references "Patient"(patient_id);