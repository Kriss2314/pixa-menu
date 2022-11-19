--resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
-- UI
ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/script.js",
	"ui/style.css",
	'ui/fonts/HarmoniaSansProCyr-Bold.ttf',
	'ui/fonts/HarmoniaSansProCyr-Light.ttf',
	'ui/fonts/HarmoniaSansProCyr-Regular.ttf'
}

-- Client Scripts
client_scripts {
	"client.lua",
	"config.lua",
	"events.lua"
}

server_scripts {
	'server.lua',
}

dependency 'es_extended'


exports {
	'OpenMenu'
}