const config = {
    user : 'sqlserver',
    password : 'certus123456',
    server: '35.224.234.43',
    database: 'TimeToTravelApp',
    options:{
        trustedconnection: false,
        enableArithAbort : true, 
        encrypt:false
        //instancename :'/'  En caso se tenga alguna instancia
    }

}
module.exports = config; 