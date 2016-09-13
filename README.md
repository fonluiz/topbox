Projeto de Sistemas de Informação I <br/>
Universidade Federal de Campina Grande <br/>
Departamento de Sistemas e Computação <br/>

<h1> TOPBOX </h1>

<h3> Desenvolvedores </h3>
<ul>
  <li>André Lopes</li>
  <li>Gabriel Araújo</li>
  <li>Ítalo Batista</li>
  <li>Jair Neto</li>
  <li>Laybson Cunha</li>
  <li>Luiz Fonseca</li>
  <li>Rafaela Lacerda</li>
</ul>

<p> A participação dos integrantes e divisão do trabalho está descrita no <a href="https://trello.com/b/mHfHdimU/sprint-2">Trello</a>. Vale ressaltar que essa divisão só se aproxima do real esforço dedicado de cada integrante.  </p>

<p> O documento de decisões para a segunda entrega está acessível por meio <a href="https://docs.google.com/document/d/1LGJvQNwoKSo03mv93JI85PBSIa4ms6oCE8iPMTtTMRU/edit?usp=sharing">deste link</a>.</p>

<p> Link para o <a href="https://topboxapp.herokuapp.com/">aplicação</a> hospedada em Heroku.</p>

<br>

<h3> Configurando o ambiente </h3>
	
	Ruby - versão 2.3
	Ruby on Rails - versão 5.0
	Psql (PostgreSQL) - versão 9.5.4

<b> Passo 1) </b> Instalar Ruby. Você pode seguir <a href="https://www.ruby-lang.org/pt/documentation/installation/">este tutorial</a>. <br/>
<b> Passo 2) </b> Instalar Ruby on Rails. Voce pode seguir <a href="http://installrails.com/">este tutorial</a>. <br/>
<b> Passo 3) </b> Configure o PSQL. No Linux, abra o terminal e digite os seguintes comandos:  <br/>
	 &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; $ sudo apt-get install postgresql
	<br>
	 &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; $ sudo apt-get install libpq-dev
	<br>	
	&emsp; &emsp; &emsp; Em /topbox:
	<br>
	&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; $ gem install pg -v ‘0.18.4’
	<br>
	<br>
	&emsp; &emsp; &emsp; Obs: caso seja apresentado o erro “FATAL: role < usuario > does not exist”, dê o seguinte comando:
	<br>
	&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; $ sudo -u postgres creatuser --superuser < usuario >
	<br>
	
<b> Passo 4) </b> Baixe o projeto pelo GitHub. <br/>
<b> Passo 5) </b> No terminal, Entre no diretório “Topbox”.  < cd topbox/Topbox > <br/>
<b> Passo 7) </b> Antes de mais nada será preciso instalar as gems usadas na aplicação. Para isso, basta executar < bundle install >. Isso instalará as gems necessárias, que estão listadas no arquivo GEMFILE. </br>
<b> Passo 8) </b> Antes de executar a aplicação é necessário criar e fazer as migrações do banco de dados. Para isso, basta executar < rake db:create > e depois executar < rake db:migrate > </br>
<b> Passo 9) </b> Digite o comando < rails server > <br/>
<b> Passo 10) </b> Entre no seu navegador e digite http://localhost:3000 <br/>




