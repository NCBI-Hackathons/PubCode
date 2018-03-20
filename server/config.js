var config = {
    client: process.env.SQL_CLIENT || 'pg',
    connection: {
        host : process.env.SQL_HOST || 'db',
        user : process.env.SQL_USER || 'postgres',
        password : process.env.SQL_PW || 'postgres',
        database : process.env.SQL_DB || 'postgres'
    }
};

module.exports = config;
