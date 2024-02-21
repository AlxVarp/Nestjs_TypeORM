# Nestjs_TypeORM

Proyecto creado con NestJs_TypeORM desde los pasos básicos 


## Instalación

- Node
- NestJS
- Database
- Docker
### Node

Instalamos [Node Version Manager](https://github.com/nvm-sh/nvm.git/) para la Instalación de node



### NestJS

Instalamos [Nestjs](https://docs.nestjs.com/cli/overview/)
```
npm install -g @nestjs/cli
```


### Database TypeORM Integration

Instalamos [TypeORM Integration](https://docs.nestjs.com/techniques/database/)

```
npm install --save @nestjs/typeorm typeorm mysql2
```

### Docker y Docker-compose Instalación

Instalamos [Docker](https://docs.docker.com/engine/install/) y [Docker-compose](https://docs.docker.com/compose/install/) 



## Run Project

Para correr el proyecto debemos usar docker-compose que es donde tenemos la db, el archivo esta en `compose.yaml`, para ejecutarlo debemos usar 

```
> docker-compose up -d

 ✔ Container api-biblio-adminer-1  Running     
 ✔ Container api-biblio-db-1       Started
```

Ahora debemos ingresar al contenedor para ingresar a la db, para ello debemos ubicar el contenedor donde tenemos el contenedor 

```
> docker ps

CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                               NAMES
+++++++        mysql     "docker-entrypoint.s…"   6 seconds ago   Up 2 seconds   0.0.0.0:3306->3306/tcp, 33060/tcp   api-biblio-db-1
+++++++        adminer   "entrypoint.sh php -…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->8080/tcp              api-biblio-adminer-1
```

Identificado el contenedor vamos a ingresar a el

```
docker exec -it api-biblio-db-1 bash
```

Vamos a ingresar a la Consola SQL
```
mysql -u user -ppassword
```

Crearemos una db la cual nombraremos para este proyecto `bidb`

```
mysql> CREATE DATABASE bidb;
```
Ahora solo nos queda agregar la información de la db al proyecto en el archivo `bidb`



## Module, service and Controller

Para crear el modulo usaremos el siguiente comando
```
> nest g module "name"
```
continuamos con la creación del controlador
```
> nest g controller "name" --no-spec
```

el `--no-spec` es para que no genere los archivos de testing


continuamos con la creación del servicio
```
> nest g service "name" --no-spec
```

Ahora agregamos esta información al `app.module.ts` 

```
import { UsersService } from './users.service';
import { TypeOrmModule } from '@nestjs/typeorm';

imports: [UsersModule,TypeOrmModule]
```

Tambien usaremos una función del TypeOrmModule el cual es .forRoot que sera para conectarnos a nuestra db
```
TypeOrmModule.forRoot({
      type:'mysql',
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: 'root',
      database: 'bidb',
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
      synchronize: true,
    })

```
esta es una mera para que tome cualquier archivo del directorio dentro del proyecto el cual tenga terminación .ts o .js  `entities:  [__dirname + '/**/*.entity{.ts,.js}']` 

con este comando aseguramos que siempre se sincronize las classes con la tabla `synchronize: true`


