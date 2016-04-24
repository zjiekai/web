'use strict'

angular.module 'app.test', []
.factory 'testsService', (api-resolver)->
	cache = {}
	temp = {}
	tests-service =
		# 从json中载入数据
		prepare-data: ->
			console.log 'pre-prepare'
			api-resolver.resolve("testBoxes@get")
						.then (data)->
							console.log 'prepare!'
							temp.boxes = data.boxes
							api-resolver.resolve("testExecutions@get")
										.then (data)~>
											temp.executions = data.executions

		#获取所有boxes
		get-boxes: ->
			cosole.log "!temp.boxes"+temp.boxes
			if !temp.boxes
				@prepare-data()
				.then ->
					console.log "get-boxes:"+cache.boxes
					cache.boxes = @create-boxes! if !cache.boxes
			else
				Promise.resolve cache.boxes
		#获取第id个盒子
		get-box: (id) ->
			console.log "id:"+id
			if !cache.boxes
				@prepare-data()
				.then ~>
					cache.boxes = @create-boxes! if !cache.boxes
					console.log cache.boxes
					cache.boxes[id-1]
			else
				Promise.resolve cache.boxes[id-1]

		create-boxes: -> [@create-box box for box in temp.boxes]

		create-box: (box)->
			#  _.filter?
			box.executions = temp.executions?filter -> it.ea-box._id is box._id
			lastExecution = (box.executions.sort (a, b)-> a.endTime > b.endTime).0
			currentExecution = @get-current-execution!
			box.lastExecution = lastExecution
			box.currentExecution = currentExecution
			box


		get-current-execution: ->
			test-plan : 't121双速洗测试'
			tester : '赵武'
			total-steps : 16
			completed-steps : 3
			start-time : "3:12'"
			estimate-end-time : "5:31'"
			step-estimate-end-time: "12'25''"

		create-execution: do ->
			(box) ->
				if (!box)
					Promise.resolve!
				else
					@get-box box
						.then (_box) ~>
							Promise.resolve @_create-execution _box

		_create-execution: (_box)->
			execution =
				_id: 1


.filter 'dateTimeFull', ->
	(date-time-number) ->
		moment.locale 'zh-cn'
		(moment new Date date-time-number).format 'lll'

