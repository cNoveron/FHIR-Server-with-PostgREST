# Teeb FHIR Server

## Instalación

1. Inicializar submodulos

    ```bash
    git submodule init && git submodule update
    ```

2. Configurar el archivo **./src/main/resources/synthea.properties** de synthea con los siguientes datos:

    ```bash
    exporter.fhir.use_us_core_ig = true
    exporter.fhir.bulk_data = true
    ```

3. Buildear el proyecto de synthea y generar información inicial

    ```bash
    ./scripts/dev/01_generate_synthea_data.sh
    ```

4. Configura el archivo postgrest.conf

5. Crear la imagen de docker

    ```bash
    docker build -t teeb_fhir_server:1.0.0 ./
    ```

6. Ejecutar el contenedor

    ```bash
    docker run --rm --env-file .env --name teeb_fhir_server -d -p 5435:5432 -p 4000:4000 teeb_fhir_server:1.0.0
    ```

7. Verificar funcionamiento
    Después de unos segundos, se podría poder observar el servicio funcionando correctamente

    ```bash
    curl localhost:4000
    ```

## :space_invader: Dev Log

### Una Docker Image que se pueda quedar estática por meses

**Ramsés:**
El contenido de los scripts puede cambiar. Y si incluímos todos los scripts en el Dockerfile, cuando se hagan cambios importantes las imágenes de nuestro equipo quedarán obsoletas. Voy a modificar el Dockerfile de modo que no necesiten actualizar constantemente.

**Carlos:**
Nos pondremos como objetivo no sacar versiones mayores frecuentemente, de modo que el equipo dev actualice su imágen de Teeb FHIR Server más de 1 vez por trimestre.

Para evitar que futuros cambios en los scripts provoque que los devs tengan diferentes builds necesitamos realizar los siguientes cambios:

- Eliminar a línea que correo `scripts/dev/00_init.sh` en el Dockerfile.
- Volcar el contenido de ese script en el Dockerfile.

```dockerfile
RUN ...
    psql -U postgres -c 'create database fhir_db;' && \
    sh /fhirbase/scripts/dev/00_init.sh \
```

```dockerfile
RUN ...
    psql -U postgres -c 'create database fhir_db;' && \
    psql -U postgres -c 'create user teeb;' && \
    ...
```
### Usar otro schema a parte de public para evitar posibles implicaciones de seguridad


