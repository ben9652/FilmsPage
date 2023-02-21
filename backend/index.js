const mysql = require('mysql2')
const express = require('express')
const cors = require('cors')
const {Blob} = require('buffer')
const app = express()
const port = 5000

async function listarPeliculas() {
    let resultados_consulta = null;
    try {
      const [rows, fields] = await conn.promise().query('CALL ListarPeliculas()');
      resultados_consulta = rows;
    } catch (err) {
      console.log('Hubo un error en la consulta: ', err);
    }
    
    return resultados_consulta;
}

async function obtenerPelicula(id) {
    const sql = 'CALL ObtenerPelicula(?)';
    try {
        const [rows, fields] = await conn.promise().query(sql, id);
        return rows
    }
    catch(error) {
        console.log('Hubo un error en la consulta: ', error);
    }
    return null
}

async function obtenerActor(id) {
    const sql = 'SELECT * FROM Actores WHERE id = ?';
    try {
        const [rows, fields] = await conn.promise().query(sql, id);
        return rows;
    }
    catch(error) {
        console.log('Hubo un error en la consulta: ', error);
    }
    return null;
}

app.use(cors({
    origin: ['http://localhost', 'http://192.168.1.3']
}))

const conn = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'benjab',
    password: 'facet',
    database: 'Films'
})

conn.connect((err) => {
    if(err)
        console.log(`No se pudo conectar al servidor ${conn.host}`)
    else
        console.log('Conectado a la base de datos')
})

app.get('/peliculas', async (req, res) => {
    let results = await listarPeliculas()
    res.send(results)
})

app.get('/peliculas/:id', async (req, res) => {
    const numeroID = parseInt(req.params.id)
    let results = await obtenerPelicula(numeroID);
    res.send(results);
})

app.get('/peliculas/:id/actores/:idActor', async (req, res) => {
    const idActor = parseInt(req.params.idActor);
    let results = await obtenerActor(idActor);
    res.send(results);
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})
