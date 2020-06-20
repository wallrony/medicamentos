import { User } from "../interfaces/User";

export const errorEmptyValue = {
  result: 'fail',
  message: 'Nenhum valor pode ser vazio!',
};

export const errorIdIsMissing = {
  result: 'fail',
  message: 'É necessário um id!',
};

export const errorQueryIdIsMissing = {
  result: 'fail',
  message: 'É necessário um query id!',
}

export const errorUpdatingData = {
  result: 'fail',
  message: 'Ocorreu algum erro interno ao atualizar as informações. Por favor, tente novamente mais tarde.',
}

export const errorCreatingToken = {
  result: 'fail',
  message: 'Ocorreu algum erro gerando o token do usuário!',
};

export const errorDeletingData = {
  result: 'fail',
  message: 'Ocorreu algum erro interno ao excluir a informação. Por favor, tente novamente mais tarde.',
};

export const errorAuth = {
  result: 'fail',
  message: 'As credenciais fornecidas são inválidas!',
};

export const errorInvalidToken = {
  result: 'fail',
  message: 'O token fornecido é inválido!',
}

export const errorTokenDoesntProvided = {
  result: 'fail',
  message: 'O token não foi fornecido no cabeçalho!',
};

export const errorTokenRequired = {
  result: 'fail',
  message: 'O cabeçalho de autenticação é necessário!',
};

export const successDataUpdated = {
  result: 'success',
  message: 'Informação atualizada com sucesso!',
};

export const successDataCreated = {
  result: 'success',
  message: 'Informação criada com sucesso!',
};

export const successDataDeleted = {
  result: 'success',
  message: 'Informação deletada com sucesso!',
}

export const successAuthenticated = (userData: User) => {
  const auth = {
    result: 'success',
    user: {
      authToken: userData['token'],
      name: userData['name'],
      id: userData['id']
    }
  };

  return auth;
}