import Knex from 'knex';

export function up(knex: Knex) {
  return knex.schema.createTable('users', table => {
    table.increments('id').primary();
    table.string('name').notNullable();
    table.string('token').notNullable();
    table.string('user').notNullable();
    table.string('pswd').notNullable();
  });
}

export function down(knex: Knex) {
  return knex.schema.dropTable('users');
}
