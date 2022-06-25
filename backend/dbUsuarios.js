var config = require('./dbconfig') //instanciamos el archivo dbconfig
const sql = require('mssql') //traemos el paquete necesario mssql



async function getTotalUsuarios() {

    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .query('SP_GET_TOTAL_USUARIOS');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        console.log(error);
    }
}

//async que devuelve todos los usuarios
async function getUsuarios(limite = 5, desde = 0) {

    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('limite', sql.Int, limite)
            .input('desde', sql.Int, desde)
            .query('SP_GET_USUARIOS @limite, @desde');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset : null;
    } catch (error) {
        console.log(error);
    }
}

//async que devuelve usuarios por id/email
async function getUsuario_x_idEmail(idEmail = '') {
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('idEmail', sql.VarChar(100), idEmail)
            .query('SP_GET_USUARIO_x_ID_EMAIL @idEmail');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        console.log(error);
    }
}

//async que devuelve alojamientos
async function getRol(rol = '') {
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('rol', sql.VarChar(100), rol)
            .query('SP_GET_ROL @rol');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//async que devuelve paquetes
async function postUsuario(obj) {
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('nombre', sql.VarChar(50), obj.nombre)
            .input('apellido', sql.VarChar(50), obj.apellido)
            .input('email', sql.VarChar(50), obj.email)
            .input('pass', sql.VarChar(50), obj.pass)
            .input('imagen', sql.VarChar(100), obj.imagen)
            .input('rol', sql.VarChar(100), obj.rol)
            .input('google', sql.VarChar(100), obj.google)
            .query('SP_POST_USUARIO @nombre,@apellido,@email,@pass,@imagen,@rol,@google')
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;

    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//obtener destino por ID
async function putUsuario_x_idEmail(obj) {
    console.log(obj);
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('idEmail', sql.VarChar(50), obj.idEmail)
            .input('nombre', sql.VarChar(50), obj.nombre)
            .input('apellido', sql.VarChar(50), obj.apellido)
          //  .input('email', sql.VarChar(50), obj.email)
            .input('pass', sql.VarChar(200), obj.pass)
            .input('imagen', sql.VarChar(100), obj.imagen)
            .input('rol', sql.VarChar(100), obj.rol)
            .input('estado', sql.VarChar(100), obj.estado)
            .input('google', sql.VarChar(100), obj.google)
            .query('SP_PUT_USUARIO_x_ID_EMAIL @idEmail, @nombre,@apellido,@pass,@imagen,@rol,@estado,@google')
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//insertar registro
async function deleteUsuario_x_idEmail(idEmail = '') {
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('idEmail', sql.VarChar(100), idEmail)
            .query('SP_DELETE_USUARIO_x_ID_EMAIL @idEmail');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//actualizar registro
async function patchUsuario_x_idEmail(idEmail = '', pass = '123456') {
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('idEmail', sql.VarChar(100), idEmail)
            .input('pass', sql.VarChar(100), pass)
            .query('PATCH_SP_PASS_x_ID_EMAIL @idEmail, @pass');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        console.log('Error en la conexion');
        console.log(error);
    }
}

//async que devuelve usuarios por id/email
async function getUsuarioPass_x_idEmail(idEmail = '') {
    try {
        let pool = await sql.connect(config);
        let resultado = await pool
            .request()
            .input('idEmail', sql.VarChar(100), idEmail)
            .query('SP_GET_PASS_x_ID_EMAIL @idEmail');
        pool.close.bind(pool);
        return resultado.recordset ? resultado.recordset[0] : null;
    } catch (error) {
        console.log(error);
    }
}

module.exports = {
    getTotalUsuarios: getTotalUsuarios,
    getUsuarios: getUsuarios,
    getUsuario_x_idEmail: getUsuario_x_idEmail,
    getRol: getRol,
    postUsuario: postUsuario,
    putUsuario_x_idEmail: putUsuario_x_idEmail,
    deleteUsuario_x_idEmail: deleteUsuario_x_idEmail,
    patchUsuario_x_idEmail: patchUsuario_x_idEmail,
    getUsuarioPass_x_idEmail:getUsuarioPass_x_idEmail
};




/*
SQL
SP_GET_USUARIOS
SP_GET_USUARIO_x_ID_EMAIL
SP_GET_ROL
SP_POST_USUARIO
SP_PUT_USUARIO_x_ID_EMAIL
SP_DELETE_USUARIO_x_ID_EMAIL

*/

