# Medicamentos

<p>Este é um projeto bem simples que tem como intuito gerenciar medicamentos dos usuários, cadastrando medicamentos que estão vinculados a algum usuário específico cadastrado.</p>

<span style="font-size: 10px">Este é um projeto bem simples para portfolio.</span>

<p>Aplicações desenvolvidas: backend (nodeJS), frontend web (ReactJS - a ser desenvolvida) e mobile (Flutter - a ser desenvolvida).</p>

</hr>

# Backend

<p>A aplicação backend foi desenvolvida com nodeJS fazendo conexão com banco de dados postgresql. Também foi utilizado o Knex como QueryBuilder para gerenciamento do banco de dados, então a manutenção e/ou troca de tipo de banco de dados a ser utilizado se faz extremamente rápida e simples.</p>

<h3>Como executar?</h3>

<p>Essa aplicação foi desenvolvida utilizando a versão LTS 12.18.0 do nodeJS, então essa será a versão mais confortável e é a que recomendo a ser utilizada para execução dessa aplicação.</p>

<p>Para executá-la de forma local, siga os passos abaixo:</p>

<p>Obs.: O passo a passo a seguir considera a exata configuração abordada nos arquivos já existentes. Em caso de alteração, essa lista pode não ser exatamente da mesma maneira a ser seguida.</p>

<ol>
  <li>Crie o banco de dados "my_db_enf_med" com o postgresql (se não o tiver instalado, irá precisa ao menos para a criação do database, assim, recomendo seguir o tutorial de instalação oficial do postgresql na sua máquina);</li>
  <li>Entre na pasta "backend" com o seu terminal;</li>
  <li>Execute "yarn knex:migrate" ou "npm knex:migrate" para executar as migrations do banco de dados (a criação das tabelas);</li>
  <li>Execute "yarn knex:seed" ou "npm knex:seed" para adicionar itens padrão ao banco de dados, como o usuário default (admin, que é necessário para realizar qualquer outra operação por causa da necessidade do token, inclusive, adicionar um outro usuário) e dois medicamentos;</li>
  <li>Execute "yarn dev" ou "npm dev" para executar o servidor.</li>
</ol>

<p>E pronto, o servidor backend já está executando de forma local na sua máquina, na porta 3333.</p>

# Frontend Web

<p>A aplicação frontend web deste projeto ainda está em desenvolvimento.</p>

# Mobile

<p>A aplicação mobile deste projeto ainda está em desenvolvimento.</p>