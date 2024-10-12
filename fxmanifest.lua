fx_version 'cerulean'
game 'gta5'

author 'Peak Scripts | KostaZ'
description 'Pursuit Mode script'
version '1.1.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_scripts {
    'client.lua',
	'bridge/client/*.lua',
}

server_scripts {
	'server.lua',
	'bridge/server/*.lua',
}

files {
	'config.lua',
	'modules/**',
}