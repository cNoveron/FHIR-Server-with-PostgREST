# Perfil Clínico

## Instalación 

1. Inicializar submodulos


    ```bash
    git submodule update
    ```

2. Configurar el archivo **./src/main/resources/synthea.properties** de synthea con los siguientes datos:

    ```bash
    exporter.fhir.use_us_core_ig = true 
    exporter.fhir.bulk_data = true
    ```

3. Buildear el proyecto de synthea y generar información inicial

    ```bash
    ./scripts/dev/00_generate_synthea_data.sh
    ```
    Nota: Si deseas ejecutar los tests de synthea, ejecuta `gradlew build check test`

4. Crear la imagen de docker

    ```bash
    docker build -t teeb_fhir_server:1.0.0 ./
    ```

5. Ejecutar el contenedor

    ```bash

    docker run --rm --env-file .env --name teeb_fhir_server -d -p 5435:5432 -p 3005:3000 teeb_fhir_server:1.0.0
    ```

6. Verificar funcionamiento

    ```
    curl localhost:3005
    ```
