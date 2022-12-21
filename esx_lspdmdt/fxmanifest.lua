fx_version 'adamant'
game 'gta5'

lua54 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/*.lua',
	'config.lua'
}

client_scripts {
	'client/*.lua'
}

files {
	'client/web/*.html',
	'client/web/css/*.css',
	'client/web/img/*.png',
	'client/web/img/*.gif',
	'client/web/js/*.js'
}

ui_page 'client/web/index.html'

--pozdro mrmisio