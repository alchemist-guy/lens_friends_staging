server '13.232.41.255', user: 'ubuntu', roles: %w{web app db}
set :branch, 'main'.to_sym
set :ssh_options, {
forward_agent: true,
auth_methods: %w[publickey],
keys: %w[/home/shreya/server-keys/filterrific-key-pair.pem]
}
set :rbenv_ruby, '3.2.2'