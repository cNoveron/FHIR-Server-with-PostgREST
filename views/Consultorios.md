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

#### 2. Paciente: Elegió médico -> App/Consultorios: Desplegar Ubicaciones
Cuando el paciente selecciona un médico, la app deberá de seleccionar el `practitioner_id` del médico en cuestión para incluirlo en el `body` de nuestra segunda request: **R Consultorios | médico**, que se usará para obtener todas las **Ubicaciones** (i.e. consultorios, clínicas u hospitales) donde el **Practicante** desea recibir consultas.

El body para encontrar todas las **Ubicaciones** incluye el `practitioner_id` del **Practicante** elegido:
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
En el front end se le conoce a estos datos por los siguientes nombres:
```json
{
  "resource": {
    "name": "GOOD SAMARITAN MEDICAL CENTER",// <-- location_name
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
Por ahora tenemos sólo una **Ubicación** por **Practicante**. Se irán mejorando los datos de prueba en las iteraciones.

#### 3. Paciente: Introdujo razón de la consulta -> App/Agendar: La incluye el body de C Consulta
En cuanto el paciente llena el campo se entiende que en la app los datos se visualizan de esta manera:
```json
{
  ....
  "services": [
    "Consulta general",
    "Valoración preoperatoria"
  ],
  ...
}
```
Una vez introducidos la app los incluirá en el body de la request **C Consulta**
```json
{
  "resource": {
    "reasonCode": [
      {
        "text": "Consulta general"
      },
      {
        "text": "Valoración preoperatoria"
      }
    ],
  }
}
```

#### 4. Paciente: Introdujo la modalidad de la consulta -> App/Agendar: La incluye el body de C Consulta
En cuanto el paciente llena el campo se entiende que en la app los datos se visualizan de esta manera:
```json
{
  "appTypes": [
    {
      "type": "Online", // fhir_db.appointment.appointmentType
      "price": 1000,    // teeb.prices.Online.total
      "prepayment": 500 // teeb.prices.Online.prepay
    },
    { "type": "Live", "price": 2000, "prepayment": 600 },
    { "type": "Home", "price": 5000, "prepayment": 800 }
  ],
}
```
Una vez introducidos la app los incluirá en el body de la request **C Consulta**
```json
{
  "resource": {
    "appointmentType": [
      {
        "text": "Live"
      }
    ],
  }
}
```
#### 5. Paciente: Introdujo el consultorio -> App/Agendar: La incluye el body de C Consulta

#### 6. Paciente: Agendar consulta -> App: Agendar: Selecciona el día

En FHIR los recursos no están diseñados para especificar días de la semana, sino que más bien hacen referencia a un bloque de tiempo contínuo definido en el recurso **Horario**, éste a su vez está referenciado por los **Espacios**, y éstos a su vez por **Consultas**.

En Teeb FHIR Server se designó que haya un **Horario** por día, por lo tanto:

1.  Consultar el endpoint `/rpc/r_locations` para obtener todos los horarios que estén disponibles.

```json
    "insurance": ["AXA", "GNP", "Santander"], // teeb.practitioner. PENDIENTE
```

```json
    "schedule": {
      "days": ["Lun", "Mie", "Vie"],
      "time": [
        { "from": "10:00am", "to": "4:00pm" }, // slots
        { "from": "07:00pm", "to": "09:00pm" } //
      ]
    },
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