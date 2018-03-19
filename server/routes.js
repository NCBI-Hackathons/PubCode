const config = require('./config'),
    knex = require('knex')(config);

function getNew(req, res) {

}

function getOne(req, res) {

}

function getAll(req, res) {

}

function add(req, res) {

}

function update(req, res) {

}

function find(req, res) {

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