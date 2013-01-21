window.App.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/posts",
    controller: PostsIndexController

  $routeProvider.when "/posts/:id",
    controller: PostsShowController

