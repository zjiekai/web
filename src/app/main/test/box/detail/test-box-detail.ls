'use strict'

angular.module 'app.test'
		.config ($state-provider) !->
			$state-provider.state 'app.test.box-detail', {
				url: '/test/boxes/:id'
				resolve: box: (tests-service, $state-params)-> tests-service.get-box $state-params.id
				views:
					'content@app':
						template-url: 'app/main/test/box/detail/test-box-detail.html'
						controller-as: 'vm'
						controller: (box)!->
							console.log "box:"+box
							@box = box
							@dt-options = 
								paging-type: "full_numbers"
								dom: "pitrfl"
			}