name 'base'
description 'Base role for all servers'
run_list(
	'recipe[build-essential]',
	'recipe[cloudrift-base]'
)