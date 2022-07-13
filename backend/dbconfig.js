const config = {
    /*user: 'sa',
    password: '123456',
    server: 'localhost',
    */

    
    user : 'sqlserver',
    password : 'certus123456',
    server: '35.247.239.194',
    


    database: 'TimeToTravelApp',

    options: {
        trustedconnection: false,
        enableArithAbort: true,
        encrypt: false
        //instancename :'/'  En caso se tenga alguna instancia
    }

}
module.exports = config; 