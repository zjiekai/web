create-boxes = (boxes)-> [create-box box for box in boxes]

create-box = (box)->
  # last-execntion = Test-execution.get-lastest-test-of-box box._id
  last-execution =
    test-plan : 'b36自动洗测试'
    tester : '李斯斯'
    result : '通过'
    end-time : '三天前'

  current-execution =
    test-plan : 't121双速洗测试'
    tester : '赵武'
    total-steps : 16
    completed-steps : 3
    start-time : "3'12''"
    estimate-end-time : "5'31''"

  r = Math.random! 
  switch
  | r < 0.3         =>  box.last-execution = last-execution 
  | 0.3 < r < 0.8   =>  box.current-execution = current-execution
  | otherwise       =>  # brand-new

  box 

angular.module 'app.test'

  .config ($state-provider, $translate-partial-loader-provider, ms-navigation-service-provider)!->
    

    $state-provider.state 'app.test.boxes', {
      url: '/test/boxes'
      resolve: data: (api-resolver)-> api-resolver.resolve('testBoxes@get')
      views:
        'content@app':
          template-url: 'app/main/test/box/list/test-boxes.html'
          # controller: (boxes, $scope)!->
          controller-as: 'vm'
          controller: (data, $scope)!->
            console.log "boxes: ", data
            @boxes = create-boxes data.boxes
    }

