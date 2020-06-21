import connection from '../database/connection';
import { Request, Response } from 'express';
import { generateToken } from '../utils/KeyUtils';
import {
  errorEmptyValue,
  errorCreatingToken,
  errorIdIsMissing,
  successDataCreated,
  successDataUpdated,
  errorUpdatingData,
  errorDeletingData,
  successDataDeleted
} from '../utils/ResponseUtils';

class UserController {
  async add(request: Request, response: Response) {
    const { name, user, pswd } = request.body;

    if(!name || !user || !pswd || !String(name).length ||
      !String(user).length || !String(pswd).length
    ) {
      return response.status(400).json(errorEmptyValue);
    }

    const token = String(generateToken()).split('.')[2];

    if(token === 'error') {
      return response.status(500).json(errorCreatingToken);
    }

    await connection('users').insert({
      name, user, pswd, token
    });

    return response.status(200).json(successDataCreated);
  }

  async show(request: Request, response: Response) {
    const { id } = request.params;

    if(!String(id).length) {
      return response.status(400).json(errorIdIsMissing);
    }

    const result = await connection('users')
      .select('id', 'name', 'user')
      .where('id', '=', Number(id));

    if(result.length) delete result[0]['token'];

    return response.status(200).json(!result.length ? {} : result[0]);
  }

  async update(request: Request, response: Response) {
    const { name, user, pswd } = request.body;
    const { id } = request.params;

    if(!name || !user || !pswd || !String(name).length || !String(user).length || !String(pswd).length || String(id).length) {
      return response.status(400).json(errorEmptyValue)
    }
    else if(!id) {
      return response.status(400).json(errorIdIsMissing);
    }

    const result = await connection('users').update({
      name, user, pswd
    }).where('id', '=', id);

    if(result) {
      return response.status(200).json(successDataUpdated);
    }
    else {
      return response.status(500).json(errorUpdatingData);
    }
  }

  async delete(request: Request, response: Response) {
    const { id } = request.params;

    if(!String(id).length) {
      return response.status(400).json(errorIdIsMissing);
    }

    const result = await connection('users').delete().where('id', '=', id);

    if(result) {
      return response.status(200).json(successDataDeleted);
    }
    else {
      return response.status(500).json(errorDeletingData);
    }
  }
}

export default UserController;