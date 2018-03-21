const _ = require('lodash'),
    config = require('./config'),
    knex = require('knex')(config),
    PUBCODE_TABLE = 'pubcode_table1';

function getNew(req, res) {
    return knex.select('column_name').table('information_schema.columns').where({table_name: PUBCODE_TABLE}).then((data) => {
        let obj = {};
        _.forEach(data, (col) => {
            obj[col.column_name] = '';
        });
        res.status(200).json(obj);
    }).catch((err) => {
        res.status(500).send(err);
    });
}

function getOne(req, res) {
    let id = req.params.id;
    return knex.select().table(PUBCODE_TABLE).where({PCID: id}).then((data) => {
        res.status(200).json(data[0]);
    }).catch((err) => {
        res.status(500).send(err);
    });
}

function getAll(req, res) {
    return knex.select().table(PUBCODE_TABLE).then((data) => {
        res.status(200).json(data);
    }).catch((err) => {
        res.status(500).send(err);
    });
}

function add(req, res) {
    let item = req.body.item;
    return knex.insert(item).table(PUBCODE_TABLE).then(() => {
        res.status(200).send('success');
    }).catch((err) => {
        res.status(500).send(err);
    });
}

function update(req, res) {
    let item = req.body.item,
        id = req.params.id;
    return knex.update(item).table(PUBCODE_TABLE).where({PCID: id}).then(() => {
        res.status(200).send('success');
    }).catch((err) => {
        res.status(500).send(err);
    });
}

function find(req, res) {
    let query = req.body.query;
    return knex.select().table(PUBCODE_TABLE).where('CodeTitle', 'like', `%${query}%`).then((data) => {
        res.status(200).json(data);
    }).catch((err) => {
        res.status(500).send(err);
    });
}

let routes = {
    getNew: getNew,
    getOne: getOne,
    getAll: getAll,
    add: add,
    update: update,
    find: find
};

module.exports = routes;