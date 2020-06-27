# :fire: Teeb FHIR Server

## Instalación

1. Inicializar submodulos

   ```bash
   git submodule init && git submodule update
   ```

2. Configurar el archivo `./synthea/src/main/resources/synthea.properties` de synthea con los siguientes datos:

   ```bash
   exporter.fhir.use_us_core_ig = true
   exporter.fhir.bulk_data = true
   ```

3. Buildear el proyecto de synthea y generar información inicial

   ```bash
   ./scripts/dev/01_generate_synthea_data.sh
   ```

4. Configura el archivo postgrest.conf

   ```bash
   cp ./sql/postgrest.sample.config ./sql/postgrest.config
   ```

   Una vez copiados, se deben setear los datos deseados para la conexión de `postgREST`

5. Crear la imagen de docker y lanzarlas

   ```bash
   docker-compose -f docker-compose.local.yml build
   docker-compose -f docker-compose.local.yml up
   ```

6. Listar contenedores del proyecto

   ```bash
   docker-compose -f docker-compose.local.yml ps
   ```

7. Detener servicios

   ```bash
   docker-compose -f docker-compose.local.yml down
   ```

8. **Pro Tip**
   Setear una variable de entorno para evitar colocar `-f docker-compose.local.yml` en cada orden.

   ```bash
   export COMPOSE_FILE=docker-compose.local.yml
   ```

   ```bash
   docker-compose build
   docker-compose up
   docker-compose ps
   docker-compose down
   ```

9. Verificar funcionamiento
   Después de unos segundos, se podría poder observar el servicio funcionando correctamente

   ```bash
   curl localhost:4000
   ```

10. Cargar la contraseña de conexión a postgres en las variables de entorno para cargar los scripts sql

    ```bash
    export PGPASSWORD=YOUR_POSTGRES_PASSWORD
    ```

11. Cargar las funciones

    ```bash
    sh ./scripts/dev/03_load_functions.sh
    ```

12. Borrar caché de postrest dentro del contenedor para que tome los cambios
    ```bash
    docker-compose kill -s SIGUSR1 postgrest
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
