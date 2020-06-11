import Knex from 'knex';

export function up(knex: Knex) {
  return knex.schema.createTable('medicamentos', table => {
    table.increments('ID').primary();
    table.string('name').notNullable();
    table.string('description').notNullable();
    table.decimal('value').notNullable();
  });
}

export function down(knex: Knex) {
  return knex.schema.dropTable('medicamentos');
}
