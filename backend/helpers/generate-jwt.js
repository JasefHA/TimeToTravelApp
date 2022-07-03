const jwt = require('jsonwebtoken');

const generateJWT = (uid = '') => {
    return new Promise((resolve, reject) => {
        const payload = { uid };

        jwt.sign(payload, 'M1G4t4M4luYSusG4t1tos', {
            expiresIn: '6h'
        }, (err, token) => {
            if (err) {
                console.log(err);
                reject('No se pudo generar token')
            } else {
                resolve(token);
            }
        })

    })
}

module.exports = {
    generateJWT
}