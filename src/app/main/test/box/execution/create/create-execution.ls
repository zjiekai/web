'use strict'
	
angular.module 'app.test'
		.config ($state-provider) !->
			$state-provider.state 'app.test.create', {
				url: '/test/executions/create?box'
				views:
					'content@app':
						template-url:'app/main/test/box/execution/create/create-execution.html'
						resolve: execution: (tests-service, $state-params) -> tests-service.create-execution $state-params.box
						controller-as: 'vm'
						controller: (execution, $state, $state-params)!->
							console.log "execution.id:"+execution._id
							@excution = execution
							@button-content = "执行新测试"
							@create-new-execution = do ~>
								count = 1
								~>
									console.log '111'
									@button-content = "等待测试盒执行..." if count == 1 
									if (count == 2)
										@button-content = "执行开始" 
										$state.go 'app.test.execution', id: execution._id
									count++
			}