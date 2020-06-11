import Knex from 'knex';

export function up(knex: Knex) {
  return knex.schema.createTable('medicamentos', table => {
    table.increments('id').primary();
    table.string('name').notNullable();
    table.string('description').notNullable();
    table.decimal('value').notNullable();
    table.integer('user_id').references('id').inTable('users').notNullable();
  });
}

export function down(knex: Knex) {
  return knex.schema.dropTable('medicamentos');
}
