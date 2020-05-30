alter table patient alter column id type uuid using id :: uuid;
alter table patient alter column id set default uuid_generate_v4();

alter table patient alter column txid set default 0;

alter table patient alter column status set default 'created';


alter table practitioner alter column id type uuid using id :: uuid;
alter table practitioner alter column id set default uuid_generate_v4();

alter table practitioner alter column txid set default 0;

alter table practitioner alter column status set default 'created';


alter table diagnosticreport alter column id type uuid using id :: uuid;
alter table diagnosticreport alter column id set default uuid_generate_v4();

alter table diagnosticreport alter column txid set default 0;

alter table diagnosticreport alter column status set default 'created';