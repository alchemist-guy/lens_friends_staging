server '65.2.73.207', user: 'ubuntu', roles: %w{web app db}
set :ssh_options, {
forward_agent: true,
auth_methods: %w[publickey],
keys: %w[/home/shreya/server-keys/filterrific-key-pair.pem]
}