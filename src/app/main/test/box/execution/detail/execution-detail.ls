'use strict'

angular.module 'app.test'
		.config ($state-provider) !->
			$state-provider.state 'app.test.execution', {
				url: '/test/execution/detail/:id',
				views:
					'content@app':
						template-url: 'app/main/test/box/execution/detail/execution-detail.html'
						controller-as: 'vm'
						controller: !->
			}