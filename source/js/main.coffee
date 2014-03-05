angular.module 'sasuli', ['ngRoute']
# angular.module 'sasuli', ['ngRoute', 'ngClipboard']


# .config ['ngClipProvider', (ngClipProvider) ->
#   ngClipProvider.setPath('/js/zero-clipboard/ZeroClipboard.swf')
# ]


.controller 'TopCtrl', ['$scope', '$location', ($scope, $location) ->
  $scope.services =
    none: false
    hateblo: false

  $scope.selected = 'none'

  matchServiceName = $location.absUrl().match /\?s=(.+)$/
  if matchServiceName? and $scope.services[matchServiceName[1]]?
    $scope.services[matchServiceName[1]] = true
    $scope.selected = matchServiceName[1]
  else
    $scope.services['none'] = true

  $scope.select = (name) ->
    return if name is $scope.selected
    $scope.services[$scope.selected] = false
    $scope.services[name] = true
    $scope.selected = name
]

.controller 'PageCtrl', ['$scope', '$location', ($scope, $location) ->
  $scope.selected = ''
  $scope.selector = ''
  $scope.ing = 'css'
  $scope.hoge = ->
    $scope.getCopy()

  matchServiceName = $location.absUrl().match /([^\/]+)\/\?s=(.+)$/
  if matchServiceName?
    switch matchServiceName[2]
      when 'hateblo'
        $scope.selected = 'hateblo'
        switch matchServiceName[1]
          when 'search'
            $scope.selector = '.search-form'
          else
            $scope.selector = '.entry-content'
]

.controller 'CodeCtrl', ['$scope', ($scope) ->
  $scope.$on 'ing', (scope, lang) ->
    $scope.ing = lang
]

# .directive 'copyBtn', ['$timeout', ($timeout) ->
#   controller: 'CodeCtrl'
#   link: (scope, elem, attr) ->
#     getCode = ->
#       alert elem[0].nextElementSibling.innerText.replace /\n{3,}/g, "\n"
#       elem[0].nextElementSibling.innerText.replace /\n{3,}/g, "\n"

#     scope.copyCode = ->
#       alert getCode()
#       getCode()

# ]