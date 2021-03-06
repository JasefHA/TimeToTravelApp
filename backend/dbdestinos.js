var config = require('./dbconfig') //instanciamos el archivo dbconfig
const sql = require('mssql') //traemos el paquete necesario mssql

//async que devuelve objeto
async function getDestinos(){
    try {
        let pool = await sql.connect(config);
        let destinos = await  pool.request()
            .execute("SP_GetDestinos");
        console.log('Conexion con exito');
        return destinos.recordsets;
    } catch (error) {
        console.log('Error en la conexion');
        console.log(error);
    }
}

//async que devuelve restaurantes
async function getRestaurantes(){
    try {
        let pool = await sql.connect(config);
        let restaurantes = await  pool.request()
            .execute("SP_GetRestaurantes");
        //console.log('Conexion con exito');
        return restaurantes.recordsets;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//async que devuelve alojamientos
async function getAlojamientos(){
    try {
        let pool = await sql.connect(config);
        let alojamientos = await  pool.request()
            .execute("SP_GetAlojamientos");
        //console.log('Conexion con exito');
        return alojamientos.recordsets;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//async que devuelve paquetes
async function getPaquetes(){
    try {
        let pool = await sql.connect(config);
        let paquetes = await  pool.request()
            .execute("SP_GetPaquetes");
        //console.log('Conexion con exito');
        return paquetes.recordsets;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//obtener destino por ID
async function getDestinosxID(destinoID){
    try {
        let pool = await sql.connect(config);
        let destino = await  pool.request()
            .input('id',sql.Int,destinoID)
            .execute("SP_GetDestinos_x_ID");
        //console.log('Obtener destino con ID con exito');
        return destino.recordsets;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//insertar registro
async function insertarDestino(destino){
    try {
        let pool = await sql.connect(config);
        let InsertarDestino = await  pool.request()
            .input('name', sql.NVarChar , destino.name)
            .input('description', sql.NVarChar , destino.description)
            .execute("SP_InsertDestino");
        //console.log('Insertar destino con exito');
        return InsertarDestino.recordsets;
    } catch (error) {
        //console.log('Error en la conexion');
        console.log(error);
    }
}

//actualizar registro
async function actualizarDestino(destino){
    try {
        let pool = await sql.connect(config);
        let UpdateDestino = await  pool.request()
            .input('id', sql.Int , destino.id)
            .input('name', sql.NVarChar , destino.name)
            .input('description', sql.NVarChar , destino.description)
            .execute("SP_UpdateDestino");
        //console.log('Insertar destino con exito');
        return UpdateDestino.recordsets;
    } catch (error) {
        console.log('Error en la conexion');
        console.log(error);
    }
}


module.exports = {
    getDestinos : getDestinos,
    getRestaurantes: getRestaurantes,
    getAlojamientos: getAlojamientos,
    getPaquetes:getPaquetes,
    getDestinosxID : getDestinosxID,
    insertarDestino: insertarDestino,
    actualizarDestino: actualizarDestino
}; 