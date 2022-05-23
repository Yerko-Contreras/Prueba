# Proyecto semestral Grupo 42

Links para revisión:
* [Aplicación en Heroku](https://proyecto-grupo-42.herokuapp.com)
* [Trello](https://trello.com/invite/b/WElGSeos/5ecffc70ec355bcf7dce27bb0d811e51/proyecto)

NOTAS ENTREGA N°1 (04-05-2022)

Supuestos e información útil:

- Se definió un límite de 10 personas como capacidad máxima para un turno, considerando las dimensiones de un vehículo particular común.
- Durante la creación de cuenta se asigna una imagen por defecto a todos los usuarios. Esta puede ser cambiada en la página de edición de perfil.
- Se implementaron los 5 CRUDs solicitados: Usuarios, turnos, solicitudes, reseñas y chats, aunque no se enunciaron en los modelos (y en las bases de datos) las asociaciones entre las entidades para esta entrega.
- Los documentos en formato .pdf (diagrama ER para esta entrega) se encuentran en la carpeta /docs.

NOTAS ENTREGA N°2 (04-05-2022)

- Se implementó todo lo solicitado, menos el diseño de las vistas
- Para ingresar como admin, email: 'admin_nicole@admin.iic', password: 'admin1234'. Para validar la cuenta de administrador se agrego una columna bool a la tabla users que no puede ser modificada en ningún momento mediante la app. El administrador es creado al correr rails db:seed.
- Se mantiene el funcionamiento en los puntos 1 y 2 de la entrega N°1