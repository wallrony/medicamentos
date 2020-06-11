import connection from '../database/connection';
import { Request, Response } from 'express';
import { errorEmptyValue, successDataCreated, successDataUpdated, errorIdIsMissing, successDataDeleted } from '../utils/ResponseUtils';

class MedicamentosController {
  async index(request: Request, response: Response) {
    const result = await connection('medicamentos').select('*');

    return response.status(200).json(result);
  }

  async add(request: Request, response: Response) {
    const { name, description, value } = request.body;

    if(!String(name).length || !String(description).length ||
      !String(value).length
    ) {
      return response.status(400).send(errorEmptyValue);
    }
    
    await connection('medicamentos').insert({
      name, description, value: Number(value)
    });

    return response.status(201).json(successDataCreated);
  }

  async show(request: Request, response: Response) {
    const { id } = request.params;
    
    const result = await connection('medicamentos').select('*').where('id', '=', id);

    return response.status(200).json(result);
  }

  async update(request: Request, response: Response) {
    const { id, name, description, value } = request.body;

    if(!id || !name || !description || !value ||
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

    if(!String(id).length) {
      return response.status(400).json(errorIdIsMissing);
    }

    const result = await connection('medicamentos')
      .delete()
      .where('id', '=', id);
    
    return response.status(200).json(successDataDeleted);
  }
}

export default MedicamentosController;