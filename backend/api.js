
var Destino = require('./destino');
const dbdestinos = require('./dbdestinos');


var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');
const { request } = require('express');
const { response } = require('express');
//probando comentario
var app = express();
var router = express.Router();




/* TODO: DOCUMENTACION CON SWAGGER */
//https://www.npmjs.com/package/swagger-ui-express
const swaggerJsdoc = require('swagger-jsdoc');
//https://www.npmjs.com/package/swagger-jsdoc
const swaggerUI = require('swagger-ui-express');

const swaggerOptions = {
    swaggerDefinition:{
        info:{
            version: "1.0.1",
            title:'API REST Time To Travel',
            description:'API REST Hecha para el desarrollo y consumo de Time To Travel APP para el curso de desarrollo movil.',
            contact :{
                name: 'Jasef Developer'
            },
            sever:["http://localhost:8090"]
        }
    },
    apis:['api.js']
};

/* DOCUMENTACION CON SWAGGER */
const swaggerDocs = swaggerJsdoc(swaggerOptions);
app.use("/api-docs", swaggerUI.serve, swaggerUI.setup(swaggerDocs));

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());
app.use(cors());
app.use('/api', router);//ruta principal


/** 
 * @swagger
 * /api/destinos:
 *  get:
 *      description: Use para obtener todos los destinos
 *      responses:
 *          '200':
 *              description: Listados correctamente
*/
//traer todos los destinos
router.route('/destinos').get((request,response)=>{
    dbdestinos.getDestinos().then(result => {
        response.json(result[0]);
    })
})

/**
 * @swagger
 * /api/destinos/{id}:
 *  get:
 *    description: Use para obtener un destino x ID
 *    parameters:
 *      - in: path
 *        name: id
 *    responses:
 *          '200':
 *              description: Destino obtenida correctamente
 */

//traer los destinos por id
router.route('/destinos/:id').get((request,response)=>{
    dbdestinos.getDestinosxID(request.params.id).then(result => {
        response.json(result[0]);
    })
})


/**
 * @swagger
 * /api/destinos/guardar:
 *  post:
 *      description: Use para guardar/insertar un destino
 *      produces:
 *          - application/json
 *      parameters:
 *          - name: "body"
 *            in: body
 *            required: true
 *            schema:
 *              type: object
 *              example:
 *                  name: "TestNameApi"
 *                  description: "Description Test API"
 *      responses:
 *        '200':
 *          description: Destino insertado correctamente
 *          content: 
 *              application/json:
 *               type: object
 * 
 */

//insertar destino
router.route('/destinos/guardar').post((request,response)=>{
    let destino = {...request.body}
    dbdestinos.insertarDestino(destino).then(result => {
        response.json(result[0]);
    })
})


/**
 * @swagger
 * /api/destinos/actualizar:
 *  post:
 *      description: Use para actualizar un destino
 *      produces:
 *          - application/json
 *      parameters:
 *          - name: "body"
 *            in: body
 *            required: true
 *            schema:
 *              type: object
 *              example:
 *                  id: ""
 *                  name: "TestNameApi"
 *                  description: "Description Test API"
 *      responses:
 *        '200':
 *          description: Destino actualizado correctamente
 *          content: 
 *              application/json:
 *               type: object
 * 
 */
//actualizar destino
router.route('/destinos/actualizar').post((request,response)=>{
    let destino = {...request.body}
    dbdestinos.actualizarDestino(destino).then(result => {
        response.json(result[0]);
    })
})

var port = process.env.PORT || 8090;
app.listen(port);
console.log('TimeToTravelAPP Api iniciando en el puerto: '+port);//mensaje inicio de servicio