name 'db'
description 'MongoDB role'
run_list(
	'recipe[mongodb::10gen_repo]',
	'recipe[cloudrift-db]'
)