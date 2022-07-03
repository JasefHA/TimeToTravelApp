
var Destino = require('./destino');
const dbdestinos = require('./dbdestinos');
const dbUsuarios = require('./dbUsuarios');

const { request, response } = require('express');
const { check } = require('express-validator');
const { validarCampos } = require('./middlewares/validarCampos');
const { generateJWT } = require('./helpers/generate-jwt');

var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');
//probando comentario
var app = express();
var router = express.Router();




/* TODO: DOCUMENTACION CON SWAGGER */
//https://www.npmjs.com/package/swagger-ui-express
const swaggerJsdoc = require('swagger-jsdoc');
//https://www.npmjs.com/package/swagger-jsdoc
const swaggerUI = require('swagger-ui-express');

const swaggerOptions = {
    swaggerDefinition: {
        info: {
            version: "1.0.1",
            title: 'API REST Time To Travel',
            description: 'API REST Hecha para el desarrollo y consumo de Time To Travel APP para el curso de desarrollo movil.',
            contact: {
                name: 'Jasef Developer'
            },
            sever: ["http://localhost:8090"]
        }
    },
    apis: ['api.js']
};

/* DOCUMENTACION CON SWAGGER */
const swaggerDocs = swaggerJsdoc(swaggerOptions);
app.use("/api-docs", swaggerUI.serve, swaggerUI.setup(swaggerDocs));

app.use(bodyParser.urlencoded({ extended: true }));
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
router.route('/destinos').get((request, response) => {
    dbdestinos.getDestinos().then(result => {
        response.json(result[0]);
    })
})


/** 
 * @swagger
 * /api/restaurantes:
 *  get:
 *      description: Use para obtener todos los restaurantes
 *      responses:
 *          '200':
 *              description: Listados correctamente
*/
//traer todos los restaurantes
router.route('/restaurantes').get((request, response) => {
    dbdestinos.getRestaurantes().then(result => {
        response.json(result[0]);
    })
})

/** 
 * @swagger
 * /api/alojamientos:
 *  get:
 *      description: Use para obtener todos los alojamientos
 *      responses:
 *          '200':
 *              description: Listados correctamente
*/
//traer todos los alojamientos
router.route('/alojamientos').get((request, response) => {
    dbdestinos.getAlojamientos().then(result => {
        response.json(result[0]);
    })
})


/** 
 * @swagger
 * /api/paquetes:
 *  get:
 *      description: Use para obtener todos los paquetes
 *      responses:
 *          '200':
 *              description: Listados correctamente
*/
//traer todos los destinos
router.route('/paquetes').get((request, response) => {
    dbdestinos.getPaquetes().then(result => {
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
router.route('/destinos/:id').get((request, response) => {
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
router.route('/destinos/guardar').post((request, response) => {
    let destino = { ...request.body }
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
router.route('/destinos/actualizar').post((request, response) => {
    let destino = { ...request.body }
    dbdestinos.actualizarDestino(destino).then(result => {
        response.json(result[0]);
    })
})



//    rutas usuario ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

router.route('/usuarios').get(async (req = request, res = response) => {

    let { limite = 5, desde = 0 } = req.query;
    if (!Number(desde)) {
        desde = 0;
    }
    if (!Number(limite)) {
        limite = 5;
    }

    const [{ total }, result] = await Promise.all([
        dbUsuarios.getTotalUsuarios(),
        dbUsuarios.getUsuarios(limite, desde)
    ]);

    res.json({
        total,
        result
    });
})

router.route('/usuarios/:id').get([validarCampos], async (req = request, res = response) => {

    const { id } = req.params;

    const result = await dbUsuarios.getUsuario_x_idEmail(id);

    res.json({
        result
    });
})

router.route('/usuarios').post([
    check('nombre', 'Todos los campos son obligatorios').not().isEmpty(),
    check('apellido', 'Todos los campos son obligatorios').not().isEmpty(),
    check('password', 'La contraseña no debe ser menor a 6 caracteres').isLength({ min: 6 }),
    check('email', 'Correo ingresado no valido').isEmail(),
    validarCampos
], async (req = request, res = response) => {
    const { google, rol, password, imagen, ...rest } = req.body;
    rest.rol = 'ROL_USUARIO';
    rest.google = 'NO ACTIVO';
    rest.pass = password;

    if (!imagen) {
        rest.imagen = 'default';
    } else {
        rest.imagen = imagen == '' ? 'default' : imagen;
    }
    const result = await dbUsuarios.postUsuario(rest);
    if (result != null) {
        res.status(200).json({
            result
        });
    } else {
        res.status(400).json({
            result
        });
    }

})

router.route('/usuarios/:id').put([
    check('nombre', 'Todos los campos son obligatorios').not().isEmpty(),
    check('apellido', 'Todos los campos son obligatorios').not().isEmpty(),
    check('password', 'La contraseña no debe ser menor a 6 caracteres').isLength({ min: 6 }),
    check('email', 'Correo ingresado no valido').isEmail(),
    validarCampos
], async (req = request, res = response) => {
    const { id, google, password, ...rest } = req.body;
    rest.idEmail = req.params.id;
    rest.google = 'NO ACTIVO';
    rest.pass = password;
    const result = await dbUsuarios.putUsuario_x_idEmail(rest);
    res.json({
        result
    });
})

router.route('/usuarios/password/:id').patch([
    check('password', 'La contraseña no debe ser menor a 6 caracteres').isLength({ min: 6 }),
    validarCampos
], async (req = request, res = response) => {
    const { password } = req.body;
    const { id } = req.params;
    const result = await dbUsuarios.patchUsuario_x_idEmail(id, password);
    res.json({
        result
    });
})

router.route('/usuarios/:id').delete([validarCampos], async (req = request, res = response) => {
    const { id } = req.params;
    const result = await dbUsuarios.deleteUsuario_x_idEmail(id);
    res.json({
        result
    });
})


//    rutas autenticacion +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

router.route('/login').post([
    check('email', 'Correo ingresado no valido').isEmail(),
    check('password', 'La contraseña no debe ser menor a 6 caracteres').isLength({ min: 6 }),
    validarCampos
], async (req = request, res = response) => {

    const { email, password } = req.body;

    try {
        const user = await dbUsuarios.getUsuarioPass_x_idEmail(email);
        const result = null;
        if (!user) {
            return res.status(400).json({
                result
                //msg: ' Email / password no valido'
            });
        }
        //const validatePassword = bcryptjs.compareSync(password, user.password);
        if (password != user.pass) {
            return res.status(400).json({
                result
                //msg: ' Email / password no valido'
            });
        }

        const token = await generateJWT(user.id);
        res.status(200).json({
            user,
            token
        });
    } catch (err) {
        console.log(err);
        return res.status(500).json({
            msg: 'Hable con el administrador'
        });
    }
})



var port = process.env.PORT || 3000;
app.listen(port);
console.log('TimeToTravelAPP Api iniciando en el puerto: ' + port);//mensaje inicio de servicio