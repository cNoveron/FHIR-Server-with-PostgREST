# Perfil Clínico

## Instalación

1. Corre el siguiente script para ejecutar PostgreSQL en un contenedor de Docker.

```bash
bash scripts/01_run_docker_PostgreSQL.sh
```

2. Corre el siguiente script para ejecutar los scripts SQL que poblarán la base de datos.

```
bash scripts/02_exec_docker_sql.sh
```

3. Corre el siguiente script para descargar y extraer PostgREST:
 
```bash
bash scripts/03_download_PostgREST.sh
```

Verás el archivo binario `postgrest` en el directorio activo.
