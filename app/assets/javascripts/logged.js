var appModule = angular.module('logged', []);

appModule.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

function LoggedController($scope,$http,$location) {
    
    url = $location.url($location.path());
    $scope.getState= function(){
	$http.get(url + '/state').
	    success(function(data){
		$scope.state = data;
	    });};

    $scope.createGame = function(){
	$http.post(url+'/create').
	    success(function(data){
		$scope.state = data;
	    });
    };
    
    $scope.cancelGame = function(){

	$http.post(url+'/cancel').
	    success(function(data){
		$scope.state = data;
	    });
    };
    
    $scope.getState();
};

