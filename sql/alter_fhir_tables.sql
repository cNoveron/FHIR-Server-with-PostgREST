alter table diagnosticreport alter column id type uuid using id :: uuid;
alter table diagnosticreport alter column id set default uuid_generate_v4();

alter table diagnosticreport alter column txid set default 0;

alter table diagnosticreport alter column status set default 'created';