class Usuario{
    constructor(obj){
        this.id = obj.id;
        this.nombre = obj.nombre;
        this.apellido = obj.apellido;
        this.email = obj.email;
        this.pass = obj.pass;
        this.imagen = obj.imagen;
        this.rol = obj.rol;
        this.estado = obj.estado;
        this.google = obj.google;
    }
}

module.exports = Usuario;