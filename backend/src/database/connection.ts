import knex from 'knex';
import path from 'path';

const connection = knex({
  client: 'pg',
  connection: {
    database: 'my_db_enf_med',
    user: 'postgres',
    password: '123456'
  },
  useNullAsDefault: true
});

export default connection;
