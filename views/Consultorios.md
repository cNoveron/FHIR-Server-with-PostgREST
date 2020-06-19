#### 1. App: Mis Médicos: Desplegar médicos
El primer paso es presentarle al usuario los **Practicantes** disponibles usando cualquiera de las 2 siguientes *requests* disponibles en nuestra coleccióń:
- **R Médicos**: Para obtener **todos** los médicos actualmente registrados en Teeb.
- **R Médicos | paciente**: Para obtener **sólo** los médicos de confianza del paciente a través del `patient_id` del usuario actual.

Hecho esto nos responderá una lista de datos de **Practicantes** que se verá de esta manera:

```json
[
  {
    "practitioner_id": "f47ddd8a-ebc1-3c69-b04e-2ef959816403",
    "practitioner_name": {
      "given": ["Jung484"],
      "family": "Fadel536",
      "prefix": ["Dr."]
    },
    "practitioner_specialty": null,
    "practitioner_telecom": [
      {
        "use": "work",
        "value": "Jung484.Fadel536@example.com",
        "system": "email",
        "extension": []
      }
    ]
  },
  ...
]

```

#### 2. Paciente: Elegió médico -> App: Consultorios: Desplegar Ubicaciones
Cuando el paciente selecciona un médico, la app deberá de seleccionar el `practitioner_id` del médico en cuestión para incluirlo en el `payload` de nuestra segunda request, misma que se enviará a través de **R Consultorios | médico** para obtener todas las **Ubicaciones** (i.e. consultorios, clínicas u hospitales) donde el **Practicante** desea recibir consultas.

El payload para encontrar todas las **Ubicaciones** incluye el `practitioner_id` del **Practicante** elegido

```json
{
  "practitioner_id": "fc535af9-9a79-31c8-8698-1aa7f0f52529"
}

A lo cual Teeb FHIR Server responderá con un arreglo con elementos de esta manera:

```json
[
  {
    "location_id": "0bb542b6-9faa-48f2-82b2-68e27c775b9b",
    "location_name": "GOOD SAMARITAN MEDICAL CENTER",
    "location_address": "235 NORTH PEARL STREET",
    "location_city": "BROCKTON",
    "location_state": "MA",
    "location_country": "US"
  }
]
```

Por ahora tenemos sólo un consultorio por **Practicante**. Se irán mejorando los datos de prueba en las iteraciones.

```json
{
  "resource": {
    "name": "Clínica Gran Sur",           // <-- location_name
    "address": {
      "street": "235 NORTH PEARL STREET", // <-- location_address
      // "suburb": "Olímpica",            // omitir
      "area": "BROCKTON",                 // <-- location_city
      "state": "MA",                      // <-- location_state
      // "cp": "04710"                    // omitir
    },
    "phoneNumber": [
      213123123,  // <-- appointmentType
      328923829   // no deberían ser números enteros, deberían ser strings
    ],
```

#### 3. Paciente: Agendar consulta -> App: Agendar: Razón de la consulta

#### 4. Paciente: Agendar consulta -> App: Agendar: Modalidad de la consulta

#### 5. Paciente: Agendar consulta -> App: Agendar: Elige el consultorio

#### 6. Paciente: Agendar consulta -> App: Agendar: Selecciona el día

En FHIR los recursos no están diseñados para especificar días de la semana, sino que más bien hacen referencia a un bloque de tiempo contínuo definido en el recurso **Horario**, éste a su vez está referenciado por los **Espacios**, y éstos a su vez por **Consultas**.

En Teeb FHIR Server se designó que haya un **Horario** por día, por lo tanto:

1.  Consultar el endpoint `/rpc/r_locations` para obtener todos los horarios que estén disponibles.

```json
    "insurance": ["AXA", "GNP", "Santander"], // teeb.practitioner.insurance PENDIENTE
    "schedule": {
      "days": ["Lun", "Mie", "Vie"],
      "time": [
        { "from": "10:00am", "to": "4:00pm" }, // slots
        { "from": "07:00pm", "to": "09:00pm" } //
      ]
    },
    "appTypes": [
      {
        "type": "Online", // <Teeb_FHIR_Server_URLl>.appointment.appointmentType
        "price": 1000,    // teeb.prices.Online.total
        "prepayment": 500 // teeb.prices.Online.prepay
      },
      { "type": "Live", "price": 2000, "prepayment": 600 },
      { "type": "Home", "price": 5000, "prepayment": 800 }
    ],
    "services": [
      "Consulta general", // <Teeb_FHIR_Server_URLl>.appointment.serviceType
      "Valoración preoperatoria"
    ],
    "colleagues": [
      {
        "mail": "marco.solis@medical.com",
        "name": "Marco Solis",
        "role": "Enfermera",
        "rights": [
          { "name": "agenda", "can": "edit" },
          { "name": "personal data", "can": "view and edit" },
          { "name": "medical profile", "can": "edit" }
        ]
      }
    ]
  }
}
```