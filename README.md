# Perfil Clínico

## Instalación 

1. Inicializar submodulo synthea

    ```bash
    git submodule update
    ```

2. Configurar el archivo **./src/main/resources/synthea.properties** de synthea con los siguientes datos:

    ```bash
    exporter.fhir.use_us_core_ig = true 
    exporter.fhir.bulk_data = true
    ```

3. Buildear el proyecto de synthea

    ```bash
    cd synthea && ./gradlew build -x test && cd ..
    ```
    Nota: Si deseas ejecutar los tests de synthea, ejecuta `gradlew build check test`

4. Crear la imagen de docker

    ```bash
    docker build -t teeb_fhir_server ./
    ```

5. Ejecutar el contenedor

    ```bash
    docker run -d -p 5435:5432 -p 3005:3000 --name teeb_fhir_server teeb_fhir_server
    ```

6. Verificar funcionamiento

    ```
    curl localhost:3005
    ```
