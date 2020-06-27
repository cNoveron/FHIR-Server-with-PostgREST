```json
{
  "resource": {
    "photo": "url",
    "name": "Miranda",
    "lastName": "Perea",
    "secLastName": "Moreno",
    "birthday": "02/12/1934",
    "mainSpecialty": {
      "name": "Médico Familiar",
      "id": 1234567,
      "front": "url",
      "back": "url",
      "valid": true
    },
    "gender": "female",
    "phoneNumber": 213123123,
    "registerNumber": 432423432,
    "rating": 5,
```
```json
    "mainOffice": {
      "name": "Clínica Gran Sur", // <-- location_name
      "phoneNumber": [213123123, 328923829], // fhir_server.r_locations_by_practitioner.location_phone
      // Los teléfonos no deben ser integers sino strings
      "address": {
        "street": "Avery Brundage 6", // fhir_server.r_locations_by_practitioner.location_address
        "suburb": "Olímpica",         // omitir o usar como segunda línea (concatenar después de `street` en el front)
        "area": "Coyoacan",           // fhir_server.r_locations_by_practitioner.location_city
        "state": "Ciudad de México",  // fhir_server.r_locations_by_practitioner.location_state
        "cp": "04710"                 // fhir_server.r_locations_by_practitioner.location_postalCode
      },
      "insurance": ["AXA", "GNP", "Santander"], // teeb.practitioner.insurance PENDIENTE
      "schedule": {                   // fhir_server.r_appointments_in_schedules_of_actor
        "days": ["Lun", "Mie", "Vie"],// si queremos desplegar días, se necesitará más lógica en el front
        "time": [
          {"from": "10:00am",        // fhir_server.r_schedules_by_actor.schedule_planningHorizon
            "to": "4:00pm"
          },
          { "from": "07:00pm", "to": "09:00pm" }
        ]
      },
      "appTypes": [
        { "type": "Online", "price": 1000, "prepayment": 500 },
        { "type": "Live", "price": 2000, "prepayment": 600 },
        { "type": "Home", "price": 5000, "prepayment": 800 }
      ],
      "services": ["Consulta general", "Valoración preoperatoria"]
    },
    "career": {
      "school": ["UNAM", "ITESM"],
      "specialty": [
        { "name": "Médico Familiar", "id": 1234567, "certificateId": 1234567 },
        { "name": "Médico Familiar", "id": 1234567, "certificateId": 1234567 },
        { "name": "Médico Familiar", "id": 1234567, "certificateId": 1234567 }
      ],
      "experience": ["Residencia en Cardiologia", "Residencia en Cardiologia", "Residencia en Cardiologia"],
      "location": ["Hospital Los Angeles", "Hospital Sedna"],
      "languages": ["Ingles", "Frances"],
      "awards": [
        "Premio Dr. Eduardo Liceaga, 2018",
        "Premio Dr. Eduardo Liceaga, 2018",
        "Premio Dr. Eduardo Liceaga, 2018",
        "Premio Dr. Eduardo Liceaga, 2018"
      ]
    }
  }
}
```