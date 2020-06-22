import connection from '../database/connection';
import { Request, Response } from 'express';
import { errorEmptyValue, successDataCreated, successDataUpdated, errorIdIsMissing, successDataDeleted, errorQueryIdIsMissing } from '../utils/ResponseUtils';

class MedicamentosController {
  async index(request: Request, response: Response) {
    const { user_id } = request.query;

    if (!String(user_id).length) {
      return response.status(400).json(errorQueryIdIsMissing);
    }

    const result = await connection('medicamentos')
      .select('*')
      .where('user_id', '=', Number(user_id));

    return response.status(200).json(result);
  }

  async add(request: Request, response: Response) {
    const { name, description, value, user_id } = request.body;

    if (!name || !description || !value || !user_id ||
      !String(name).length || !String(description).length ||
      !String(value).length || !String(user_id).length
    ) {
      return response.status(400).send(errorEmptyValue);
    }

    await connection('medicamentos').insert({
      name, description, value: Number(value), user_id
    });

    return response.status(201).json(successDataCreated);
  }

  async show(request: Request, response: Response) {
    const { id } = request.params;
    const { user_id } = request.query;

    if (!String(id).length) {
      return response.status(400).json(errorIdIsMissing);
    }
    else if (!String(user_id).length) {
      return response.status(400).json(errorQueryIdIsMissing);
    }

    const result = await connection('medicamentos')
      .select('*')
      .where('id', '=', id)
      .andWhere('user_id', '=', Number(user_id));

    return response.status(200).json(!result.length ? {} : result[0]);
  }

  async update(request: Request, response: Response) {
    const { name, description, value } = request.body;
    const { id } = request.params;

    if (!id || !name || !description || !value ||
      !String(id).length || !String(name).length ||
      !String(description).length || !String(value).length
    ) {
      return response.status(400).send(errorEmptyValue);
    }

    await connection('medicamentos')
      .update({
        name, description, value: Number(value)
      }).where('id', '=', id);

    return response.status(200).json(successDataUpdated);
  }

  async delete(request: Request, response: Response) {
    const { id } = request.params;

    if (!String(id).length) {
      return response.status(400).json(errorIdIsMissing);
    }

    const result = await connection('medicamentos')
      .delete()
      .where('id', '=', id);

    return response.status(200).json(successDataDeleted);
  }
}

export default MedicamentosController;