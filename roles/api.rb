name 'api'
description 'Role for API servers'
run_list(
	'recipe[cloudrift-api]'
)