server '57.180.221.39', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/megumi/.ssh/id_rsa'
